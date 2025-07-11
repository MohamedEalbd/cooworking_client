import 'package:khidmh/feature/create_post/widget/custom_date_time_picker.dart';
import 'package:get/get.dart';
import 'package:khidmh/utils/core_export.dart';

class ServiceSchedule extends StatefulWidget {
  const ServiceSchedule({super.key}) ;

  @override
  State<ServiceSchedule> createState() => _ServiceScheduleState();
}

class _ServiceScheduleState extends State<ServiceSchedule> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController){
      return GetBuilder<ScheduleController>(builder: (scheduleController){
        return  Column( crossAxisAlignment: CrossAxisAlignment.start, children: [

          Text("preferable_time".tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
          const SizedBox(height: Dimensions.paddingSizeSmall,),

          Container(
            width: Get.width,
            padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusSeven),
              border: Border.all(color: Theme.of(context).primaryColor.withValues(alpha: 0.3), width: 0.5),
              color: Theme.of(context).cardColor,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSeven),
                border: Border.all(color: Theme.of(context).primaryColor.withValues(alpha: 0.3), width: 0.5),
                color: Theme.of(context).hoverColor.withValues(alpha: 0.5),
              ),
              padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
              child: Center(child: Row( children: [

                Expanded( flex: 7, child: Row( children: [

                  Text(
                    scheduleController.selectedScheduleType == ScheduleType.asap ?'ASAP'.tr :
                    scheduleController.selectedScheduleType == ScheduleType.schedule && scheduleController.scheduleTime != null ?
                    DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.dateTimeStringToDate(scheduleController.scheduleTime!)) : "select_schedule_time".tr,
                    style: robotoMedium,
                  ),
                ])),

                InkWell( onTap: () {
                  String? errorText = cartController.checkScheduleBookingAvailability();
                  if( errorText !=null ){
                    customSnackBar(errorText.tr);
                  }else{
                    showModalBottomSheet(backgroundColor: Colors.transparent, isScrollControlled: true, context: context, builder: (BuildContext context){
                      return const CustomDateTimePicker();
                    });
                  }
                },
                  child: Image.asset(Images.scheduleIcon, width: 20, color: Theme.of(context).colorScheme.primary,),
                ),

              ])),
            ),
          ),

          const SizedBox(height: Dimensions.paddingSizeDefault),

        ]);},
      );
    });
  }
}
