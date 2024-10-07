import 'package:blott_mobile_app/src/data/model/general_news_model.dart';
import 'package:blott_mobile_app/src/data/repository/news_repository.dart';
import 'package:get/get.dart';

import '../model/response_model.dart';

class GeneralNewsController extends GetxController implements GetxService {
  final NewsRepository newsRepository;

  GeneralNewsController({required this.newsRepository});

  List<NewsModel> _newsModel = [];
  List<NewsModel> get newsModel => _newsModel;

  Future<ResponseModel> getGeneralNews() async{

    try {
      Response response = await newsRepository.getMarketNews();
      late ResponseModel responseModel;

      if (response.isOk) {
        _newsModel = (response.body as List).map((news) => NewsModel.fromJson(news)).toList();
        responseModel = ResponseModel(true, "Successfully fetched news");
      } else {
        responseModel = ResponseModel(false, response.statusText ?? "Error");
      }

      // print(_newsModel.first.toJson());
      return responseModel;
    } catch (e) {
      print('Error getting news: $e');
      return ResponseModel(false, "Error getting news");
    } finally {
      update();
    }
  }
}