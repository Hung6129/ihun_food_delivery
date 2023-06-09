import '/data/repository/recommended_product_repo.dart';
import '/model/product.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];

  List<dynamic> get recommendedProductList => _recommendedProductList;

  Future<void> geRecommendedProductList() async {
    Response res = await recommendedProductRepo.getRecommendedProductList();
    if (res.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(res.body).products);
      //set state
      update();
    } else {}
  }
}
