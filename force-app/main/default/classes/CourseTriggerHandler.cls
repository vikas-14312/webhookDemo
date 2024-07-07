public with sharing class CourseTriggerHandler {
    public static void afterInsert(List<Course__c> newList) {
        Set<Id> collegeIds = new Set<Id>();
        for(Course__c course : newList) {
            if(course.College__c != null) {
                collegeIds.add(course.College__c);
            }
        }
        countCourse(collegeIds);
    }

    public static void afterDelete(List<Course__c> oldList) {    
        Set<Id> collegeIds = new Set<Id>();
        for(Course__c course : oldList) {
            if(course.College__c != null) {
                collegeIds.add(course.College__c);
            }
        }
        countCourse(collegeIds);
    }

    public static void afterUpdate(List<Course__c> newList, Map<Id, Course__c> oldMap) {
        Set<Id> collegeIds = new Set<Id>();
        Map<Id, Decimal> collegeIdToSum = new Map<Id, Decimal>();
        Map<Id, Integer> collegeIdToCount = new Map<Id, Integer>();
        List<College__c> collegesToUpdate = new List<College__c>();
        for(Course__c course: newList) {
            if(Course__c.College__c != null && course.Fee__c != oldMap.get(course.Id).Fee__c) {
                collegeIds.add(course.College__c);
                collegeIdToSum.put(course.College__c, 0);
                collegeIdToCount.put(course.College__c, 0);
            }
        }
        // List<Course__c> allRelatedCourses = [SELECT Id, Fee__c FROM Course__c WHERE College__c IN: collegeIds];
        // for(Id colId: collegeIds) {
        //     College__c newCol = new College__c();
        //     newCol.Id = colId;
        //     Decimal sum = 0;
        //     Decimal numOfCourses = allRelatedCourses.size();
        //     for(Course__c course: allRelatedCourses) {
        //         Decimal fee = course.Fee__c != null ? course.Fee__c : 0;
        //         sum = sum + fee;
        //     }
        //     newCol.Average_Fees__c = sum/numOfCourses;
        //     collegesToUpdate.add(newCol);
        // }
        // update collegesToUpdate;

        for (Course__c course : [SELECT Id, Fee__c, College__c FROM Course__c WHERE College__c IN :collegeIds]) {
            Decimal fee = course.Fee__c != null ? course.Fee__c : 0;
            collegeIdToSum.put(course.College__c, collegeIdToSum.get(course.College__c) + fee);
            collegeIdToCount.put(course.College__c, collegeIdToCount.get(course.College__c) + 1);
        }
        
        for (Id colId : collegeIds) {
            College__c newCol = new College__c(Id = colId);
            Decimal sum = collegeIdToSum.get(colId);
            Integer numOfCourses = collegeIdToCount.get(colId);
            newCol.Average_Fees__c = numOfCourses > 0 ? sum / numOfCourses : 0;
            collegesToUpdate.add(newCol);
        }
    
        update collegesToUpdate;
    }


    public static void countCourse(Set<Id> collegeIds){
        List<College__c> collegeList = [SELECT University__c FROM College__c WHERE Id IN :collegeIds];
        Set<Id> universityIds = new Set<Id>();
        for(College__c col: collegeList) {
            if(col.University__c != null) {
                universityIds.add(col.University__c);
            }
        }
        // List<College__c> allColleges = [SELECT University__c FROM College__c WHERE University__c IN :universityIds];
        // Map<Id, Decimal> universityTocourseCountMap = new Map<Id, Decimal>();
        // List<AggregateResult> AggResult = [SELECT College__r.University__c, Count(Id) courseCount FROM Course__c WHERE College__c IN :allColleges GROUP BY College__r.University__c];
        // for(AggregateResult ar: AggResult) {
        //     universityTocourseCountMap.put((Id) ar.get('university__c'), (Decimal) ar.get('courseCount'));
        // }
        // List<university__c> universitiesToUpdate = new List<university__c>();
        // for(Id universityId: universityIds) {
        //     Decimal count = 0;
        //     university__c univ = new university__c();
        //     univ.Id = universityId;
        //     univ.Number_of_Total_Courses_in_all_Colleges__c = universityTocourseCountMap.containsKey(universityId) ? universityTocourseCountMap.get(universityId) : 0;
        //     universitiesToUpdate.add(univ);
        // }
        // update universitiesToUpdate;

        // List<university__c> universityList = [SELECT Id, Number_of_Total_Courses_in_all_Colleges__c, (SELECT Id FROM Colleges__r) FROM university__c WHERE Id IN :universityIds];
        // List<College__c> allColleges = [SELECT Id, (SELECT Id FROM Courses__r) FROM College__c WHERE University__c IN :UniversityIds];
        // Map<Id, Decimal> collegeToCourseMap = new Map<Id, Decimal>();
        // for(College__c col: allColleges){
        //     if(col.Courses__r != null){
        //         collegeToCourseMap.put(col.Id, col.Courses__r.size());
        //     }
        // }
        // List<university__c> universitiesToUpdate = new List<university__c>();
        // for(university__c univ: universityList){
        //     Decimal count = 0;
        //     for(College__c col:univ.Colleges__r){
        //         if(collegeToCourseMap.containsKey(col.Id)){
        //             count = count + collegeToCourseMap.get(col.Id);
        //         }
        //     }
        //     univ.Number_of_Total_Courses_in_all_Colleges__c = count;
        //     universitiesToUpdate.add(univ);
        // }
        // update universitiesToUpdate;

        // Map<Id, List<College__c>> universityToCollegeMap = new Map<Id, List<College__c>>();
        // Map<Id, List<Course__c>> collegeToCourseMap = new Map<Id, List<Course__c>>();
        // List<University__c> universityList = [SELECT Id, Number_of_Colleges__c FROM university__c WHERE Id IN :universityIds];
        // List<College__c> colList = [SELECT Id, university__c FROM College__c WHERE university__c IN :universityList];
        // List<Course__c> courseList = [SELECT Id, College__c FROM Course__c WHERE College__c IN :colList];
        // List<university__c> universitiesToUpdate = new List<university__c>();

        // for(College__c col: colList) {
        //     if(universityToCollegeMap.containsKey(col.university__c)) {
        //         universityToCollegeMap.get(col.university__c).add(col);
        //     }else{
        //         List<College__c> univColleges = new List<College__c>();
        //         univColleges.add(col);
        //         universityToCollegeMap.put(col.university__c, univColleges);
        //     }
        // }
        // for(Course__c course: courseList) {
        //     if(collegeToCourseMap.containsKey(course.College__c)) {
        //         collegeToCourseMap.get(course.College__c).add(course);
        //     }else{
        //         List<Course__c> colCourses = new List<Course__c>();
        //         colCourses.add(course);
        //         collegeToCourseMap.put(course.College__c, colCourses);
        //     }
        // }
        // for(Id universityId: universityToCollegeMap.keyset()){
        //     university__c univ = new university__c();
        //     univ.Id = universityId;
        //     Decimal count = 0;
        //     for(College__c col: universityToCollegeMap.get(universityId)){
        //         Decimal courseCount = collegeToCourseMap.containsKey(col.Id) ? collegeToCourseMap.get(col.Id).size() : 0;
        //         count = count + courseCount;
        //     }
        //     univ.Number_of_Total_Courses_in_all_Colleges__c = count;
        //     universitiesToUpdate.add(univ);
        // }
        // update universitiesToUpdate;

        UniversityUtils.calculationOnUniversity(universityIds);

    }
}