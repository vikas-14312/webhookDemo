import { LightningElement, wire, track } from 'lwc';
import getUniversities from '@salesforce/apex/UniversityTableLazyLoadingController.getUniversities';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import UNIVERSITY_NAME_FIELD from '@salesforce/schema/University__c.Name';
import UNIVERSITY_EMAIL_FIELD from '@salesforce/schema/University__c.Email__c';
import UNIVERSITY_PHONE_FIELD from '@salesforce/schema/University__c.Phone__c';
import UNIVERSITY_WEBSITE_FIELD from '@salesforce/schema/University__c.Website__c';
import COLLEGE_NAME_FIELD from '@salesforce/schema/College__c.Name';
import COLLEGE_EMAIL_FIELD from '@salesforce/schema/College__c.Email__c';
import COLLEGE_PHONE_FIELD from '@salesforce/schema/College__c.Phone__c';
import COLLEGE_WEBSITE_FIELD from '@salesforce/schema/College__c.Website__c';
import COLLEGE_UNIVERSITY_FIELD from '@salesforce/schema/College__c.University__c';
import COLLEGE_UNIVERSITY_EMAIL_FIELD from '@salesforce/schema/College__c.University_Email__c'; 
import COLLEGE_FULLNAME_FIELD from '@salesforce/schema/College__c.Full_Name__c';
import STAFF_NAME_FIELD from '@salesforce/schema/Staff__c.Name';
import STAFF_EMAIL_FIELD from '@salesforce/schema/Staff__c.Email__c';
import STAFF_FIRSTNAME_FIELD from '@salesforce/schema/Staff__c.First_Name__c';
import STAFF_LASTNAME_FIELD from '@salesforce/schema/Staff__c.Last_Name__c';
import STAFF_COLLEGE_FIELD from '@salesforce/schema/Staff__c.College__c';
import STAFF_SALARY_FIELD from '@salesforce/schema/Staff__c.Salary__c';
import COURSE_NAME_FIELD from '@salesforce/schema/Course__c.Name';
import COURSE_CODE_FIELD from '@salesforce/schema/Course__c.Code__c';
import COURSE_COLLEGE_FIELD from '@salesforce/schema/Course__c.College__c';
import COURSE_FEE_FIELD from '@salesforce/schema/Course__c.Fee__c';
import UNIVERSITY_OBJECT from '@salesforce/schema/University__c';
import COLLEGE_OBJECT from '@salesforce/schema/College__c';
import STAFF_OBJECT from '@salesforce/schema/Staff__c';
import COURSE_OBJECT from '@salesforce/schema/Course__c';

const columns = [
    { label: 'Sr. No.', fieldName: 'SerialNumber', type: 'text', sortable: true, initialWidth: 100, },
    { label: 'University Name', fieldName: 'UniversityLink', type: 'url', sortable: true, typeAttributes: {label: { fieldName: 'UniversityName'}, value: { fieldName: 'UniversityLink'}, target: '_blank'} },
    { label: 'University Email', fieldName: 'UniversityEmail', type: 'email', sortable: true },
    { label: 'University Phone', fieldName: 'UniversityPhone', type: 'phone', sortable: true },
    { label: 'University Website', fieldName: 'UniversityWebsite', type: 'url', sortable: true },
    { label: 'College Name', fieldName: 'CollegeLink', type: 'url', sortable: true, typeAttributes: {label: { fieldName: 'CollegeName'}, value: { fieldName: 'CollegeLink'}, target: '_blank'} },
    { label: 'College Email', fieldName: 'CollegeEmail', type: 'email', sortable: true },
    { label: 'College Phone', fieldName: 'CollegePhone', type: 'phone', sortable: true },
    { label: 'College Website', fieldName: 'CollegeWebsite', type: 'url', sortable: true },
    { label: 'Course Name', fieldName: 'CourseLink', type: 'url', sortable: true, typeAttributes: {label: { fieldName: 'CourseName'}, value: { fieldName: 'CourseLink'}, target: '_blank'} },
    { label: 'Course Code', fieldName: 'CourseCode', type: 'text', sortable: true },
    { label: 'Course Fee', fieldName: 'CourseFee', type: 'currency', sortable: true },
    { label: 'Staff Name', fieldName: 'StaffLink', type: 'url', sortable: true, typeAttributes: {label: { fieldName: 'StaffName'}, value: { fieldName: 'StaffLink'}, target: '_blank'} },
    { label: 'Staff Email', fieldName: 'StaffEmail', type: 'email', sortable: true },
    { label: 'Staff Salary', fieldName: 'StaffSalary', type: 'currency', sortable: true },
    {
        type: "button", label: 'Edit', initialWidth: 100, typeAttributes: {
            label: 'Edit',
            name: 'Edit',
            title: 'Edit',
            disabled: false,
            value: 'edit',
            iconPosition: 'left',
            iconName:'utility:edit',
            variant:'Brand'
        }
    },
];
export default class UniversityTableLazyLoading extends LightningElement {

    showSpinner = false;
    @track data = [];
    columns = columns;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    universityId;
    collegeId;
    staffId;
    courseId;
    showEditModal = false;
    universityName = UNIVERSITY_NAME_FIELD;
    universityEmail = UNIVERSITY_EMAIL_FIELD;
    universityPhone = UNIVERSITY_PHONE_FIELD;
    universityWebsite = UNIVERSITY_WEBSITE_FIELD;
    collegeName = COLLEGE_NAME_FIELD;
    collegeEmail = COLLEGE_EMAIL_FIELD;
    collegePhone = COLLEGE_PHONE_FIELD;
    collegeWebsite = COLLEGE_WEBSITE_FIELD;
    collegeUniversity = COLLEGE_UNIVERSITY_FIELD;
    collegeUniversityEmail = COLLEGE_UNIVERSITY_EMAIL_FIELD;
    collegeFullName = COLLEGE_FULLNAME_FIELD;
    staffName = STAFF_NAME_FIELD;
    staffEmail = STAFF_EMAIL_FIELD;
    staffFirstName = STAFF_FIRSTNAME_FIELD;
    staffLastName = STAFF_LASTNAME_FIELD;
    staffCollege = STAFF_COLLEGE_FIELD;
    staffSalary = STAFF_SALARY_FIELD;
    courseName = COURSE_NAME_FIELD;
    courseCode = COURSE_CODE_FIELD;
    courseCollege = COURSE_COLLEGE_FIELD;
    courseFee = COURSE_FEE_FIELD;
    universityObject = UNIVERSITY_OBJECT;
    collegeObject = COLLEGE_OBJECT;
    staffObject = STAFF_OBJECT;
    courseObject = COURSE_OBJECT;
    universityNameValue;
    universityEmailValue;
    universityPhoneValue;
    universityWebsiteValue;
    collegeNameValue;
    collegeEmailValue;
    collegePhoneValue;
    collegeWebsiteValue;
    collegeUniversityValue;
    collegeUniversityEmailValue;
    collegeFullNameValue;
    staffNameValue;
    staffEmailValue;
    staffFirstNameValue;
    staffLastNameValue;
    staffCollegeValue;
    staffSalaryValue;
    courseNameValue;
    courseCodeValue;
    courseCollegeValue;
    courseFeeValue;
    showCourseForm = true;
    showCollegeForm = true;
    showStaffForm = true;
    showUniversityForm = true;
    @track allData = [];
    allFormSubmitted = false;
    rowOffSet = 0;
    rowLimit = 25;
    loadMoreStatus;
    
    connectedCallback() {
        this.getUniversityData();
    }

    // get getDataLength() {
    //     return this.data.length;
    // }
    // @wire(getUniversities, { limitSize: '$rowLimit' , offset : '$rowOffSet', serialNumber : '$getDataLength' })
    // wiredUniversities(result) {
    //     this.allData = result;
    //     let data = result.data;
    //     let error = result.error;
    //     if (data) {
    //         console.log(data);
    //         // this.data = data;
    //     } else if (error) {
    //         console.log(error);
    //     }
    // }

    getUniversityData() {
        return getUniversities({ limitSize: this.rowLimit , offset : this.rowOffSet, serialNumber : this.data.length })
            .then(result => {
                if(result.length === 0) {
                    this.loadMoreStatus = 'No more data to fetch';
                } else {
                    this.loadMoreStatus = '';
                }
                let updatedRecords = [...this.data, ...result];
                this.data = updatedRecords;
            })
            .catch(error => {
                console.log(error);
            });
    }

    loadMoreData(event) {
        const currentRecord = this.data;
        let {target} = event;
        target.isLoading  = true;
        this.rowOffSet = this.rowOffSet + this.rowLimit;
        this.getUniversityData()
            .then(() => {
                target.isLoading  = false;
            })
    }


    openEditModal(event) {
        this.showEditModal = true;
        this.data.forEach(item => {
            if (event.detail.row.SerialNumber === item.SerialNumber) {
                this.universityNameValue = item.UniversityName;
                this.universityEmailValue = item.UniversityEmail;
                this.universityPhoneValue = item.UniversityPhone;
                this.universityWebsiteValue = item.UniversityWebsite;
                this.collegeNameValue = item.CollegeName;
                this.collegeEmailValue = item.CollegeEmail;
                this.collegePhoneValue = item.CollegePhone;
                this.collegeWebsiteValue = item.CollegeWebsite;
                this.collegeUniversityValue = item.CollegeUniversity;
                this.collegeUniversityEmailValue = item.CollegeUniversityEmail;
                this.collegeFullNameValue = item.CollegeFullName;
                this.staffNameValue = item.StaffName;
                this.staffEmailValue = item.StaffEmail;
                this.staffFirstNameValue = item.StaffFirstName;
                this.staffLastNameValue = item.StaffLastName;
                this.staffCollegeValue = item.StaffCollege;
                this.staffSalaryValue = item.StaffSalary;
                this.courseNameValue = item.CourseName;
                this.courseCodeValue = item.CourseCode;
                this.courseCollegeValue = item.CourseCollege;
                this.courseFeeValue = item.CourseFee;
                this.universityId = item.UniversityId;
                this.collegeId = item.CollegeId;
                this.staffId = item.StaffId;
                this.courseId = item.CourseId;
                if(!item.CourseId) {
                    this.showCourseForm = false;
                }else {
                    this.showCourseForm = true;
                }

                if(!item.CollegeId) {
                    this.showCollegeForm = false;
                } else {
                    this.showCollegeForm = true;
                }

                if(!item.StaffId) {
                    this.showStaffForm = false;
                } else {
                    this.showStaffForm = true;
                }
            }
        })
    }

    handleSave() {
        this.showSpinner = true;
        this.template.querySelectorAll('lightning-record-edit-form').forEach(form => {
            form.submit();
        });
        this.showToast('Success!', 'Record has been updated successfully', 'success');
    }

    handleUniversitysuccess(event) {
        this.showSpinner = false;
        this.showEditModal = false;
        // refreshApex(this.allData);
        getUniversities({ limitSize: this.rowLimit , offset : this.rowOffSet, serialNumber : this.data.length })
            .then(result => {
                let updatedRecords = [...this.data, ...result];
                this.data = updatedRecords;
                console.log(JSON.stringify(this.data));
            })
            .catch(error => {
                console.log(error);
            });
    }

    handleCollegesuccess(event) {
        this.showEditModal = false;
        this.showSpinner = false;
        // refreshApex(this.allData);
        this.getUniversityData()
        
    }

    handleStaffsuccess(event) {
        this.showSpinner = false;
        this.showEditModal = false;
        // refreshApex(this.allData);
        this.getUniversityData()
        
    }

    handleCoursesuccess(event) {
        this.showSpinner = false;
        this.showEditModal = false;
        // refreshApex(this.allData);
        this.getUniversityData()
          
    }

    // handleUniversityError(event) {
    //     this.showSpinner = false;
    //     this.allFormSubmitted = false;
    //     this.showToast('Error!', event.detail.body.message, 'error');
    // }

    // handleCollegeError(event) {
    //     this.showSpinner = false;
    //     this.allFormSubmitted = false;
    //     this.showToast('Error!', event.detail.body.message, 'error');
    // }

    // handleStaffError(event) {
    //     this.showSpinner = false;
    //     this.allFormSubmitted = false;
    //     this.showToast('Error!', event.detail.body.message, 'error');
    // }

    // handleCourseError(event) {
    //     this.showSpinner = false;
    //     this.allFormSubmitted = false;
    //     this.showToast('Error!', event.detail.body.message, 'error');
    // }
    

    closeEditModal() {
        this.showEditModal = false;
    }

    sortBy(field, reverse, primer) {
        const key = primer
            ? function (x) {
                  return primer(x[field]);
              }
            : function (x) {
                  return x[field];
              };

        return function (a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }

    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.data];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.data = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        )
    }
}