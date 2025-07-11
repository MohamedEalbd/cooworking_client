import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

class LoyaltyPointItemView extends StatelessWidget {
  final LoyaltyPointTransactionData transactionData;
  const  LoyaltyPointItemView({super.key, required this.transactionData}) ;

  @override
  Widget build(BuildContext context) {
    bool isCredit;

    if(transactionData.credit!=null && transactionData.credit!>0){
      isCredit = true;
    }else{
      isCredit = false;
    }

    return Column(children: [

      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Tooltip(
          message: transactionData.id,
          child: Row(
            children: [
              Text('XID  '.tr,
                overflow: TextOverflow.ellipsis,
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.8),
                ),
              ),

              SizedBox(
                width: ResponsiveHelper.isDesktop(context)?Get.width*0.20:Get.width*0.5,
                child: Text('${transactionData.id}',
                  overflow: TextOverflow.ellipsis,
                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(transactionData.createdAt!)),
          textDirection: TextDirection.ltr,
          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).secondaryHeaderColor),
        )
      ]),

      Row(children: [
        SizedBox(height:90 ,width: 13,child: CustomDivider(height: 5,dashWidth: 0.5,axis: Axis.vertical,color: Get.isDarkMode?Colors.grey:Theme.of(context).colorScheme.primary,)),
        const SizedBox(width: Dimensions.paddingSizeSmall,),
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                border: Border.all(color: Theme.of(context).hintColor,width: 0.5)),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge,vertical: Dimensions.paddingSizeDefault),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text(isCredit?"earned_from_booking".tr:"converted_wallet_money".tr,
                  style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.5)),),


                Row(children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(transactionData.debit!=0?"- ${transactionData.debit}":"+ ${transactionData.credit}",
                      style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                        color:transactionData.debit!=0?Theme.of(context).colorScheme.error :Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(width: 3,),
                  Text("point".tr,style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).secondaryHeaderColor))

                ])]
              ),
            ),

            const SizedBox(height: Dimensions.paddingSizeSmall,),
            const Divider()
          ]),
        ),

      ],),
    ]);
  }
}
