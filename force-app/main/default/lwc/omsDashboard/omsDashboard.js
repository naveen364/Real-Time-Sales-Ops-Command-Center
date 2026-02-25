import { LightningElement, wire, track } from 'lwc';
import getDashboardData from '@salesforce/apex/OMS_AnalyticsService.getDashboardData';
export default class OmsDashboard extends LightningElement {
    @track totalRevenue = 0;
    @track totalOrders = 0;
    @track lowStockCount = 0;
    @track lowStockItems = [];
    get todayDate() {
        return new Date().toLocaleDateString();
    }
    @wire(getDashboardData)
    wiredData({ error, data }) {
        if (data) {
            this.totalRevenue = data.totalRevenue;
            this.totalOrders = data.totalOrders;
            this.lowStockCount = data.lowStockCount;
            this.lowStockItems = data.lowStockItems;
        } else if (error) {
            console.error('Error fetching dashboard data:', error);
        }
    }
}