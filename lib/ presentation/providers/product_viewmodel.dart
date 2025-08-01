import 'package:timerflow/exports.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductService _productService;

  ProductViewModel(this._productService);

  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _error;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _productService.fetchProducts();
      debugPrint("fetchProducts: true");
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _productService.addProduct(product);
      await fetchProducts();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _productService.updateProduct(product);
      await fetchProducts();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _productService.deleteProduct(id);
      await fetchProducts();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
