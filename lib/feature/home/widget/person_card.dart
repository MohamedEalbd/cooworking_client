import 'package:flutter/material.dart';
import 'package:khidmh/common/widgets/custom_image.dart';

import '../../../common/widgets/rating_bar.dart';
import '../../../utils/dimensions.dart';
import '../../provider/model/provider_model.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({super.key,this.providerData});
  final ProviderData? providerData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // الصورة الدائرية
          ClipOval(
            child: CustomImage(
             image:  "${providerData!.logoFullPath}", // مسار اللوجو
              fit: BoxFit.cover,height: 80,width: 80,
            ),
          ),
          const SizedBox(height: 8),

          // الاسم
           Text(
            providerData!.contactPersonName ?? "",maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14,color: Color(0xff181F1F)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),

          // التخصص والسعر
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  providerData!.companyName ?? "",maxLines: 1,
                  style:const TextStyle(fontSize: 12, color: Color(0xff6C757D),fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 8),
              const  Text(
                '20 ر.س/ساعة',
                style: TextStyle(fontSize: 12, color: Color(0xff6C757D),fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // سنوات الخبرة
          const Text(
            '+2 سنوات خبرة',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff018995),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),

          // التقييم بالنجوم
          RatingBar(
            rating: double.parse(providerData!.avgRating.toString()),
            size: 15,
            ratingCount: providerData!.ratingCount,
          ),
          // RatingBarIndicator(
          //   rating: 4.0,
          //   itemBuilder: (context, index) => const Icon(
          //     Icons.star,
          //     color: Colors.orange,
          //   ),
          //   itemCount: 5,
          //   itemSize: 20,
          //   direction: Axis.horizontal,
          // ),
        ],
      ),
    );
  }
}
