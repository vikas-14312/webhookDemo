import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
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

export default class CreateUniversityWithoutTypeSubmit extends LightningElement {
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
    // universityAddressCity = UNIVERSITY_ADDRESS_CITY;
    // universityAddressCountryCode = UNIVERSITY_ADDRESS_COUNTRY_CODE;
    // universityAddressPostalCode = UNIVERSITY_ADDRESS_POSTAL_CODE;
    // universityAddressStateCode = UNIVERSITY_ADDRESS_STATE_CODE;
    // universityAddressStreet = UNIVERSITY_ADDRESS_STREET;

    connectedCallback() {
        this.showSpinner = true;
    }
    renderedCallback() {
        this.showSpinner = false;
    }
    handleUniversitysuccess(event) {
        this.showSpinner = false;
        this.showToast('Success!', 'University created successfully', 'success');
        this.universityId = event.detail.id;
        this.showUniversityForm = false;
        this.showCollegeForm = true;
        console.log("university id " + this.universityId);

    }

    handleCollegesuccess(event) {
        this.showSpinner = false;
        console.log('handle college success executed');
        this.showToast('Success!', 'College created successfully', 'success');
        this.collegeId = event.detail.id;
        console.log(this.collegeId);
        this.showCollegeForm = false;
        this.showStaffForm = true;
        this.showCourseForm = true;
    }

    handleReset(event) {
        this.showUniversityForm = true;
        this.showCollegeForm = false;
        this.showStaffForm = false;
        this.showCourseForm = false;
    }

    handleStaffsuccess(event) {
        this.showSpinner = false;
        this.showToast('Success!', 'Staff created successfully', 'success');
    }

    handleCoursesuccess(event) {
        this.showSpinner = false;
        this.showToast('Success!', 'Course created successfully', 'success');
    }

    handleUniversitySave() {
        this.showSpinner = true;
        let universityForm = this.template.querySelector(".universityForm");
        universityForm.submit();
    }

    handleCollegeSave() {
        this.showSpinner = true;
        let collegeForm = this.template.querySelector(".collegeForm");
        collegeForm.submit();
    }

    handleCourseSave() {
        this.showSpinner = true;
        let courseForm = this.template.querySelector(".courseForm");
        courseForm.submit();
    }
    handleStaffSave() {
        this.showSpinner = true;
        let staffForm = this.template.querySelector(".staffForm");
        staffForm.submit();
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