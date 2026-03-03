//Trigger
trigger ProductTrigger on Product2 (After insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        //defaultPriceToProduct.setDefaultPrice(Trigger.new);
    }
}