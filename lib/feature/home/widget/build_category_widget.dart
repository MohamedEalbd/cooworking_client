import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/widgets/custom_image.dart';
import '../../../utils/dimensions.dart';

class BuildCategoryWidget extends StatelessWidget {
  const BuildCategoryWidget({super.key,required this.onTap,required this.img,required this.txt});
  final GestureTapCallback onTap;
  final String img;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05), // 5% شفافية
                offset: const Offset(7.5, 12), // X و Y
                blurRadius: 24, // البلور
                spreadRadius: 0, // مفيش انتشار
              ),
            ],
            border: Border.all(
                color: const Color(0xffDFDFDF)
            )
        ),
        child: Column(
          children: [
            img.contains("svg") ?SvgPicture.asset(img) : ClipRRect(
          borderRadius:  const BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radiusSmall),
            topRight: Radius.circular(Dimensions.radiusSmall),
          ),
          child: CustomImage(
            image: img ?? "",
            fit: BoxFit.contain,height: 40,
            width: 40,
          ),
        ),
            const SizedBox(height: 16,),
            Text(txt,style: const TextStyle(fontSize: 14,color: Color(0xff181F1F),fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    );
  }
}
