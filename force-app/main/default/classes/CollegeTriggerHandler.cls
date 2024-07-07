public with sharing class CollegeTriggerHandler {
    public static void afterInsert(List<College__c> newList) {
        Set<Id> universityIds = new Set<Id>();
        for(College__c col : newList) {
            if(col.University__c != null) {
                universityIds.add(col.University__c);
            }
        }
        
        // countColleges(universityIds);
        UniversityUtils.calculationOnUniversity(universityIds);
    }

    public static void afterDelete(List<College__c> oldList) {
        Set<Id> universityIds = new Set<Id>();
        for(College__c col : oldList) {
            if(col.University__c != null) {
                universityIds.add(col.University__c);
            }
        }
        // countColleges(universityIds);
        UniversityUtils.calculationOnUniversity(universityIds);
    }


    public static void countColleges(Set<Id> universityIds) {
        // List<AggregateResult> universityList = [SELECT University__c, COUNT(Id) total FROM College__c WHERE University__c IN :universityIds GROUP BY University__c];
        // Map<Id, Integer> universityToCollegeCountMap = new Map<Id, Integer>();
        // List<University__c> universityListToUpdate = new List<University__c>();
        // for(AggregateResult ar : universityList) {
        //     universityToCollegeCountMap.put((Id) ar.get('University__c'), (Integer) ar.get('total'));
        // }        
        // for(Id universityId: universityIds) {
        //     University__c uni = new University__c();
        //     uni.Id = universityId;
        //     uni.Number_of_Colleges__c = universityToCollegeCountMap.containsKey(universityId) ? universityToCollegeCountMap.get(universityId) : 0;
        //     universityListToUpdate.add(uni);
        // }
        // update universityListToUpdate;


        // if(!universityIds.isEmpty()){
        //     List<University__c> universityList = [SELECT Id, Number_of_Colleges__c, (SELECT Id FROM Colleges__r) FROM university__c WHERE Id IN :universityIds];
        //     List<university__c> universitiesToUpdate = new  List<university__c>();
        //     if(!universityList.isEmpty()){
        //         for(university__c univ: universityList) {
        //             univ.Number_of_Colleges__c = univ.Colleges__r.size();
        //             universitiesToUpdate.add(univ);
        //         }
        //         update universitiesToUpdate;
        //     }
        // }

        if(!universityIds.isEmpty()){
            Map<Id, List<College__c>> universityToCollegeMap = new Map<Id, List<College__c>>();
            Map<Id, Id> collegeIdWithuniversityId = new Map<Id, Id>();
            List<University__c> universityList = [SELECT Id, Number_of_Colleges__c FROM university__c WHERE Id IN :universityIds];
            List<College__c> collegeList = [SELECT Id, university__c FROM College__c WHERE university__c IN :universityList];
            List<university__c> universitiesToUpdate = new  List<university__c>();

            // for( College__c col: collegeList ){

            //     collegeIdWithuniversityId.put(col.Id, col.university__c);

            //     if( !universityToCollegeMap.containsKey(col.university__c) ){
            //         universityToCollegeMap.put(col.university__c, new List<College__c>());
            //     }
            //     List<College__c> colleges = universityToCollegeMap.get(col.university__c).add(col);
            //     universityToCollegeMap.put(col.university__c, colleges);
            // }



            for(College__c col: collegeList) {
                if(universityToCollegeMap.containsKey(col.university__c)) {
                    universityToCollegeMap.get(col.university__c).add(col);
                }else{
                    List<College__c> univColleges = new List<College__c>();
                    univColleges.add(col);
                    universityToCollegeMap.put(col.university__c, univColleges);
                }
            }
            
            for(university__c univ : universityList) {
                univ.Number_of_Colleges__c = universityToCollegeMap.get(univ.Id).size();
                universitiesToUpdate.add(univ);
            }
            // for(Id universityId: universityToCollegeMap.keyset()){
            //     university__c univ = new university__c();
            //     univ.Number_of_Colleges__c = universityToCollegeMap.get(univ.Id).size();
            //     universitiesToUpdate.add(univ);
            // }
            update universitiesToUpdate;
        }
    }
}