public with sharing class UniversityUtils {
    
    public static void calculationOnUniversity(Set<Id> universityIds) {  
        Map<Id, List<College__c>> universityToCollegeMap = new Map<Id, List<College__c>>();
        Map<Id, List<Staff__c>> collegeToStaffMap = new Map<Id, List<Staff__c>>();
        Map<Id, List<Course__c>> collegeToCourseMap = new Map<Id, List<Course__c>>();
        Map<Id, Id> collegeIdWithuniversityId = new Map<Id, Id>();
        List<University__c> universityList = [SELECT Id, Number_of_Colleges__c FROM university__c WHERE Id IN :universityIds];
        List<College__c> collegeList = [SELECT Id, university__c FROM College__c WHERE university__c IN :universityList];
        List<Staff__c> staffList = [SELECT Id, College__c FROM Staff__c WHERE College__c IN :collegeList];
        List<Course__c> courseList = [SELECT Id, College__c FROM Course__c WHERE College__c IN :collegeList];
        List<university__c> universitiesToUpdate = new  List<university__c>();
        
        for(College__c col: collegeList) {
            if(universityToCollegeMap.containsKey(col.university__c)) {
                universityToCollegeMap.get(col.university__c).add(col);
            }else{
                List<College__c> univColleges = new List<College__c>();
                univColleges.add(col);
                universityToCollegeMap.put(col.university__c, univColleges);
            }
        }
        for(Staff__c staff: staffList) {
            if(collegeToStaffMap.containsKey(staff.College__c)) {
                collegeToStaffMap.get(staff.College__c).add(staff);
            }else{
                List<Staff__c> colStaffs = new List<Staff__c>();
                colStaffs.add(staff);
                collegeToStaffMap.put(staff.College__c, colStaffs);
            }
        }
        for(Course__c course: courseList) {
            if(collegeToCourseMap.containsKey(course.College__c)) {
                collegeToCourseMap.get(course.College__c).add(course);
            }else{
                List<Course__c> colCourses = new List<Course__c>();
                colCourses.add(course);
                collegeToCourseMap.put(course.College__c, colCourses);
            }
        }
        // for(university__c univ : universityList) {
        //     univ.Number_of_Colleges__c = universityToCollegeMap.get(univ.Id).size();
        //     universitiesToUpdate.add(univ);
        // } 
        for(Id universityId: universityToCollegeMap.keyset()){
            university__c univ = new university__c();
            univ.Id = universityId;
            univ.Number_of_Colleges__c = universityToCollegeMap.get(universityId).size();
            Decimal count = 0;
            for(College__c col: universityToCollegeMap.get(universityId)){
                Decimal staffCount = collegeToStaffMap.containsKey(col.Id) ? collegeToStaffMap.get(col.Id).size() : 0;
                count = count + staffCount;
            }
            univ.Number_of_Total_Staff_in_all_Colleges__c = count;
            Decimal count2 = 0;
            for(College__c col: universityToCollegeMap.get(universityId)){
                Decimal courseCount = collegeToCourseMap.containsKey(col.Id) ? collegeToCourseMap.get(col.Id).size() : 0;
                count2 = count2 + courseCount;
            }
            univ.Number_of_Total_Courses_in_all_Colleges__c = count2;
            universitiesToUpdate.add(univ);
        }
        // for(Id universityId: universityToCollegeMap.keyset()){
        //         university__c univ = new university__c();
        //         univ.Id = universityId;
        //         Decimal count = 0;
        //         for(College__c col: universityToCollegeMap.get(universityId)){
        //             Decimal courseCount = collegeToCourseMap.containsKey(col.Id) ? collegeToCourseMap.get(col.Id).size() : 0;
        //             count = count + courseCount;
        //         }
        //         univ.Number_of_Total_Courses_in_all_Colleges__c = count;
        //         universitiesToUpdate.add(univ);
        //     }
        update universitiesToUpdate; 
    }
}