public with sharing class UniversityTriggerHandler {

    //create college, course, staff after university insertion
    public static void afterInsert(List<University__c> newList) {
        List<College__c> collegeList = new List<College__c>();
        List<Course__c> courseList = new List<Course__c>();
        List<Staff__c> staffList = new List<Staff__c>();
        for(University__c uni : newList) {
            for(Integer i = 1; i <= 50; i++) {
                College__c college = new College__c();
                college.Name = uni.Name + ' College ' + i;
                college.University__c = uni.Id;
                collegeList.add(college);
            }
        }
        insert collegeList;
        for(College__c col : collegeList) {
            for(Integer i = 1; i <= 10; i++) {
                Course__c course = new Course__c();
                course.Name = col.Name + ' Course ' + i;
                course.College__c = col.Id;
                courseList.add(course);
                Staff__c staff = new Staff__c();
                staff.Name = col.Name + ' Staff ' + i;
                staff.College__c = col.Id;
                staffList.add(staff);    
            }
        }
        insert courseList;
        insert staffList;
    }

    //delete college, course, staff after university deletion
    public static void beforeDelete(List<University__c> oldList) {
        Set<Id> UniversityIds = new Set<Id>();
        for(University__c uni : oldList) {
            UniversityIds.add(uni.Id);
        }
        List<College__c> collegeList = [SELECT Id FROM College__c WHERE University__c IN :UniversityIds];
        List<Course__c> courseList = [SELECT Id FROM Course__c WHERE College__c IN :collegeList];
        List<Staff__c> staffList = [SELECT Id FROM Staff__c WHERE College__c IN :collegeList];
        
        delete courseList;
        delete staffList;
        delete collegeList;
        // UniversityUtils.calculationOnUniversity(universityIds);
    }
}