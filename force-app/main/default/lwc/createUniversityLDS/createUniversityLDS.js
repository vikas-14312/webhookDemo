import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
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

export default class CreateUniversityLDS extends LightningElement {
    showUniversityForm = true;
    showCourseForm = false;
    showStaffForm = false;
    showCollegeForm = false;
    universityId;
    collegeId;
    showSpinner = false;
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
    universityData = {};
    collegeData = {};
    staffData = {};
    courseData = {};
    connectedCallback() {
        this.showSpinner = true;
        console.log(this.universityName);
    }
    renderedCallback() {
        this.showSpinner = false;
    }

    handleUniversityChange(event) {
        this.universityData[event.target.name] = event.target.value;
    }

    handleUniversitySave() {
        this.showSpinner = true;
        console.log(JSON.stringify(this.universityData));
        const recordInput = {
            apiName: this.universityObject.objectApiName,
            fields: this.universityData
        }

        createRecord(recordInput)
            .then((university) => {
                this.universityId = university.id;
                console.log('university created successfully');
                this.showToast('Success!', 'University created successfully', 'success');
                this.showUniversityForm = false;
                this.showCollegeForm = true;
                this.showSpinner = false;
            })
            .catch((error) => {
                this.showSpinner = false;
                this.showToast('Error!', error.body.message, 'error');
            })
    }

    handleCollegeChange(event) {
        this.collegeData[event.target.name] = event.target.value;
    }

    handleCollegeSave() {
        this.showSpinner = true;
        console.log(JSON.stringify(this.collegeData));
        this.collegeData['University__c'] = this.universityId;
        const recordInput = {
            apiName: this.collegeObject.objectApiName,
            fields: this.collegeData
        }
        createRecord(recordInput)
            .then((college) => {
                this.collegeId = college.id;
                console.log('college created successfully');
                this.showToast('Success!', 'College created successfully', 'success');
                this.showCollegeForm = false;
                this.showStaffForm = true;
                this.showCourseForm = true;
                this.showSpinner = false;
            })
            .catch((error) => {
                this.showSpinner = false;
                this.showToast('Error!', error.body.message, 'error');
            })
    }

    handleCourseChange(event) {
        this.courseData[event.target.name] = event.target.value;
    }

    handleCourseSave() {
        this.showSpinner = true;
        console.log(JSON.stringify(this.courseData));
        this.courseData['College__c'] = this.collegeId;
        const recordInput = {
            apiName: this.courseObject.objectApiName,
            fields: this.courseData
        }
        createRecord(recordInput)
            .then((course) => {
                console.log('course created successfully');
                this.showToast('Success!', 'Course created successfully', 'success');
                this.showSpinner = false;
            })
            .catch((error) => {
                this.showSpinner = false;
                this.showToast('Error!', error.body.message, 'error');
            })
    }

    handleStaffChange(event) {
        this.staffData[event.target.name] = event.target.value;
    }

    handleStaffSave() {
        this.showSpinner = true;
        console.log(JSON.stringify(this.staffData));
        this.staffData['College__c'] = this.collegeId;
        const recordInput = {
            apiName: this.staffObject.objectApiName,
            fields: this.staffData
        }
        createRecord(recordInput)
            .then((staff) => {
                console.log('staff created successfully');
                this.showToast('Success!', 'Staff created successfully', 'success');
                this.showSpinner = false;
            })
            .catch((error) => {
                this.showSpinner = false;
                this.showToast('Error!', error.body.message, 'error');
            })
    }

    handleReset(event) {
        this.showUniversityForm = true;
        this.showCollegeForm = false;
        this.showStaffForm = false;
        this.showCourseForm = false;
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