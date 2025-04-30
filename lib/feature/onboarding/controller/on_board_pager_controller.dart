import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

class OnBoardController extends GetxController implements GetxService{
  int pageIndex = 0;
  final PageController pageController = PageController();

  List<Map<String, String>> onBoardPagerData = [
    {
      "text": "احجز مساحات العمل",
      //"text": "${'welcome_to'.tr} ${AppConstants.appName}!",
      "subTitle": 'يمكنك حجز مساحات العمل المختلفة حسب احتياجك من بين فئات متنوعه',
      //"subTitle": 'on_boarding_data_1'.tr,
      "image": "assets/images/onboarding_one.png",
      "top_image" : Images.onBoardTopOne
    },
    {
      "text": 'مساحات متنوعة بأسعار مناسبة',
      // "text": 'on_boarding_2_title'.tr,
      "subTitle": 'يمكنك حجز مساحات العمل المختلفة حسب احتياجك من بين فئات متنوعه',
      //"subTitle": 'on_boarding_data_2'.tr,
      "image": "assets/images/onboarding_two.png",
      "top_image" : Images.onBoardTopTwo
    },
    {
      "text": 'مستقلين من كل الخدمات',
     // "text": 'on_boarding_3_title'.tr,
      "subTitle": 'يمكنك حجز مساحات العمل المختلفة حسب احتياجك من بين فئات متنوعه',
      //"subTitle": 'on_boarding_data_3'.tr,
      "image": "assets/images/onboarding_three.png",
      "top_image" : "assets/images/onboarding_three.png"
    }
  ];

  void onPageChanged(int index){
    pageIndex = index;
    update();
  }

}