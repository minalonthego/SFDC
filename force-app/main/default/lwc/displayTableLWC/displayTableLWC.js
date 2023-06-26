import { LightningElement, wire, track } from 'lwc';
import getWrapper from '@salesforce/apex/displayTableController.getWrapper';

export default class DisplayTableLWC extends LightningElement {
    // Trackable variables to store data and error
    @track wrapperList;
    @track error;

    // Wire method to fetch data from the server-side Apex controller
    @wire(getWrapper)
    wiredWrapperList({ data, error }) {
        if (data) {
            // Map the returned data to a new format and assign it to the wrapperList
            this.wrapperList = data.map(item => ({
                id: item.id,
                accName: item.a ? item.a.Name : '',
                prodName: item.prodname
            }));
        } else if (error) {
            // Assign the error to the error variable for error handling
            this.error = error;
        }
    }
}