import { LightningElement, track } from 'lwc';
export default class OmsRoot extends LightningElement {
    @track currentView = 'dashboard';
    get isDashboard() { return this.currentView === 'dashboard'; }
    get isPOS() { return this.currentView === 'pos'; }
    get isProducts() { return this.currentView === 'products'; }
    get isHistory() { return this.currentView === 'history'; }
    handleNav(event) {
        const view = event.currentTarget.dataset.view;
        this.currentView = view;
    }
}