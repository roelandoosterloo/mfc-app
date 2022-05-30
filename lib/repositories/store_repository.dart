import 'package:in_app_purchase/in_app_purchase.dart';

class StoreException with Exception {
  final String _error;

  StoreException(this._error);

  String get error => _error;
}

class StoreRepository {
  StoreRepository();

  Future<Stream<List<PurchaseDetails>>> purchaseStream() async {
    await InAppPurchase.instance.isAvailable();
    return InAppPurchase.instance.purchaseStream;
  }

  Future<ProductDetails> getProduct(String id) async {
    await InAppPurchase.instance.isAvailable();
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(<String>{id});

    if (response.error != null) {
      throw StoreException(response.error!.message);
    }
    if (response.notFoundIDs.isNotEmpty) {
      throw StoreException("Product with id '$id' could not found");
    }
    return response.productDetails.first;
  }

  Future<void> makePurchase(ProductDetails details, String username) async {
    await InAppPurchase.instance.isAvailable();
    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: details,
      applicationUserName: username,
    );
    bool result = await InAppPurchase.instance
        .buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> completePurchase(PurchaseDetails details) {
    return InAppPurchase.instance.completePurchase(details);
  }

  Future<void> restorePurchases(String username) {
    return InAppPurchase.instance
        .restorePurchases(applicationUserName: username);
  }
}
