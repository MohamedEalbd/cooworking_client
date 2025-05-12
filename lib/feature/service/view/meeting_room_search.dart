import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khidmh/common/widgets/custom_text_field.dart';
import 'package:khidmh/feature/service/model/service_model.dart' as ser;
import 'package:khidmh/utils/core_export.dart';

import 'booking_details.dart';


class MeetingRoomSearch extends StatefulWidget {
  const MeetingRoomSearch({super.key,this.service});
  final  ser.Service? service;
  @override
  State<MeetingRoomSearch> createState() => _MeetingRoomSearchState();
}

class _MeetingRoomSearchState extends State<MeetingRoomSearch> {
  TextEditingController numberOfIndividualsController = TextEditingController();
  TextEditingController bookingDateController = TextEditingController();
  TextEditingController numberOfMonthsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF5F7F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
        title: Text(widget.service!.name!,style: const TextStyle(fontWeight: FontWeight.w500,color: Color(0xff181F1F),fontSize: 16),),
      ),
      body: GetBuilder<ServiceDetailsController>(
        builder: (serverController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        _buildColumn(controller: numberOfIndividualsController,hintText: 'numberOfIndividuals'.tr),
                        const SizedBox(height: 12,),
                        _buildColumn(controller: bookingDateController,hintText: 'bookingDate'.tr),
                        const SizedBox(height: 12,),
                        _buildColumn(controller: numberOfMonthsController,hintText: 'numberOfMonths'.tr),
                        const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              _buildFromTo(serverController, context)
                            ],
                          ),
                        ),
                        const SizedBox(height: 24,),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                CustomButton(buttonText: "confirm".tr,onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingDetails()));
                },),
                const SizedBox(height: 16,),
              ],
            ),
          );
        }
      ),
    );
  }

   _buildFromTo(ServiceDetailsController serverController, BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => serverController.showDatePicker(context),
        child: Container(
          height: 134,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xffF5F7F7),
              )
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 16,),
                SvgPicture.asset(Images.iconTime,height: 40,width: 40,),
                const SizedBox(height: 12,),
                Text("startTime".tr,style: const TextStyle(fontWeight: FontWeight.w400,color: Color(0xffA3ABAC),fontSize: 14),),
                const SizedBox(height: 12,),
                Text(serverController.to ?? "",style: const TextStyle(fontWeight: FontWeight.w500,color: Color(0xff181F1F),fontSize: 14),),
              ],
            ),
          ),
        ),
      ),
    );
  }

   _buildColumn({TextEditingController? controller,String? hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(hintText!,style: const TextStyle(color: Color(0xff181F1F),fontSize: 14,fontWeight: FontWeight.w500),),
          ),
          const SizedBox(height: 8,),
          CustomTextField(
            hintText: hintText,
            inputType: TextInputType.phone,
            contentPadding: false,
            inputAction: TextInputAction.done,
            controller: controller,
            isShowBorder: true,
            onValidate: (String? value){
              if(value == null || value.isEmpty){
                return 'pleaseFillInTheEmptyFields'.tr;
              }
              return null;
              },
          ),
        ],
      ),
    );
  }
}
