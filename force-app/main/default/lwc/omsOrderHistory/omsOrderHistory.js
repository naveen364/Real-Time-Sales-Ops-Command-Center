import { LightningElement, wire, track } from 'lwc';
import getRecentOrders from '@salesforce/apex/OMS_OrderService.getRecentOrders';
export default class OmsOrderHistory extends LightningElement {
    @track orders = [];
    @wire(getRecentOrders)
    wiredOrders({ error, data }) {
        if (data) {
            this.orders = data.map(order => ({
                ...order,
                CustomerName: order.Customer__r ? order.Customer__r.Name : 'Guest',
                CustomerEmail: order.Customer__r ? order.Customer__r.Email : '-',
                FormattedDate: new Date(order.Order_Date__c).toLocaleDateString(),
                StatusClass: `status-badge ${order.Status__c ? order.Status__c.toLowerCase() : 'draft'}`
            }));
        } else if (error) {
            console.error('Error fetching orders:', error);
        }
    }
}