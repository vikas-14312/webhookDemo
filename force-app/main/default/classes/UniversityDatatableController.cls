public with sharing class UniversityDatatableController {
    @AuraEnabled(cacheable=true)
    public static List<UniversityWrapper> getAllUniversity() {
        List<UniversityWrapper> universityList = new List<UniversityWrapper>();
        Map<Id, List<College__c>> universityToCollegeMap = new Map<Id, List<College__c>>();
        Map<Id, List<Course__c>> collegeToCourseMap = new Map<Id, List<Course__c>>();
        Map<Id, List<Staff__c>> collegeToStaffMap = new Map<Id, List<Staff__c>>();

        List<University__c> universities = [SELECT Id, Name,   Phone__c, Email__c, Website__c  FROM University__c];        
        List<College__c> collegeList = [SELECT Id, Name, Email__c, Phone__c, University__c, Website__c FROM College__c WHERE University__c != null];
        List<Staff__c> staffList = [SELECT Id, Name, Email__c, College__c, Salary__c FROM Staff__c WHERE College__c != null];
        List<Course__c> courseList = [SELECT Id, Name, Code__c, College__c, Fee__c FROM Course__c WHERE College__c != null];

        for(College__c college : collegeList) {
            if(college.university__c != null) {
                if(!universityToCollegeMap.containsKey(college.university__c)) {
                    universityToCollegeMap.put(college.university__c, new List<College__c>());
                }
                universityToCollegeMap.get(college.university__c).add(college);
            }
        }

        for(Staff__c staff : staffList) {
            if(staff.College__c != null) {
                if(!collegeToStaffMap.containsKey(staff.College__c)) {
                    collegeToStaffMap.put(staff.College__c, new List<Staff__c>());
                }
                collegeToStaffMap.get(staff.College__c).add(staff);
            }
        }

        for(Course__c course : courseList) {
            if(course.College__c != null) {
                if(!collegeToCourseMap.containsKey(course.College__c)) {
                    collegeToCourseMap.put(course.College__c, new List<Course__c>());
                }
                collegeToCourseMap.get(course.College__c).add(course);
            }
        }

        for(university__c university : universities) {
            UniversityWrapper universityWrapper = new universityWrapper();
            universityWrapper.Id = university.Id;
            universityWrapper.Name = university.Name;
            universityWrapper.Email = university.Email__c;
            universityWrapper.Phone = university.Phone__c;
            universityWrapper.Website = university.Website__c;

            List<College__c> relatedColleges = universityToCollegeMap.containsKey(university.Id) ? universityToCollegeMap.get(university.Id) : new List<College__c>();
            system.debug(relatedColleges);
            for(College__c college : relatedColleges) {
                CollegeWrapper collegeWrapper = new CollegeWrapper();
                collegeWrapper.Id = college.Id;
                collegeWrapper.Name = college.Name;
                collegeWrapper.Email = college.Email__c;
                collegeWrapper.Phone = college.Phone__c;
                collegeWrapper.university = college.university__c;
                collegeWrapper.Website = college.Website__c;

                List<Staff__c> relatedStaff = collegeToStaffMap.containsKey(college.Id) ? collegeToStaffMap.get(college.Id) : new List<Staff__c>();
                List<Course__c> relatedCourses = collegeToCourseMap.containsKey(college.Id) ? collegeToCourseMap.get(college.Id) : new List<Course__c>();

                for(Staff__c staff : relatedStaff) {
                    StaffWrapper staffWrapper = new StaffWrapper();
                    staffWrapper.Id = staff.Id;
                    staffWrapper.Name = staff.Name;
                    staffWrapper.salary = staff.Salary__c;
                    staffWrapper.college = staff.College__c;
                    staffWrapper.Email = staff.Email__c;
                    collegeWrapper.staff.add(staffWrapper);
                }

                for(Course__c course : relatedCourses) {
                    CourseWrapper courseWrapper = new CourseWrapper();
                    courseWrapper.Id = course.Id;
                    courseWrapper.Name = course.Name;
                    courseWrapper.Fee = course.Fee__c;
                    courseWrapper.college = course.College__c;
                    courseWrapper.Code = course.Code__c;
                    collegeWrapper.courses.add(courseWrapper);
                }
                universityWrapper.colleges.add(collegeWrapper);
            }
            universityList.add(universityWrapper);
        }

        return universityList;
    }

    public class UniversityWrapper {
        @AuraEnabled
        public String Id {get;set;}
        @AuraEnabled
        public String Name {get;set;}
        @AuraEnabled
        public String Phone {get;set;}
        @AuraEnabled
        public String Email {get;set;}
        @AuraEnabled
        public String Website {get;set;}
        @AuraEnabled
        public List<CollegeWrapper> colleges {get;set;}

        public UniversityWrapper() {
            colleges = new List<CollegeWrapper>();
        }
    }

    public class CollegeWrapper {
        @AuraEnabled
        public String Id {get;set;}
        @AuraEnabled
        public String Name {get;set;}
        @AuraEnabled
        public String Email {get;set;}
        @AuraEnabled
        public String Website {get;set;}
        @AuraEnabled
        public String University {get;set;}
        @AuraEnabled
        public String Phone {get;set;}
        @AuraEnabled
        public List<StaffWrapper> Staff {get;set;}
        @AuraEnabled
        public List<CourseWrapper> Courses {get;set;}

        public CollegeWrapper() {
            Staff = new List<StaffWrapper>();
            Courses = new List<CourseWrapper>();
        }
    }

    public class StaffWrapper {
        @AuraEnabled
        public String Id {get;set;}
        @AuraEnabled
        public String Name {get;set;}
        @AuraEnabled
        public String Email {get;set;}
        @AuraEnabled
        public Decimal Salary {get;set;}
        @AuraEnabled
        public String College {get;set;}
    }

    public class CourseWrapper {
        @AuraEnabled
        public String Id {get;set;}
        @AuraEnabled
        public String Name {get;set;}
        @AuraEnabled
        public String Code {get;set;}
        @AuraEnabled
        public Decimal Fee {get;set;}
        @AuraEnabled
        public String College {get;set;}
    }
    
}