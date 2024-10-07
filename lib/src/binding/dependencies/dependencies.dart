import 'package:blott_mobile_app/src/data/controller/news_controller.dart';
import 'package:blott_mobile_app/src/data/repository/news_repository.dart';
import 'package:blott_mobile_app/src/utils/local_storage/local_storage.dart';
import 'package:get/get.dart';

import '../../services/api_client.dart';
import '../../utils/constants/api_url_constanrts.dart';

Future<void> init() async {
  // Local storage
  final localStorage = BlottLocalStorage();

  Get.lazyPut(() => localStorage);

  // Api base url
  Get.lazyPut(() => ApiClient(appBaseUrl: ApiUrlConstants.baseURI, localStorage: Get.find()));

  // news repo
  Get.lazyPut(() => NewsRepository(apiClient: Get.find()));

  // news controller
  Get.lazyPut(() => GeneralNewsController(newsRepository: Get.find()));
}