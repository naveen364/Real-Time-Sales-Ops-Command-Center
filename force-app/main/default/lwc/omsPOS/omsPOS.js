import { LightningElement, track, wire } from 'lwc';
import getProducts from '@salesforce/apex/OMS_ProductService.getProducts';
import placeOrder from '@salesforce/apex/OMS_OrderService.placeOrder';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class OmsPos extends LightningElement {
    @track products = [];
    @track cartItems = [];
    @track customerEmail = '';
    searchKey = '';
    activeCategory = 'All';
    get categories() {
        const cats = ['All', 'Electronics', 'Clothing', 'Home'];
        return cats.map(c => ({
            name: c,
            class: this.activeCategory === c ? 'cat-btn active' : 'cat-btn'
        }));
    }
    @wire(getProducts, { category: '$activeCategory', searchKey: '$searchKey' })
    wiredProducts({ error, data }) {
        if (data) {
            this.products = data.map(p => ({
                ...p,
                accronym: p.Name.substring(0, 2).toUpperCase()
            }));
        }
    }
    handleSearch(event) {
        // Simple debounce
        window.clearTimeout(this.delayTimeout);
        const val = event.target.value;
        this.delayTimeout = setTimeout(() => { this.searchKey = val; }, 300);
    }
    handleCategoryFilter(event) {
        this.activeCategory = event.target.dataset.cat;
    }
    addToCart(event) {
        const prodId = event.currentTarget.dataset.id;
        const product = this.products.find(p => p.Id === prodId);
        const existingItem = this.cartItems.find(item => item.productId === prodId);
        if (existingItem) {
            existingItem.quantity += 1;
            existingItem.totalLinePrice = existingItem.quantity * existingItem.unitPrice;
            this.cartItems = [...this.cartItems]; // Trigger reactivity
        } else {
            this.cartItems.push({
                productId: product.Id,
                name: product.Name,
                unitPrice: product.Price__c,
                quantity: 1,
                totalLinePrice: product.Price__c
            });
        }
    }
    incrementItem(event) {
        const prodId = event.target.dataset.id;
        const item = this.cartItems.find(i => i.productId === prodId);
        if (item) {
            item.quantity += 1;
            item.totalLinePrice = item.quantity * item.unitPrice;
            this.cartItems = [...this.cartItems];
        }
    }
    decrementItem(event) {
        const prodId = event.target.dataset.id;
        const item = this.cartItems.find(i => i.productId === prodId);
        if (item) {
            if (item.quantity > 1) {
                item.quantity -= 1;
                item.totalLinePrice = item.quantity * item.unitPrice;
            } else {
                this.cartItems = this.cartItems.filter(i => i.productId !== prodId);
            }
            this.cartItems = [...this.cartItems];
        }
    }
    handleCustomerChange(event) {
        this.customerEmail = event.target.value;
    }
    get hasItems() { return this.cartItems.length > 0; }
    get subTotal() {
        return this.cartItems.reduce((acc, item) => acc + item.totalLinePrice, 0);
    }
    get taxAmount() {
        return this.subTotal * 0.10;
    }
    get grandTotal() {
        return this.subTotal + this.taxAmount;
    }
    get isCheckoutDisabled() {
        return !this.hasItems || !this.customerEmail;
    }
    async handleCheckout() {
        const orderData = {
            customerEmail: this.customerEmail, // In real app, validate this ID
            discount: 0,
            items: this.cartItems.map(item => ({
                productId: item.productId,
                quantity: item.quantity,
                unitPrice: item.unitPrice
            }))
        };
        try {
            await placeOrder({ orderData });
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success',
                message: 'Order placed successfully!',
                variant: 'success'
            }));
            this.cartItems = [];
            this.customerEmail = '';
        } catch (error) {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: error.body ? error.body.message : error.message,
                variant: 'error'
            }));
        }
    }
}