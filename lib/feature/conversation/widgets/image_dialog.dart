import 'package:flutter/material.dart';
import 'package:khidmh/utils/dimensions.dart';
import 'package:khidmh/utils/images.dart';
import 'package:get/get.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;
  const ImageDialog({super.key, required this.imageUrl}) ;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Get.isDarkMode?Theme.of(context).primaryColorDark:null,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusSmall))),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).primaryColor.withValues(alpha: 0.20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder, image: imageUrl, fit: BoxFit.contain,
                    imageErrorBuilder: (c, o, s) => Image.asset(
                      Images.placeholder, height: MediaQuery.of(context).size.width - 130,
                      width: MediaQuery.of(context).size.width, fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),

            ],
          ),
        ),
      ),
    );
  }
}