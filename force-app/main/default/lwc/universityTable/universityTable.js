import { LightningElement, wire, track } from 'lwc';
import getUniversities from '@salesforce/apex/UniversityTableController.getUniversities';
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
    { label: 'Sr. No.', fieldName: 'SerialNumber', type: 'text', sortable: true },
    { label: 'University Name', fieldName: 'UniversityName', type: 'text', sortable: true },
    { label: 'University Email', fieldName: 'UniversityEmail', type: 'email', sortable: true },
    { label: 'University Phone', fieldName: 'UniversityPhone', type: 'phone', sortable: true },
    { label: 'University Website', fieldName: 'UniversityWebsite', type: 'url', sortable: true },
    { label: 'College Name', fieldName: 'CollegeName', type: 'text', sortable: true },
    { label: 'College Email', fieldName: 'CollegeEmail', type: 'email', sortable: true },
    { label: 'College Phone', fieldName: 'CollegePhone', type: 'phone', sortable: true },
    { label: 'College Website', fieldName: 'CollegeWebsite', type: 'url', sortable: true },
    { label: 'Course Name', fieldName: 'CourseName', type: 'text', sortable: true },
    { label: 'Course Code', fieldName: 'CourseCode', type: 'text', sortable: true },
    { label: 'Course Fee', fieldName: 'CourseFee', type: 'currency', sortable: true },
    { label: 'Staff Name', fieldName: 'StaffName', type: 'text', sortable: true },
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
export default class UniversityTable extends LightningElement {

    showSpinner = true;
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
    connectedCallback() {
        this.showSpinner = true;
        // this.getAllUniversities();
    }
    renderedCallback() {
        this.showSpinner = false;
    }
    @wire(getUniversities)
    wiredUniversities(result) {
        this.allData = result;
        let data = result.data;
        let error = result.error;
        if (data) {
            console.log(data);
            this.data = data;
        } else if (error) {
            console.log(error);
        }
    }

    // getAllUniversities() {
    //     getUniversities()
    //         .then((data) => {
    //             this.data = data;
    //         })
    //         .catch((error) => {
    //             console.log(error);
    //         })
    // }

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
        this.showEditModal = false;
        this.showToast('Success!', 'Record has been updated successfully', 'success');
        // refreshApex(this.allData);
        // this.getAllUniversities();
    }

    handleUniversitysuccess(event) {
        this.showSpinner = false;
        refreshApex(this.allData);
    }

    handleCollegesuccess(event) {
        this.showSpinner = false;
        refreshApex(this.allData);
    }

    handleStaffsuccess(event) {
        this.showSpinner = false;
        refreshApex(this.allData);
    }

    handleCoursesuccess(event) {
        this.showSpinner = false;
        refreshApex(this.allData);
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