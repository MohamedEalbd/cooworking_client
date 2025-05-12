import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';


class ServiceDetailsController extends GetxController implements GetxService{
  final ServiceDetailsRepo serviceDetailsRepo;
  ServiceDetailsController({required this.serviceDetailsRepo});

  Service? _service;
  bool? _isLoading;
  Service? get service => _service;
  bool get isLoading => _isLoading!;


  ///discount and discount type based on category discount and service discount
  double? _serviceDiscount = 0.0;
  double get serviceDiscount => _serviceDiscount!;

  String? _discountType;
  String get discountType => _discountType!;


  late DateTimeRange _selectedDateRange;

  String? _from;
  String? get from => _from;

  String? _to;
  String? get to => _to;

  void showDatePicker(BuildContext context) async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      saveText: 'done'.tr,
      confirmText: 'done'.tr,
      cancelText: 'cancel'.tr,
      fieldStartLabelText: 'start_date'.tr,
      fieldEndLabelText: 'end_date'.tr,
      errorInvalidRangeText: 'select_range'.tr,
    );

    if (result != null) {
      _selectedDateRange = result;

      _from = _selectedDateRange.start.toString().split(' ')[0];
      _to = _selectedDateRange.end.toString().split(' ')[0];
      update();
      //getExpenseList(offset: '1', from: _from, to: _to, searchText: searchText);
    }
  }
  ///call service details data based on service id
  Future<void> getServiceDetails(String serviceID,{String fromPage=""}) async {
    _service = null;
    Response response = await serviceDetailsRepo.getServiceDetails(serviceID,fromPage);
    if (response.body['response_code'] == 'default_200' ) {
      _service = Service.fromJson(response.body['content']);
    } else {
      _service = Service();
      if(response.statusCode != 200){
        ApiChecker.checkApi(response);
      }
    }
    _isLoading = false;

    update();
  }

  Future<void> getServiceDiscount() async {
    Service service = _service!;
    ///if category discount not null then calculate category discount
    if(service.campaignDiscount != null){
      ///service based campaign discount
      _serviceDiscount = service.campaignDiscount!.isNotEmpty ?  service.campaignDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
      _discountType = service.campaignDiscount!.isNotEmpty ?  service.campaignDiscount!.elementAt(0).discount!.discountType!:'amount';
    }else if(service.category!.campaignDiscount != null){
      ///category based campaign discount
      _serviceDiscount = service.category!.campaignDiscount!.isNotEmpty ?  service.category!.campaignDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
      _discountType = service.category!.campaignDiscount!.isNotEmpty ?  service.category!.campaignDiscount!.elementAt(0).discount!.discountAmountType! :'amount';
    }else if(service.serviceDiscount != null){
      ///service based service discount
      _serviceDiscount = service.serviceDiscount!.isNotEmpty ?  service.serviceDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
      _discountType = service.serviceDiscount!.isNotEmpty ?  service.serviceDiscount!.elementAt(0).discount!.discountType!:'amount';
    } else{
      ///category based category discount
      _serviceDiscount = service.category!.categoryDiscount!.isNotEmpty ?  service.category!.categoryDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
      _discountType = service.category!.categoryDiscount!.isNotEmpty ?  service.category!.categoryDiscount!.elementAt(0).discount!.discountAmountType! :'amount';
    }
    update();
  }
}