import { LightningElement, track, wire } from 'lwc';
import getAccountContacts from '@salesforce/apex/AccountContactDatatableController.getAccountContacts';

const columns = [
    { label: 'Account Name', fieldName: 'accountName' },
    {
        label: 'Contacts',
        fieldName: 'contactNames',
        type: 'url',
        typeAttributes: { label: { fieldName: 'contactNames' }, target: '_blank' }
    }
];
export default class AccountContactDatatable extends LightningElement {
    @track data = [];
    columns = columns;

     @wire(getAccountContacts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.data = data.map(acc => ({
                accountId: acc.accountId,
                accountName: acc.accountName,
                contactNames: acc.contactNames.map(contact => contact.contactName).join(', '),
                rawContacts: acc.contactNames
            }));
        } else if (error) {
            // Handle error
        }
    }

    handleRowSelection(event) {
        const selectedRows = event.detail.selectedRows;
        if (selectedRows.length > 0) {
            const contacts = selectedRows[0].rawContacts;
            contacts.forEach(contact => {
                // Add your logic to navigate to contact record page
                // Example: this[NavigationMixin.Navigate](...)
            });
        }
    }
}