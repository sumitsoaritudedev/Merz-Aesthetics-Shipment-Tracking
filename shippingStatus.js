import { LightningElement ,api,wire} from 'lwc';
import getStatus from '@salesforce/apex/LiveShipmentStatus.getStatus';
export default class ShippingStatus extends LightningElement {
    @api recordId;
    status;
    flag=false;
    err;
     @wire(getStatus , { recID: '$recordId' })
        wiredRecordsMethod({ error, data }) {
        if (data) {
            if(data==='Error - Must provide tracking number'){
                this.error = undefined;
                this.status  = undefined;
                this.flag=true;
                this.err=data;
            }else{
            this.status  = data;
            this.error = undefined;
            }
            
        } if(error) {
            this.error = error;
            this.status  = undefined;
            this.err=error;
        }
    }
}