public class OrderLineItemCreateAndTotalMoneyInOrder {
    public static void total(){
        List<OrderItem> orderitemlist = new List<OrderItem>();
        List<Order> orderlist = new List<Order>();
        Pricebook2 pb = new Pricebook2();
        pb.Name = 'custom for orderitem';
        insert pb;
        PricebookEntry pbe = new PricebookEntry();
        pbe.Pricebook2Id = pb.Id;
        pbe.Product2Id = '01t5j000003tnveAAA';
        pbe.UnitPrice = 20;
        insert pbe;
        Id OrderId = '8015j000001Arq0AAC';
        Order order = new Order();
        order.Id = OrderId;
        order.Pricebook2Id = pb.Id;
        update order;
        for(Integer i = 0; i<=3;i++){
            OrderItem oi = new OrderItem();
            oi.OrderId = OrderId;
            oi.Quantity = 12;
            oi.ServiceDate = Date.today();
            oi.Money__c = 120*i;
            oi.PricebookEntryId = pbe.Id;
            oi.UnitPrice = 12;
            orderitemlist.add(oi);
        }
        if(!orderitemlist.isEmpty()){
            insert orderitemlist;
        }
        Map<Id,Decimal> maporder = new Map<Id,Decimal>();
        for(OrderItem oi : orderitemlist){
            if(!maporder.containsKey(oi.OrderId)){
                maporder.put(oi.OrderId,oi.Money__c);
            }else{
                maporder.put(oi.OrderId,maporder.get(oi.OrderId)+oi.Money__c);
            }
        }
        
        orderlist = [select Id from Order where Id In (select OrderId from OrderItem where Id In :orderitemlist)];
        System.debug('orderlist==>'+orderlist);
        for(Order orders : orderlist){
            if(maporder.containskey(orders.Id)){
                orders.TotalMoney__c = maporder.get(orders.Id);
            }
            System.debug('Orders==>'+orders.TotalMoney__c);
        }
        if(!orderlist.isEmpty()){
            update orderlist;
        }
    }
}