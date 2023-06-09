import '/custom/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  ApiClient({
    required this.appBaseUrl,
  }) {
    token = AppConstants.TOKEN;
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
  Future<Response> getData(String uri) async {
    try {
      Response res = await get(uri);
      return res;
    } catch (e) {
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }
}
