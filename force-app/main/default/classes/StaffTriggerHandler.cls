public with sharing class StaffTriggerHandler {
    
    public static void afterInsert(List<Staff__c> newList) {
        Set<Id> collegeIds = new Set<Id>();
        for(Staff__c staff : newList) {
            if(staff.College__c != null) {
                collegeIds.add(staff.College__c);
            }
        }
        countStaff(collegeIds);
    }

    public static void afterDelete(List<Staff__c> oldList) {    
        Set<Id> collegeIds = new Set<Id>();
        for(Staff__c staff : oldList) {
            if(staff.College__c != null) {
                collegeIds.add(staff.College__c);
            }
        }
        countStaff(collegeIds);
    }

    public static void afterUpdate(List<Staff__c> newList, Map<Id, Staff__c> oldMap) {
        Set<Id> collegeIds = new Set<Id>();
        Map<Id, Decimal> collegeIdToSum = new Map<Id, Decimal>();
        Map<Id, Decimal> collegeIdToCount = new Map<Id, Decimal>();
        List<College__c> collegesToUpdate = new List<College__c>();
        for(Staff__c staff: newList) {
            if(Staff__c.College__c != null && staff.Salary__c != oldMap.get(staff.Id).Salary__c) {
                collegeIds.add(staff.College__c);
                collegeIdToSum.put(staff.College__c, 0);
                collegeIdToCount.put(staff.College__c, 0);
            }
        }
        // List<Staff__c> allRelatedstaff = [SELECT Id, Salary__c FROM Staff__c WHERE College__c IN: collegeIds];
        // for(Id colId: collegeIds) {
        //     College__c newCol = new College__c();
        //     newCol.Id = colId;
        //     Decimal sum = 0;
        //     Decimal numOfStaff = allRelatedstaff.size();
        //     for(Staff__c staff: allRelatedstaff) {
        //         Decimal Salary = staff.Salary__c != null ? staff.Salary__c : 0;
        //         sum = sum + Salary;
        //     }
        //     newCol.Average_Salary__c = sum/numOfStaff;
        //     collegesToUpdate.add(newCol);
        // }
        // update collegesToUpdate;

        for(Staff__c staff: [SELECT Id, Salary__c, College__c FROM Staff__c WHERE College__c IN :collegeIds]){
            Decimal salary = staff.Salary__c != null ? staff.Salary__c : 0;
            collegeIdToSum.put(staff.College__c, collegeIdToSum.get(staff.College__c) + salary);
            collegeIdToCount.put(staff.College__c, collegeIdToCount.get(staff.College__c) + 1);
        }
        for(Id colId: collegeIds) {
            College__c col = new College__c();
            col.Id = colId;
            Decimal sum = collegeIdToSum.get(colId);
            Decimal count = collegeIdToCount.get(colId);
            col.Average_Salary__c = count > 0 ? sum/count : 0;
            collegesToUpdate.add(col);
        }
        update collegesToUpdate;
    }


    public static void countStaff(Set<Id> collegeIds){
        List<College__c> collegeList = [SELECT University__c FROM College__c WHERE Id IN :collegeIds];
        Set<Id> universityIds = new Set<Id>();
        for(College__c col: collegeList) {
            if(col.University__c != null) {
                universityIds.add(col.University__c);
            }
        }
        // List<College__c> allColleges = [SELECT University__c FROM College__c WHERE University__c IN :universityIds];
        // Map<Id, Decimal> universityToStaffCountMap = new Map<Id, Decimal>();
        // List<AggregateResult> AggResult = [SELECT College__r.University__c, Count(Id) staffCount FROM Staff__c WHERE College__c IN :allColleges GROUP BY College__r.University__c];
        // for(AggregateResult ar: AggResult) {
        //     universityToStaffCountMap.put((Id) ar.get('university__c'), (Decimal) ar.get('staffCount'));
        // }
        // List<university__c> universitiesToUpdate = new List<university__c>();
        // for(Id universityId: universityIds) {
        //     Decimal count = 0;
        //     university__c univ = new university__c();
        //     univ.Id = universityId;
        //     univ.Number_of_Total_Staff_in_all_Colleges__c = universityToStaffCountMap.containsKey(universityId) ? universityToStaffCountMap.get(universityId) : 0;
        //     universitiesToUpdate.add(univ);
        // }
        // update universitiesToUpdate;

        // List<university__c> universityList = [SELECT Id, Number_of_Total_Staff_in_all_Colleges__c, (SELECT Id FROM Colleges__r) FROM university__c WHERE Id IN :universityIds];
        // List<College__c> allColleges = [SELECT Id, (SELECT Id FROM Staffs__r) FROM College__c WHERE University__c IN :UniversityIds];
        // Map<Id, Decimal> collegeToStaffMap = new Map<Id, Decimal>();
        // for(College__c col: allColleges){
        //     if(col.Staffs__r != null){
        //         collegeToStaffMap.put(col.Id, col.Staffs__r.size());
        //     }
        // }
        // List<university__c> universitiesToUpdate = new List<university__c>();
        // for(university__c univ: universityList){
        //     Decimal count = 0;
        //     for(College__c col:univ.Colleges__r){
        //         if(collegeToStaffMap.containsKey(col.Id)){
        //             count = count + collegeToStaffMap.get(col.Id);
        //         }
        //     }
        //     univ.Number_of_Total_Staff_in_all_Colleges__c = count;
        //     universitiesToUpdate.add(univ);
        // }
        // update universitiesToUpdate;

        // Map<Id, List<College__c>> universityToCollegeMap = new Map<Id, List<College__c>>();
        // Map<Id, List<Staff__c>> collegeToStaffMap = new Map<Id, List<Staff__c>>();
        // List<University__c> universityList = [SELECT Id, Number_of_Colleges__c FROM university__c WHERE Id IN :universityIds];
        // List<College__c> colList = [SELECT Id, university__c FROM College__c WHERE university__c IN :universityList];
        // List<Staff__c> staffList = [SELECT Id, College__c FROM Staff__c WHERE College__c IN :colList];
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
        // for(Staff__c staff: staffList) {
        //     if(collegeToStaffMap.containsKey(staff.College__c)) {
        //         collegeToStaffMap.get(staff.College__c).add(staff);
        //     }else{
        //         List<Staff__c> colStaffs = new List<Staff__c>();
        //         colStaffs.add(staff);
        //         collegeToStaffMap.put(staff.College__c, colStaffs);
        //     }
        // }
        // for(Id universityId: universityToCollegeMap.keyset()){
        //     university__c univ = new university__c();
        //     univ.Id = universityId;
        //     Decimal count = 0;
        //     for(College__c col: universityToCollegeMap.get(universityId)){
        //         Decimal staffCount = collegeToStaffMap.containsKey(col.Id) ? collegeToStaffMap.get(col.Id).size() : 0;
        //         count = count + staffCount;
        //     }
        //     univ.Number_of_Total_Staff_in_all_Colleges__c = count;
        //     universitiesToUpdate.add(univ);
        // }
        // update universitiesToUpdate;

        UniversityUtils.calculationOnUniversity(universityIds);

    }
}