import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

class NearbyProviderListItemView extends StatelessWidget {
  final  bool fromHomePage;
  final ProviderData providerData;
  final GlobalKey<CustomShakingWidgetState>?  signInShakeKey;
  final int index;
  const NearbyProviderListItemView({super.key, this.fromHomePage = true, required this.providerData, required this.index, this.signInShakeKey}) ;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearbyProviderController>(builder: (serviceController){
      return OnHover(
        isItem: true,
        child: InkWell(
          onTap: () {
            Get.toNamed(RouteHelper.getProviderDetails(providerData.id!));
          },
          child: GetBuilder<ServiceController>(builder: (serviceController) {
            return


              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          boxShadow: Get.find<ThemeController>().darkTheme
                              ? null
                              : cardShadow,
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsets.all(Dimensions.paddingSizeEight),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: ResponsiveHelper.isDesktop(context) &&
                                    !Get.find<LocalizationController>().isLtr
                                    ? 5
                                    : 8,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(Dimensions.radiusSmall)),
                                      child: CustomImage(
                                        image: '${providerData.logoFullPath}',
                                        fit: BoxFit.cover,
                                        width: double.maxFinite,
                                        height: double.infinity,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.paddingSizeTine),
                                child: Text(
                                  providerData.companyName ?? "",
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeLarge),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              RatingBar(
                                rating: double.parse(providerData.avgRating.toString()),
                                size: 15,
                                ratingCount: providerData.ratingCount,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            size: 18, color: Colors.blue),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(providerData.companyAddress ?? "",maxLines: 1,style: const TextStyle(
                                            fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff6C757D),
                                          ),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //const Spacer(),
                                  const Icon(Icons.directions_walk,
                                      size: 18, color: Colors.blue),
                                  const SizedBox(width: 4),
                                  Text('${(providerData.distance!).toStringAsFixed(2)} كم',style: const TextStyle(
                                    fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff6C757D),
                                  ),),
                                ],
                              ),
                            ],
                          ),
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
                    ],
                  ),
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
                    alignment: Alignment.center,
                    child: Container(
                      height: 80.46,
                      width: 80.46,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE9EBEB),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 3,
                              offset: const Offset(0, 0),
                              blurRadius: 1,
                            )
                          ]),
                      child:  ClipOval(
                        child: CustomImage(
                          image:  "${providerData!.logoFullPath}", // مسار اللوجو
                          fit: BoxFit.cover,height: 80,width: 80,
                        ),
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: FavoriteIconWidget(
                  //     value: service.isFavorite,
                  //     serviceId:  service.id!,
                  //     signInShakeKey: signInShakeKey,
                  //   ),
                  // )
                ],
              );
          }),
        ),
      );
    });
    // return GetBuilder<NearbyProviderController>(builder: (providerBookingController){
    //   return Padding(padding:EdgeInsets.symmetric(
    //       horizontal: ResponsiveHelper.isDesktop(context) && fromHomePage ? 5 : Dimensions.paddingSizeEight,
    //       vertical: fromHomePage?0:Dimensions.paddingSizeEight),
    //
    //     child: OnHover(
    //       isItem: true,
    //       child: Stack(
    //         alignment: Alignment.bottomRight,
    //         children: [
    //           Container(
    //             decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
    //               border: Border.all(color: Theme.of(context).hintColor.withValues(alpha: 0.3)),
    //             ),
    //             padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
    //             child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
    //               Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
    //
    //                 ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusExtraMoreLarge),
    //                   child: Stack( children: [
    //                     CustomImage(height: 70, width: 70, fit: BoxFit.cover,
    //                       image: providerData.logoFullPath ?? "" , placeholder: Images.userPlaceHolder,
    //                     ),
    //                     if(providerData.serviceAvailability == 0) Positioned.fill(child: Container(
    //                       color: Colors.black.withValues(alpha: 0.5),
    //                       child: Center(
    //                         child: Padding(
    //                           padding: const EdgeInsets.only(top: 10),
    //                           child: Text(
    //                             'unavailable'.tr, style: robotoLight.copyWith(
    //                             fontSize: Dimensions.fontSizeSmall -1,
    //                             color: Colors.white,
    //                           )),
    //                         ),
    //                       ),
    //                     ))
    //                   ]),
    //                 ),
    //
    //                 const SizedBox(width: Dimensions.paddingSizeDefault),
    //
    //                 Expanded(
    //                   child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,children: [
    //                     Row(children: [
    //                       Flexible(
    //                         child: Text(providerData.companyName ?? "", style: robotoMedium.copyWith(
    //                             fontSize: Dimensions.fontSizeDefault + 1
    //                         ),
    //                           maxLines: 1, overflow: TextOverflow.ellipsis,
    //                         ),
    //                       ),
    //                       const SizedBox(width: Dimensions.paddingSizeExtraLarge,)
    //                     ]),
    //                     Row(children: [
    //                       SizedBox(height: 20,
    //                         child: Row(children: [
    //
    //                           Image(image: AssetImage(Images.starIcon), color: Theme.of(context).colorScheme.primary,),
    //                           Gaps.horizontalGapOf(3),
    //                           Directionality(
    //                             textDirection: TextDirection.ltr,
    //                             child: Text(
    //                               providerData.avgRating!.toStringAsFixed(2),
    //                               style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6), fontSize: Dimensions.fontSizeSmall),
    //                             ),
    //                           ),
    //                         ]),
    //                       ),
    //                       Gaps.horizontalGapOf(5),
    //                       Directionality(textDirection: TextDirection.ltr,
    //                         child: Text(
    //                           "(${providerData.ratingCount})",
    //                           style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6), fontSize: Dimensions.fontSizeSmall),
    //                         ),
    //                       )],
    //                     ),
    //                     Text(providerData.companyAddress??"",
    //                       style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6), fontSize: Dimensions.fontSizeSmall),
    //                       overflow: TextOverflow.ellipsis, maxLines: 1,
    //                     ),
    //
    //                     const SizedBox(height: Dimensions.paddingSizeTine),
    //
    //                     Row(children: [
    //                       Image.asset(Images.distance, height:12),
    //                       const SizedBox(width: Dimensions.paddingSizeExtraSmall),
    //                       Directionality(
    //                         textDirection: TextDirection.ltr,
    //                         child: Flexible(
    //                           child: Text("${providerData.distance!.toStringAsFixed(2)} ${'km_away_from_you'.tr}",
    //                             style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                         ),
    //                       ),
    //
    //                     ],)
    //                   ]),
    //                 ),
    //               ]),
    //             ]),
    //           ),
    //
    //           Positioned.fill(child: RippleButton(onTap: () {
    //             Get.toNamed(RouteHelper.getProviderDetails(providerData.id!));
    //           })),
    //
    //           Align(
    //             alignment: favButtonAlignment(),
    //             child: FavoriteIconWidget(
    //               value: providerData.isFavorite,
    //               providerId: providerData.id,
    //               signInShakeKey: signInShakeKey,
    //             ),
    //           ),
    //
    //         ],
    //       ),
    //     ),
    //   );
    // });
  }
}