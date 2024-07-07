public with sharing class UniversityTableLazyLoadingController {
    @AuraEnabled(cacheable=true)
    public static List<UniversityWrapper> getUniversities(Integer limitSize, Integer offset, Integer serialNumber) {
        try{
            List<UniversityWrapper> universityList = new List<UniversityWrapper>();
            Map<Id, List<College__c>> universityToCollegeMap = new Map<Id, List<College__c>>();
            Map<Id, List<Course__c>> collegeToCourseMap = new Map<Id, List<Course__c>>();
            Map<Id, List<Staff__c>> collegeToStaffMap = new Map<Id, List<Staff__c>>();

            List<University__c> universities = [SELECT Id, Name, Phone__c, Email__c, Website__c FROM University__c ORDER BY CreatedDate LIMIT :limitSize OFFSET :offset];
            List<College__c> collegeList = [SELECT Id, Name, Email__c, Phone__c, University__c, Website__c FROM College__c WHERE University__c != null];
            List<Staff__c> staffList = [SELECT Id, Name, Email__c, College__c, Salary__c FROM Staff__c WHERE College__c != null];
            List<Course__c> courseList = [SELECT Id, Name, Code__c, College__c, Fee__c FROM Course__c WHERE College__c != null];

            for(College__c college : collegeList) {
                if(!universityToCollegeMap.containsKey(college.University__c)) {
                    universityToCollegeMap.put(college.University__c, new List<College__c>());
                }
                universityToCollegeMap.get(college.University__c).add(college);
            }

            for(Staff__c staff : staffList) {
                if(!collegeToStaffMap.containsKey(staff.College__c)) {
                    collegeToStaffMap.put(staff.College__c, new List<Staff__c>());
                }
                collegeToStaffMap.get(staff.College__c).add(staff);
            }
            
            for(Course__c course : courseList) {
                if(!collegeToCourseMap.containsKey(course.College__c)) {
                    collegeToCourseMap.put(course.College__c, new List<Course__c>());
                }
                collegeToCourseMap.get(course.College__c).add(course);
            }
            
            // Integer serialNumber = 0;  

            for(University__c university : universities) {
                if(universityToCollegeMap.containsKey(university.Id)) {
                    for(College__c college : universityToCollegeMap.get(university.Id)) {
                        List<Course__c> courses = collegeToCourseMap.containsKey(college.Id) ? collegeToCourseMap.get(college.Id) : new List<Course__c>();
                        List<Staff__c> staffs = collegeToStaffMap.containsKey(college.Id) ? collegeToStaffMap.get(college.Id) : new List<Staff__c>();

                        Integer maxRows = courses.size() > staffs.size() ? courses.size() : staffs.size();

                        for(Integer i = 0; i < maxRows; i++) {
                            UniversityWrapper universityWrapper = new UniversityWrapper();
                            universityWrapper.UniversityId = university.Id;
                            universityWrapper.SerialNumber = ++serialNumber;
                            universityWrapper.UniversityName = university.Name;
                            universityWrapper.UniversityPhone = university.Phone__c;
                            universityWrapper.UniversityEmail = university.Email__c;
                            universityWrapper.UniversityWebsite = university.Website__c;
                            universityWrapper.UniversityLink = '/' + university.Id;
                            universityWrapper.CollegeId = college.Id;
                            universityWrapper.CollegeName = college.Name;
                            universityWrapper.CollegeEmail = college.Email__c;
                            universityWrapper.CollegePhone = college.Phone__c;
                            universityWrapper.CollegeWebsite = college.Website__c;
                            universityWrapper.CollegeLink = '/' + college.Id;

                            if(i < courses.size()) {
                                universityWrapper.CourseFee = courses[i].Fee__c;
                                universityWrapper.CourseId = courses[i].Id;
                                universityWrapper.CourseName = courses[i].Name;
                                universityWrapper.CourseCode = courses[i].Code__c;
                                universityWrapper.CourseLink = '/' + courses[i].Id;
                            }

                            if(i < staffs.size()) {
                                universityWrapper.StaffId = staffs[i].Id;
                                universityWrapper.StaffName = staffs[i].Name;
                                universityWrapper.StaffSalary = staffs[i].Salary__c;
                                universityWrapper.StaffEmail = staffs[i].Email__c;
                                universityWrapper.StaffLink = '/' + staffs[i].Id;
                            }
                            
                            universityList.add(universityWrapper);
                        }
                    }
                } else {
                    UniversityWrapper universityWrapper = new UniversityWrapper();
                    universityWrapper.UniversityId = university.Id;
                    universityWrapper.SerialNumber = ++serialNumber;
                    universityWrapper.UniversityName = university.Name;
                    universityWrapper.UniversityPhone = university.Phone__c;
                    universityWrapper.UniversityEmail = university.Email__c;
                    universityWrapper.UniversityWebsite = university.Website__c;
                    universityWrapper.UniversityLink = '/' + university.Id;
                    universityList.add(universityWrapper);
                }
            }
            return universityList;
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    public class UniversityWrapper {
        @AuraEnabled
        public Integer SerialNumber {get;set;}
        @AuraEnabled
        public String UniversityId {get;set;}
        @AuraEnabled
        public String UniversityName {get;set;}
        @AuraEnabled
        public String UniversityPhone {get;set;}
        @AuraEnabled
        public String UniversityEmail {get;set;}
        @AuraEnabled
        public String UniversityWebsite {get;set;}
        @AuraEnabled
        public String CollegeId {get;set;}
        @AuraEnabled
        public String CollegeName {get;set;}
        @AuraEnabled
        public String CollegeEmail {get;set;}
        @AuraEnabled
        public String CollegePhone {get;set;}
        @AuraEnabled
        public String CollegeWebsite {get;set;}
        @AuraEnabled
        public String StaffId {get;set;}
        @AuraEnabled
        public String StaffName {get;set;}
        @AuraEnabled
        public String StaffEmail {get;set;}
        @AuraEnabled
        public Decimal StaffSalary {get;set;}
        @AuraEnabled
        public String CourseId {get;set;}
        @AuraEnabled
        public String CourseName {get;set;}
        @AuraEnabled
        public String CourseCode {get;set;}
        @AuraEnabled
        public Decimal CourseFee {get;set;}
        @AuraEnabled
        public String UniversityLink {get;set;}
        @AuraEnabled
        public String CollegeLink {get;set;}
        @AuraEnabled
        public String StaffLink {get;set;}
        @AuraEnabled
        public String CourseLink {get;set;}
    }
}