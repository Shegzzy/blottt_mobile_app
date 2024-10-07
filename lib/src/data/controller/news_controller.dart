import 'package:blott_mobile_app/src/data/model/general_news_model.dart';
import 'package:blott_mobile_app/src/data/repository/news_repository.dart';
import 'package:blott_mobile_app/src/utils/local_storage/local_storage.dart';
import 'package:get/get.dart';

import '../model/response_model.dart';

class GeneralNewsController extends GetxController implements GetxService {
  final NewsRepository newsRepository;

  GeneralNewsController({required this.newsRepository});

  List<NewsModel> _newsModel = [];
  List<NewsModel> get newsModel => _newsModel;

  bool _fetchingNews = false;
  bool get fetchingNews => _fetchingNews;

  bool _errorFetchingNews = false;
  bool get errorFetchingNews => _errorFetchingNews;

  String firstName = '';

  BlottLocalStorage localStorage = BlottLocalStorage();

  Future<ResponseModel> getGeneralNews() async{

    _fetchingNews = true;
    update();

    _errorFetchingNews = false;
    update();

    try {
      Response response = await newsRepository.getMarketNews();
      late ResponseModel responseModel;

      if (response.isOk) {
        _newsModel = (response.body as List).map((news) => NewsModel.fromJson(news)).toList();
        responseModel = ResponseModel(true, "Successfully fetched news");
      } else {
        _errorFetchingNews = true;
        update();
        responseModel = ResponseModel(false, response.statusText ?? "Error");
      }

      // print(_newsModel.first.toJson());
      return responseModel;
    } catch (e) {
      print('Error getting news: $e');
      _errorFetchingNews = true;
      update();
      return ResponseModel(false, "Error getting news");
    } finally {
      _fetchingNews = false;
      update();
    }
  }

  Future<void> storeUserData(String firstName, lastName) async{
    await localStorage.saveData('FirstName', firstName);
    await localStorage.saveData('LastName', lastName);
  }

  Future<String> getUserData() async{
    firstName = await localStorage.readData('FirstName');
    update();
    return firstName;
  }
}