import { LightningElement, api } from 'lwc';

export default class LayoutEngine extends LightningElement {
    _layoutItems = [];

    @api
    get layoutItems() {
        return this._layoutItems;
    }
    set layoutItems(value) {
        if (value) {
            this._layoutItems = value.map(item => {
                return {
                    ...item,
                    isSection: item.type === 'Section',
                    isKeyField: item.type === 'Field',
                    isTabSet: item.type === 'TabSet',
                    isTab: item.type === 'Tab',
                    hasChildren: item.children && item.children.length > 0
                };
            });
        }
    }

    @api recordData = {};

    handleFieldChange(event) {
        this.dispatchEvent(new CustomEvent('fieldchange', { detail: event.detail }));
    }
}