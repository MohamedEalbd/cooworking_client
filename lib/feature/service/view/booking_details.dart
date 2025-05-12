import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidmh/common/widgets/custom_button.dart';

import '../../../common/widgets/custom_image.dart';
import '../../../common/widgets/no_data_screen.dart';
import '../../../helper/price_converter.dart';
import '../../coupon/model/coupon_model.dart';
import '../controller/service_details_controller.dart';
import '../model/service_model.dart';
import '../widget/service_details_shimmer_widget.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
        title: Text("bookingDetails".tr,style: const TextStyle(fontWeight: FontWeight.w500,color: Color(0xff181F1F),fontSize: 16),),
      ),
      body: GetBuilder<ServiceDetailsController>(
        builder: (serviceController) {
          if (serviceController.service != null) {
            if (serviceController.service!.id != null) {
              Service? service = serviceController.service;
              Discount discount = PriceConverter.discountCalculation(service!);
              double lowestPrice = 0.0;
              if (service.variationsAppFormat!.zoneWiseVariations != null) {
                lowestPrice =
                    service.variationsAppFormat!.zoneWiseVariations![0].price!
                        .toDouble();
                for (var i = 0; i <
                    service.variationsAppFormat!.zoneWiseVariations!
                        .length; i++) {
                  if (service.variationsAppFormat!.zoneWiseVariations![i]
                      .price! < lowestPrice) {
                    lowestPrice =
                        service.variationsAppFormat!.zoneWiseVariations![i]
                            .price!.toDouble();
                  }
                }
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CustomImage(
                                      image: service.coverImageFullPath ?? "",
                                      fit: BoxFit.cover,height: 120,width: 148,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CustomImage(
                                        image: service.thumbnailFullPath ?? "",
                                        fit: BoxFit.cover,width: 78.9,
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(service.name!,style: const TextStyle(color: Color(0xff181F1F),fontSize: 16,fontWeight: FontWeight.w500),),
                                    const SizedBox(height: 5,),
                                    const Text('2 - 8 م',maxLines: 1,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff6C757D)),),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 12,),
                            Text("bookingDetails".tr,style: const TextStyle(fontWeight: FontWeight.w500,color: Color(0xff181F1F),fontSize: 16),),
                            const SizedBox(height: 12,),
                            _buildRow("bookingStartDate".tr,serviceController.to ?? ""),
                            const SizedBox(height: 12,),
                            _buildRow("bookingEndDate".tr,serviceController.from ?? ""),
                            const SizedBox(height: 12,),
                            _buildRow("startTime".tr,"8:00 صباحاً"),
                            const SizedBox(height: 12,),
                            Text("feesAndPaymentInformation".tr,style: const TextStyle(fontWeight: FontWeight.w500,color: Color(0xff181F1F),fontSize: 16),),
                            const SizedBox(height: 12,),
                            _buildRow("price".tr, "$lowestPrice"),
                            const SizedBox(height: 12,),
                            _buildRow("tax".tr, "${service.tax}"),
                            const SizedBox(height: 12,),
                            _buildRow("total".tr, "${(lowestPrice + service.tax!)}"),
                            const SizedBox(height: 12,),
                            Text("paymentMethod".tr,style: const TextStyle(fontWeight: FontWeight.w500,color: Color(0xff181F1F),fontSize: 16),),
                            const SizedBox(height: 12,),
                            _buildRow("total".tr, "${(lowestPrice + service.tax!)}"),
                            const SizedBox(height: 12,),
                            Text("cancellationPolicy".tr,style: const TextStyle(fontWeight: FontWeight.w500,color: Color(0xff181F1F),fontSize: 16),),
                            const SizedBox(height: 12,),
                            Text("freeCancellation".tr,style: const TextStyle(fontWeight: FontWeight.w400,color: Color(0xff7A8586),fontSize: 14),),

                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomButton(buttonText: "confirmAndPay".tr,onPressed: (){},),
                    const SizedBox(height: 12,),
                  ],
                ),
              );
            }
            else{
              return NoDataScreen(text: 'no_service_available'.tr,type: NoDataType.service,);

            }
          }
          else{
            return const ServiceDetailsShimmerWidget();
          }
        }
        ),
    );
  }

   _buildRow(String txt,String subTxt) {
    return Row(
      children: [
        Text(txt,style: const TextStyle(fontWeight: FontWeight.w400,color: Color(0xff7A8586),fontSize: 14),),
        const Spacer(),
        Text(subTxt,style: const TextStyle(fontWeight: FontWeight.w400,color: Color(0xff38494A),fontSize: 14),),
      ],
    );
  }
}
