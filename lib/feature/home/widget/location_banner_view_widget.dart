import 'package:khidmh/common/widgets/custom_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../../splash/controller/theme_controller.dart';

class LocationBannerViewWidget extends StatelessWidget {
  const LocationBannerViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeDefault : 0, vertical: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeLarge),
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.isMobile(context) ? 0 : Dimensions.paddingSizeLarge),
        height: ResponsiveHelper.isMobile(context) ? 110 : 147,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode ? Colors.grey.shade500.withValues(alpha: 0.4) :  Theme.of(context).colorScheme.primary.withValues(alpha: 0.13),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, 1),
            )
          ],
          //color: Theme.of(context).primaryColor.withOpacity(Get.find<ThemeController>().darkTheme ? 0.5 : 0.1),
          // gradient: LinearGradient(
          //   colors: [
          //     Theme.of(context).primaryColor.withOpacity(Get.find<ThemeController>().darkTheme ? 0.5 : 0.07),
          //     Theme.of(context).primaryColor.withOpacity(Get.find<ThemeController>().darkTheme ? 0.5 : 0.1),
          //     Theme.of(context).primaryColor.withOpacity(Get.find<ThemeController>().darkTheme ? 0.5 : 0.2),
          //     Theme.of(context).primaryColor.withOpacity(Get.find<ThemeController>().darkTheme ? 0.5 : 0.25),
          //   ],
          //   begin: Alignment.center,
          //   end: Alignment.bottomCenter,
          // ),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        child: Row(children: [
          SizedBox(width: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeExtraSmall : 0),
          Expanded(
            child: Row(children: [
             // CustomImage(Images.nearbyRestaurant, height: ResponsiveHelper.isMobile(context) ? 60 : 93, width: ResponsiveHelper.isMobile(context) ? 74 : 119, fit: BoxFit.contain),
              SizedBox(width: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeLarge),

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('coworkingSpacesNearYou'.tr, style: robotoBold.copyWith(fontSize: ResponsiveHelper.isMobile(context) ? Dimensions.fontSizeDefault : Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.w600)),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                    Text(
                      'reserveAWorkspaceNearYourLocation'.tr,
                      style: robotoRegular.copyWith(fontSize: ResponsiveHelper.isMobile(context) ? Dimensions.fontSizeSmall : Dimensions.fontSizeLarge),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 20),

            Stack(clipBehavior: Clip.none, children: [
              CustomButton(
                buttonText: 'bookNow'.tr,
                width: ResponsiveHelper.isMobile(context) ? 90 : 120,
                height: ResponsiveHelper.isMobile(context) ? 35 : 40,
                fontSize: Dimensions.fontSizeSmall,
                radius: Dimensions.radiusDefault,
                onPressed: ()=> Get.toNamed(RouteHelper.getNearByProviderScreen(tabIndex: 1)),
              ),

              // Positioned(
              //   top: ResponsiveHelper.isDesktop(context) ? -30 : -25, right: 0, left: 0,
              //   child: SizedBox(
              //     height: 40, width: 40,
              //     child: CustomImage(
              //       image: Images.nearbyLocation,
              //       fit: BoxFit.contain,
              //       width: 40,
              //       height: 40,
              //     ),
              //   ),
              // ),

            ]),

            SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeDefault : 0),
          ]),
          SizedBox(width: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeSmall : 0),
        ]),
      ),
    );
  }
}