import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

class LoyaltyPointController extends GetxController implements GetxService{

  final LoyaltyPointRepo loyaltyPointRepo;
  LoyaltyPointController({required this.loyaltyPointRepo});
  
  bool _isLoading= false;
  bool get isLoading => _isLoading;

  LoyaltyPointModel? loyaltyPointModel;
  List<LoyaltyPointTransactionData> listOfTransaction = [];

  TextEditingController loyaltyPointController = TextEditingController();


  Future<void> convertLoyaltyPoint() async {
    _isLoading = true;
    update();
    Response response = await loyaltyPointRepo.convertLoyaltyPoint(loyaltyPointController.text);
    if(response.statusCode == 200){
      loyaltyPointController.text='';
     await getLoyaltyPointData(1);
      Get.back();
      customSnackBar("point_converted_to_wallet_money".tr,type : ToasterMessageType.success);
    }
    else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> getLoyaltyPointData(int offset,{reload = false}) async {

    if(reload){
      loyaltyPointModel= null;
      update();
    }
    loyaltyPointController.text='';
    Response response = await loyaltyPointRepo.getLoyaltyPointData(offset);
    if(response.statusCode == 200){
      loyaltyPointModel = LoyaltyPointModel.fromJson(response.body);

      if(offset!=1){
        listOfTransaction.addAll(loyaltyPointModel!.content!.transactions!.data!);
      }else{
        listOfTransaction = [];
        listOfTransaction.addAll(loyaltyPointModel!.content!.transactions!.data!);
      }
    }
    else {
      ApiChecker.checkApi(response);
    }
    update();
  }

}