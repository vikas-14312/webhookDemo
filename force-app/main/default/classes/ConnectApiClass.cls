public with sharing class ConnectApiClass {
    @AuraEnabled(cacheable=true)
    public static void createCart() {
        String webstoreId = [select id , name from webstore where name = 'india store' limit 1].id;
        String effectiveAccountId = [select id , name from BuyerAccount where Name = 'Customer Account' limit 1].id;
        ConnectApi.CartInput cartInput = new ConnectApi.CartInput();
        cartInput.effectiveAccountId = effectiveAccountId;
        cartInput.currencyIsoCode = 'INR';
        
        try {
            ConnectApi.CartSummary cartSummary = ConnectApi.CommerceCart.createCart(webstoreId, cartInput);
            if(cartSummary != null) {
                System.debug('Cart Id: ' + cartSummary.cartId);
            } else {
                System.debug('Cart creation failed');
            }
        } catch (Exception e) {
            System.debug('Cart creation failed: ' + e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static void addItemsToCart() {
        String webstoreId = [select id , name from webstore where name = 'india store' limit 1].id;
        List<WebCart> cart = [select id , name, WebStoreId, AccountId from WebCart where Id = '0a6dM00000006a5QAA' limit 1];
        String productId = [select id , name from Product2 where id = '01tdM0000026CetQAE' limit 1].id;
        String effectiveAccountId = [select id , name from BuyerAccount where Name = 'Customer Account' limit 1].id;
        System.debug('Product Id: ' + productId);
        System.debug('Cart : ' + cart);
        System.debug('Account Id: ' + effectiveAccountId);
        System.debug('Webstore Id: ' + webstoreId);
        // List<ConnectApi.BatchInput> cartItems = new List<ConnectApi.BatchInput>();
        ConnectApi.CartItemInput cartItemInput = new ConnectApi.CartItemInput();
        cartItemInput.productId = productId;
        cartItemInput.quantity = '1';
        cartItemInput.type = ConnectApi.CartItemType.PRODUCT;
        // ConnectApi.CartItemInput cartItemInput2 = new ConnectApi.CartItemInput();
        // cartItemInput.productId = productId;
        // cartItemInput.quantity = '2';
        // cartItems.add(cartItemInput);
        // cartItems.add(cartItemInput2);
        try {
            ConnectApi.CartItem cartItem = ConnectApi.CommerceCart.addItemToCart(cart[0].WebStoreId, cart[0].AccountId, cart[0].Id, cartItemInput);
            if(cartItem != null) {
                System.debug('Cart Id: ' + cartItem.cartId);
            } else {
                System.debug('Failed to add item to cart');
            }
        } catch (Exception e) {
            System.debug('Failed to add item to cart: ' + e);
        }
    }
}