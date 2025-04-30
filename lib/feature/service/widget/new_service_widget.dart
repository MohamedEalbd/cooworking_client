
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khidmh/common/widgets/custom_image.dart';

import '../../../helper/route_helper.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../model/service_model.dart';

class NewServiceWidget extends StatelessWidget {
  const NewServiceWidget({super.key,required this.service});
  final Service service;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(
          RouteHelper.getServiceRoute(service.id!),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                    child: CustomImage(
                      image: '${service.coverImageFullPath}',
                      fit: BoxFit.fill,
                      width: double.maxFinite,
                      height: 120,
                    ),
                  ),
                ),
                // ClipRRect(
                //   borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                //   child: CustomImage(image: service.coverImageFullPath,height: 120,fit: BoxFit.cover,width: double.infinity,),
                // ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:  Row(
                        children: [
                          const  Icon(Icons.star, color: Color(0xffFFB23F), size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${double.parse(service.avgRating.toString())}',
                            style:const TextStyle(fontWeight: FontWeight.bold,color: Color(0xff6C757D)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${service.name}',maxLines: 1,
                    style:const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff181F1F)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Image.asset(Images.priceCheckImage,width: 20,height: 28.26,),
                      //SvgPicture.asset(Images.priceCheckIcon),
                      //Icon(Icons.price_check, color: Colors.teal),
                      const SizedBox(width: 4),
                      const Text('3000 ريال/شهر',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff606D6E)),),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset(Images.location_icon),
                      const SizedBox(width: 4),
                      const Expanded(child:  Text('جدة',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff6C757D)),)),
                      const Spacer(),
                      SvgPicture.asset(Images.radio_button),
                      const SizedBox(width: 4),
                      const Expanded(child:  Text('2 - 8 م',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff6C757D)),)),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
