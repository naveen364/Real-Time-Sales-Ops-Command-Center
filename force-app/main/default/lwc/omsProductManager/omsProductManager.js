import { LightningElement, track, wire } from 'lwc';
import getProducts from '@salesforce/apex/OMS_ProductService.getProducts';
import updateStock from '@salesforce/apex/OMS_ProductService.updateStock';
import upsertProduct from '@salesforce/apex/OMS_ProductService.upsertProduct';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
export default class OmsProductManager extends LightningElement {
    @track products = [];
    @track orderHistory = [];
    searchKey = '';
    // Modal State
    @track isModalOpen = false;
    @track newProduct = {
        Name: '',
        SKU__c: '',
        Price__c: '',
        Stock_Quantity__c: '',
        Category__c: '',
        Image_URL__c: ''
    };
    // Table Columns
    orderColumns = [
        { label: 'Order Name', fieldName: 'Name' },
        { label: 'Customer', fieldName: 'CustomerName' },
        { label: 'Email', fieldName: 'CustomerEmail' },
        { label: 'Status', fieldName: 'Status__c' },
        { label: 'Total', fieldName: 'Total_Amount__c', type: 'currency' },
        { label: 'Date', fieldName: 'Order_Date__c', type: 'date' }
    ];
    wiredProductsResult;
    @wire(getProducts, { category: 'All', searchKey: '$searchKey' })
    wiredProducts(result) {
        this.wiredProductsResult = result;
        if (result.data) {
            this.products = result.data.map(p => ({ ...p, isEditingStock: false }));
        } else if (result.error) {
            this.showToast('Error', 'Failed to load products', 'error');
        }
    }
    // Modal Helpers
    get categoryOptions() {
        return [
            { label: 'Electronics', value: 'Electronics' },
            { label: 'Clothing', value: 'Clothing' },
            { label: 'Home', value: 'Home' },
            { label: 'Other', value: 'Other' }
        ];
    }
    handleNewProduct() {
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
        this.newProduct = {}; // Reset form
    }
    handleInputChange(event) {
        const field = event.target.dataset.field;
        this.newProduct[field] = event.target.value;
    }
    handleCategoryChange(event) {
        this.newProduct.Category__c = event.detail.value;
    }
    async saveProduct() {
        try {
            await upsertProduct({ product: this.newProduct });
            this.showToast('Success', 'Product Created', 'success');
            this.closeModal();
            refreshApex(this.wiredProductsResult);
        } catch (error) {
            this.showToast('Error', 'Failed to create product: ' + (error.body ? error.body.message : error.message), 'error');
        }
    }
    handleSearch(event) {
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey;
        }, 300);
    }
    enableStockEdit(event) {
        const id = event.currentTarget.dataset.id;
        this.products = this.products.map(p =>
            p.Id === id ? { ...p, isEditingStock: true } : p
        );
    }
    async saveStock(event) {
        const id = event.target.dataset.id;
        const newVal = parseInt(event.target.value, 10);
        try {
            await updateStock({ productId: id, newQuantity: newVal });
            this.showToast('Success', 'Stock updated', 'success');
            // Optimistic update
            this.products = this.products.map(p =>
                p.Id === id ? { ...p, Stock_Quantity__c: newVal, isEditingStock: false } : p
            );
        } catch (e) {
            this.showToast('Error', 'Update failed', 'error');
        }
    }
    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}