import 'package:get/get.dart';
import 'package:khidmh/utils/core_export.dart';

class ServiceWidgetVertical extends StatelessWidget {
  final Service service;
  final String fromType;
  final String fromPage;
  final ProviderData? providerData;
  final GlobalKey<CustomShakingWidgetState>? signInShakeKey;

  const ServiceWidgetVertical(
      {super.key,
      required this.service,
      required this.fromType,
      this.fromPage = "",
      this.providerData,
      this.signInShakeKey});

  @override
  Widget build(BuildContext context) {
    num lowestPrice = 0.0;

    if (fromType == 'fromCampaign') {
      if (service.variations != null) {
        lowestPrice = service.variations![0].price!;
        for (var i = 0; i < service.variations!.length; i++) {
          if (service.variations![i].price! < lowestPrice) {
            lowestPrice = service.variations![i].price!;
          }
        }
      }
    } else {
      if (service.variationsAppFormat != null) {
        if (service.variationsAppFormat!.zoneWiseVariations != null) {
          lowestPrice =
              service.variationsAppFormat!.zoneWiseVariations![0].price!;
          for (var i = 0;
              i < service.variationsAppFormat!.zoneWiseVariations!.length;
              i++) {
            if (service.variationsAppFormat!.zoneWiseVariations![i].price! <
                lowestPrice) {
              lowestPrice =
                  service.variationsAppFormat!.zoneWiseVariations![i].price!;
            }
          }
        }
      }
    }

    Discount discountModel = PriceConverter.discountCalculation(service);
    return OnHover(
      isItem: true,
      child: InkWell(
        onTap: () {
          if (fromPage == "search_page") {
            Get.toNamed(
              RouteHelper.getServiceRoute(service.id!, fromPage: "search_page"),
            );
          } else {
            Get.toNamed(
              RouteHelper.getServiceRoute(service.id!),
            );
          }
        },
        child: GetBuilder<ServiceController>(builder: (serviceController) {
          return
              //   Container(
              //   padding: const EdgeInsets.all(8),
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).cardColor,
              //     borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              //     boxShadow: Get.find<ThemeController>().darkTheme ? null : cardShadow,
              //   ),
              //   child: Stack(
              //     clipBehavior: Clip.none,
              //     alignment: Alignment.center,
              //     children: [
              //       Column(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           Expanded(
              //             flex: ResponsiveHelper.isDesktop(context) && !Get.find<LocalizationController>().isLtr ? 5 : 8,
              //             child: Stack(children: [
              //
              //               ClipRRect(
              //                 borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
              //                 child: CustomImage(
              //                   image: '${service.thumbnailFullPath}',
              //                   fit: BoxFit.cover,width: double.maxFinite,
              //                   height: double.maxFinite,
              //                 ),
              //               ),
              //
              //               discountModel.discountAmount! > 0 ? Align(alignment: Alignment.topLeft,
              //                 child: DiscountTagWidget(
              //                   discountAmount: discountModel.discountAmount,
              //                   discountAmountType: discountModel.discountAmountType,
              //                 ),
              //               ) : const SizedBox(),
              //
              //             ],),
              //           ),
              //
              //           const SizedBox(height: 60), // مساحة عشان اللوجو
              //          // Padding(padding: EdgeInsets.only(top: 60)),
              //           Text(
              //             service.name ?? "",
              //             style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
              //             maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,
              //           ),
              //           const SizedBox(height: 8),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: List.generate(5, (index) {
              //               return Icon(
              //                 index < 4 ? Icons.star : Icons.star_border,
              //                 color: Colors.orange,
              //                 size: 20,
              //               );
              //             }),
              //           ),
              //           const SizedBox(height: 8),
              //            Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Row(
              //                   children: [
              //                     Icon(Icons.location_on, size: 18, color: Colors.blue),
              //                     SizedBox(width: 4),
              //                     Text("ok"),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     Icon(Icons.directions_walk, size: 18, color: Colors.blue),
              //                     SizedBox(width: 4),
              //                     Text('2.16 كم'),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //       Container(
              //         height: 80.46,width: 80.46,
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: const Color(0xFFE9EBEB),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.white.withOpacity(0.5),
              //                 spreadRadius: 10,
              //                 offset: const Offset(0, 0),
              //                 blurRadius: 1,
              //               )
              //             ]
              //         ),
              //         child: ClipOval(
              //           child: CustomImage(
              //             image: '${service.thumbnailFullPath}',
              //             fit: BoxFit.cover,width: double.maxFinite,
              //             height: double.infinity,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // );

              Stack(
            alignment: Alignment.bottomRight,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
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
                                    image: '${service.thumbnailFullPath}',
                                    fit: BoxFit.cover,
                                    width: double.maxFinite,
                                    height: double.infinity,
                                  ),
                                ),
                                discountModel.discountAmount! > 0
                                    ? Align(
                                        alignment: Alignment.topLeft,
                                        child: DiscountTagWidget(
                                          discountAmount:
                                              discountModel.discountAmount,
                                          discountAmountType:
                                              discountModel.discountAmountType,
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeTine),
                            child: Text(
                              service.category!.name ?? "",
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          RatingBar(
                            rating: double.parse(service.avgRating.toString()),
                            size: 15,
                            ratingCount: service.ratingCount,
                          ),
                          const Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 18, color: Colors.blue),
                                  SizedBox(width: 4),
                                  Text("جدة",style: TextStyle(
                                    fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff6C757D),
                                  ),),
                                ],
                              ),
                              Spacer(),
                              Icon(Icons.directions_walk,
                                  size: 18, color: Colors.blue),
                              SizedBox(width: 4),
                              Text('2.16 كم',style: TextStyle(
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
                          spreadRadius: 10,
                          offset: const Offset(0, 0),
                          blurRadius: 1,
                        )
                      ]),
                  child: ClipOval(
                    child: Image.network(
                      "${service.thumbnailFullPath}", // مسار اللوجو
                      fit: BoxFit.cover,
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
  }
}
