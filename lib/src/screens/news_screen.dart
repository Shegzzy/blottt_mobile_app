import 'package:blott_mobile_app/src/data/controller/news_controller.dart';
import 'package:blott_mobile_app/src/screens/news_details.dart';
import 'package:blott_mobile_app/src/utils/constants/colors.dart';
import 'package:blott_mobile_app/src/utils/constants/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/constants/fonts_sizes.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  String firstName = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<GeneralNewsController>().getGeneralNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralNewsController>(builder: (newsController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          toolbarHeight: Dimensions.height100,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hey ${newsController.firstName}', style: Fonts.fontRobot(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  color: AppColors.whiteColor),),
              SizedBox(height: Dimensions.height15,),
              Visibility(
                visible: newsController.errorFetchingNews,
                child: Text('Something went wrong. Please try again later.', style: Fonts.fontRobot(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.whiteColor),)),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: AppColors.mainBlackColor,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          child: newsController.fetchingNews ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,))
              : buildNewsList(newsController),
        ),
      );
    });
  }

  Widget buildNewsList(GeneralNewsController newsController) {
    return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async{
            await newsController.getGeneralNews();
          },
          child: ListView.builder(
            itemCount: newsController.newsModel.length,
            itemBuilder: (context, index) {
              var news = newsController.newsModel[index];
                return GestureDetector(
                  onTap: (){
                    Get.to(() => NewsDetails(url: news.url, headLine: news.headline,));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: Dimensions.height8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                    child: CachedNetworkImage(
                      width: 100, height: 100,
                      fit: BoxFit.cover,
                      imageUrl: news.image,
                      placeholder: (context, url) => const SizedBox(
                          height: 15,
                          width: 15,
                          child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor,))),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    )),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Text(news.headline,
                                        style: Fonts.fontRobot(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColors.whiteColor),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,

                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width8-3,),
                                    Text(DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(news.datetime * 1000)),
                                      style: Fonts.fontRobot(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: AppColors.whiteColor),
                                    ),

                                  ],
                                ),

                                SizedBox(height: Dimensions.height8,),
                                Text(news.summary, style: Fonts.fontRobot(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: AppColors.whiteColor),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
  }
}
