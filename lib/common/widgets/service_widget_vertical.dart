import 'package:get/get.dart';
import 'package:khidmh/utils/core_export.dart';

class ServiceWidgetVertical extends StatelessWidget {
  final Service service;
  final String fromType;
  final String fromPage;
  final ProviderData? providerData;
  final GlobalKey<CustomShakingWidgetState>?  signInShakeKey;

  const ServiceWidgetVertical({
    super.key, required this.service, required this.fromType,
    this.fromPage ="", this.providerData, this.signInShakeKey}) ;

  @override
  Widget build(BuildContext context) {
    num lowestPrice = 0.0;

    if(fromType == 'fromCampaign'){
      if(service.variations != null){
        lowestPrice = service.variations![0].price!;
        for (var i = 0; i < service.variations!.length; i++) {
          if (service.variations![i].price! < lowestPrice) {
            lowestPrice = service.variations![i].price!;
          }
        }
      }
    }else{
      if(service.variationsAppFormat != null){
        if(service.variationsAppFormat!.zoneWiseVariations != null){
          lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!;
          for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
            if (service.variationsAppFormat!.zoneWiseVariations![i].price! < lowestPrice) {
              lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!;
            }
          }
        }
      }
    }


    Discount discountModel =  PriceConverter.discountCalculation(service);
    return OnHover(
      isItem: true,
      child: InkWell(onTap: () {

        if(fromPage=="search_page"){
          Get.toNamed(RouteHelper.getServiceRoute(service.id!,fromPage:"search_page"),);
        }else{
          Get.toNamed(RouteHelper.getServiceRoute(service.id!),);
        }
      } ,
        child: GetBuilder<ServiceController>(builder: (serviceController){
          return Stack(alignment: Alignment.bottomRight, children: [
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  boxShadow: Get.find<ThemeController>().darkTheme ? null : cardShadow,
                ),

                child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeEight),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                    Expanded(
                      flex: ResponsiveHelper.isDesktop(context) && !Get.find<LocalizationController>().isLtr ? 5 : 8,
                      child: Stack(children: [

                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                          child: CustomImage(
                            image: '${service.thumbnailFullPath}',
                            fit: BoxFit.cover,width: double.maxFinite,
                            height: double.infinity,
                          ),
                        ),

                        discountModel.discountAmount! > 0 ? Align(alignment: Alignment.topLeft,
                          child: DiscountTagWidget(
                            discountAmount: discountModel.discountAmount,
                            discountAmountType: discountModel.discountAmountType,
                          ),
                        ) : const SizedBox(),

                      ],),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeTine ),
                      child: Text(
                        service.name ?? "",
                        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                        maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
                      ),
                    ),

                    Row(
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Text(
                              //   'price'.tr,
                              //   style: robotoRegular.copyWith(
                              //       fontSize: Dimensions.fontSizeSmall,
                              //       fontWeight: FontWeight.w500,
                              //       color: Colors.black),
                              // ),
                              // const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(discountModel.discountAmount! > 0)
                                    Row(
                                      children: [
                                        Text(
                                          'discount'.tr,
                                          style: robotoRegular.copyWith(
                                              fontSize: Dimensions.fontSizeSmall,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                                        Center(
                                          child: Text(
                                            PriceConverter.convertPrice(lowestPrice.toDouble()),
                                            maxLines: 2,
                                            style: robotoRegular.copyWith(
                                                fontSize:Dimensions.fontSizeDefault ,
                                                fontWeight: FontWeight.w400,
                                                decoration: TextDecoration.lineThrough,
                                                color: Theme.of(context).colorScheme.error),),
                                        ),
                                      ],
                                    ),
                                  discountModel.discountAmount! > 0?
                                  Row(
                                    children: [
                                      Text(
                                        'price'.tr,
                                        style: robotoRegular.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child:
                                        Center(
                                          child: Text(
                                            PriceConverter.convertPrice(
                                                lowestPrice.toDouble(),
                                                discount: discountModel.discountAmount!.toDouble(),
                                                discountType: discountModel.discountAmountType),
                                            style: robotoMedium.copyWith(
                                                fontSize:Dimensions.fontSizeDefault ,
                                                fontWeight: FontWeight.w400,
                                                color:  Get.isDarkMode? Theme.of(context).primaryColorLight: ColorResources.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      :
                                  Row(
                                    children: [
                                      Text(
                                        'price'.tr,
                                        style: robotoRegular.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Center(
                                          child: Text(
                                            PriceConverter.convertPrice(lowestPrice.toDouble()),
                                            textAlign: TextAlign.center,
                                            style: robotoMedium.copyWith(
                                                fontSize:Dimensions.fontSizeDefault ,
                                                fontWeight: FontWeight.w400,
                                                color: Get.isDarkMode? Theme.of(context).primaryColorLight: ColorResources.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                        const Spacer(),
                        InkWell(onTap: () {
                          print("allllliiii");
                          showModalBottomSheet(
                              useRootNavigator: true,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context, builder: (context) => ServiceCenterDialog(service: service, providerData: providerData,));
                        } ,
                          child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:   ColorResources.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 6,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 3)
                                ),
                              ],  ),
                            child: Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeEight),
                              child: Image.asset(Images.cart,height: 30,width: 30,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],),
                ),
              ),
              // Positioned.fill(child: RippleButton(onTap: () {
              //
              //   if(fromPage=="search_page"){
              //     Get.toNamed(RouteHelper.getServiceRoute(service.id!,fromPage:"search_page"),);
              //   }else{
              //     Get.toNamed(RouteHelper.getServiceRoute(service.id!),);
              //   }
              // }))
            ],),
            //
            // if(fromType != 'fromCampaign')
            //   Align(
            //     alignment:Get.find<LocalizationController>().isLtr ? Alignment.bottomRight : Alignment.bottomLeft,
            //     child: Stack(
            //       children: [
            //         Container(
            //       height: 40,
            //       width: 40,
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         color:   ColorResources.white,
            //         borderRadius: BorderRadius.circular(8),
            //         boxShadow: [
            //           BoxShadow(
            //               color: Colors.black.withValues(alpha: 0.1),
            //               blurRadius: 6,
            //               spreadRadius: 2,
            //               offset: const Offset(0, 3)
            //           ),
            //         ],  ),
            //           child: Padding(
            //             padding: const EdgeInsets.all(Dimensions.paddingSizeEight),
            //             child: Image.asset(Images.cart,height: 30,width: 30,),
            //           ),
            //         ),
            //         Positioned.fill(child: RippleButton(onTap: () {
            //           showModalBottomSheet(
            //               useRootNavigator: true,
            //               isScrollControlled: true,
            //               backgroundColor: Colors.transparent,
            //               context: context, builder: (context) => ServiceCenterDialog(service: service, providerData: providerData,));
            //         }))
            //       ],
            //     ),
            //   ),

            Align(
              alignment: Alignment.topRight,
              child: FavoriteIconWidget(
                value: service.isFavorite,
                serviceId:  service.id!,
                signInShakeKey: signInShakeKey,
              ),
            )

          ],);
        }),
      ),
    );
  }
}
