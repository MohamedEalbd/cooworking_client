import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

class NearbyProviderListItemView extends StatefulWidget {
  final  bool fromHomePage;
  final ProviderData providerData;
  final GlobalKey<CustomShakingWidgetState>?  signInShakeKey;
  final int index;
  const NearbyProviderListItemView({super.key, this.fromHomePage = true, required this.providerData, required this.index, this.signInShakeKey}) ;

  @override
  State<NearbyProviderListItemView> createState() => _NearbyProviderListItemViewState();
}

class _NearbyProviderListItemViewState extends State<NearbyProviderListItemView> {
  List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  List<bool> isChecked = [false, false, false, false];
  int? selectedIndex;

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder( // 👈 الحواف
                borderRadius: BorderRadius.circular(20),
              ),
             // title:  Center(child: Text("chooseTheAppropriateBranch".tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xff181F1F)),)),
              content: SizedBox(
                width: double.maxFinite,
                height: 320,
                child: Column(
                  children: [
                    Text("chooseTheAppropriateBranch".tr,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xff181F1F)),),
                  Expanded(
                    child: ListView.builder(
                      itemCount: options.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return RadioListTile<int>(
                          title: Text(options[index]),
                          value: index,
                          groupValue: selectedIndex,
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: const Color(0xff018995),
                          contentPadding: EdgeInsets.zero,
                          onChanged: (int? value) {
                            setStateDialog(() {
                              selectedIndex = value;
                            });
                          },
                        );
                      },
                    ),
                  ),
                    CustomButton(buttonText: "confirm".tr,onPressed: (){
                      if (selectedIndex != null) {
                        final selected = options[selectedIndex!];
                        if (kDebugMode) {
                          print("المختار: $selected");
                        }
                        Get.toNamed(RouteHelper.getProviderDetails(widget.providerData.id!));
                      } else {
                        if (kDebugMode) {
                          print("لم يتم اختيار أي عنصر");
                        }
                      }
                    },)
                  ],
                ),
              ),

            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearbyProviderController>(builder: (serviceController){
      return OnHover(
        isItem: true,
        child: InkWell(
          onTap: () {
            _showDialog();
            //Get.toNamed(RouteHelper.getProviderDetails(providerData.id!));
          },
          child: GetBuilder<ServiceController>(builder: (serviceController) {
            return


              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      boxShadow: Get.find<ThemeController>().darkTheme
                          ? null
                          : cardShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(Dimensions.radiusSmall)),
                          child: CustomImage(
                            image: '${widget.providerData.logoFullPath}',
                            fit: BoxFit.fitWidth,
                            width: double.maxFinite,
                            height:120,
                          ),
                        ),
                        const SizedBox(height: 35),
                        Center(
                          child: Text(
                            widget.providerData.companyName ?? "",
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Center(
                          child: RatingBar(
                            rating: double.parse(widget.providerData.avgRating.toString()),
                            size: 15,
                            ratingCount: widget.providerData.ratingCount,
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Row(
                        //         children: [
                        //           const Icon(Icons.location_on,
                        //               size: 18, color: Colors.blue),
                        //           const SizedBox(width: 4),
                        //           Expanded(
                        //             child: Text(widget.providerData.companyAddress ?? "",maxLines: 1,style: const TextStyle(
                        //               fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff6C757D),
                        //             ),),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     //const Spacer(),
                        //     const Icon(Icons.directions_walk,
                        //         size: 18, color: Colors.blue),
                        //     const SizedBox(width: 4),
                        //     Text('${(widget.providerData.distance!).toStringAsFixed(2)} كم',style: const TextStyle(
                        //       fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff6C757D),
                        //     ),),
                        //   ],
                        // ),
                      ],
                    ),
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
                          image:  "${widget.providerData.logoFullPath}", // مسار اللوجو
                          fit: BoxFit.contain,height: 80,width: 80,
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