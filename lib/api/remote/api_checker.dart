import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';


class ApiChecker {
  static void checkApi(Response response, {bool showDefaultToaster = true}) {


    if(response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData(response: response);
      // if(Get.currentRoute != RouteHelper.getInitialRoute()){
      //   Get.offAllNamed(RouteHelper.getInitialRoute());
      //   customSnackBar("${response.statusCode!}".tr);
      // }
    }else if(response.statusCode == 500){
      customSnackBar("${response.statusCode!}".tr, showDefaultSnackBar: showDefaultToaster);
    }
    else if(response.statusCode == 400 && response.body['errors'] !=null){
      customSnackBar("${response.body['errors'][0]['message']}",showDefaultSnackBar: showDefaultToaster);
    }
    else if(response.statusCode == 429){
      customSnackBar("too_many_request".tr, showDefaultSnackBar: showDefaultToaster);
    }
    else{
      print("response.bodysssss");
      print(response.body);
   //  customSnackBar("${response.body['message']}", showDefaultSnackBar: showDefaultToaster);
    }
  }
}