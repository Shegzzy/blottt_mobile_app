import 'package:blott_mobile_app/src/services/api_client.dart';
import 'package:get/get.dart';

import '../../utils/constants/api_url_constanrts.dart';

class NewsRepository {
  final ApiClient apiClient;

  NewsRepository({required this.apiClient});

  Future<Response> getMarketNews() async {
    return await apiClient.getData('${ApiUrlConstants.marketGeneralNewsURI}&token=crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg');
  }
}