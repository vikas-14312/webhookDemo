import { LightningElement, track, wire } from 'lwc';
import getAllUniversity from '@salesforce/apex/UniversityDatatableController.getAllUniversity';
export default class UniversityDatatable extends LightningElement {
    @track gridColumns = [
        {
            type: 'text',
            fieldName: 'Name',
            label: 'University Name',
            initialWidth: 300,
        },
        {
            type: 'email',
            fieldName: 'Email',
            label: 'Email',
        },
        {
            type: 'phone',
            fieldName: 'Phone',
            label: 'Phone Number',
        },
        {
            type: 'currency',
            fieldName: 'Fee',
            label: 'Fee',
        },
        {
            type: 'currency',
            fieldName: 'Salary',
            label: 'Salary',
        },
        {
            type: 'text',
            fieldName: 'Code',
            label: 'Code',
        },
        {
            type: 'url',
            fieldName: 'Website',
            label: 'Website',
            typeAttributes: {
                label: { fieldName: 'Website' },
            },
        }
        
    ];
    @track gridData = [];

    @wire(getAllUniversity)
    wiredUniversity(result) {
        let data = result.data;
        let error = result.error;
        if (data) {
            console.log(data);
            this.formatGridData(data);
            
        } else if (error) {
            console.log(error);
        }
    }

    formatGridData(data) {
        this.gridData = data.map(item => {
            const {colleges, ...UniversityWrapper} = item;
            const updatedColleges = colleges.map(college => {
                return {...college, "_children":[...college.Courses, ...college.Staff]}
            })
            return {...UniversityWrapper, "_children": updatedColleges};
        })
    }
}