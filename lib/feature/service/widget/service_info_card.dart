import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

class ServiceInformationCard extends StatelessWidget {
  final Discount? discount;
  final Service service;
  final double lowestPrice;
  const ServiceInformationCard({super.key, required this.discount, required this.service, required this.lowestPrice,}) ;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceDetailsController>(builder: (serviceController){
      return Center(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault ,vertical:Dimensions.paddingSizeDefault),
          child: Container(
            width: Dimensions.webMaxWidth,
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              // border: Border.all(color: Theme.of(context).colorScheme.primary),
              color:Get.isDarkMode ? Theme.of(context).primaryColorDark:Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),
              boxShadow: Get.find<ThemeController>().darkTheme ? null : cardShadow,
            ),
            child:
            Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          child: CustomImage(
                            image: service.thumbnailFullPath ?? "",
                            fit: BoxFit.cover,
                            placeholder: Images.placeholder,
                            height:ResponsiveHelper.isMobile(context) ? 130 :Dimensions.imageSizeButton,
                            width:ResponsiveHelper.isMobile(context) ? 145: Dimensions.imageSizeButton,
                          ),
                        ),
                        DiscountTag(fromTop: 0,
                            color: Theme.of(context).colorScheme.error,
                            discount: discount!.discountAmount!,
                            discountType: discount!.discountAmountType)
                      ],
                    ),
                    //SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                    if(ResponsiveHelper.isMobile(context))
                      Row(
                        children: [
                          SizedBox(height: 35,
                            child: Row(
                              children: [
                                Gaps.horizontalGapOf(3),
                                Image(image: AssetImage(Images.starIcon)),
                                Gaps.horizontalGapOf(5),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(
                                      service.avgRating!.toStringAsFixed(2),
                                      style: robotoBold.copyWith(color: Theme.of(context).colorScheme.secondary)),
                                ),
                              ],
                            ),
                          ),
                          Gaps.horizontalGapOf(5),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                                "(${service.ratingCount})",
                                style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6))),
                          )
                        ],
                      ),
                  ],
                ),
                //description price and add to card
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !ResponsiveHelper.isMobile(context)?
                          Row(
                            children: [
                              SizedBox(height: 25,
                                child: Row(
                                  children: [
                                    Gaps.horizontalGapOf(3),
                                    Image(image: AssetImage(Images.starIcon)),
                                    Gaps.horizontalGapOf(5),
                                    Directionality(textDirection: TextDirection.ltr,
                                      child: Text(
                                          service.avgRating!.toStringAsFixed(2),
                                          style: robotoBold.copyWith(color: Theme.of(context).colorScheme.secondary)),
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.horizontalGapOf(5),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                    "(${service.ratingCount})",
                                    style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6))),
                              )
                            ],
                          ):const SizedBox(),

                          if(ResponsiveHelper.isWeb())
                            const SizedBox(width: Dimensions.paddingSizeSmall,),
                          Row(
                            children: [
                              //price with discount
                              if(discount!.discountAmount! > 0)
                                Padding(
                                  padding:  EdgeInsets.only(left: Get.find<LocalizationController>().isLtr ?  0.0 : Dimensions.paddingSizeExtraSmall),
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(PriceConverter.convertPrice(lowestPrice,isShowLongPrice: true),
                                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                          decoration: TextDecoration.lineThrough,
                                          color: Theme.of(context).colorScheme.error.withOpacity(.8)),
                                    ),
                                  ),
                                ),
                              discount!.discountAmount! > 0 ?
                              Padding(
                                padding:  EdgeInsets.only(left: Get.find<LocalizationController>().isLtr ? Dimensions.paddingSizeExtraSmall : 0.0),
                                child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(PriceConverter.convertPrice(
                                    lowestPrice,
                                    discount: discount!.discountAmount!.toDouble(),
                                    discountType: discount!.discountAmountType,
                                    isShowLongPrice:true,
                                  ),
                                    style: robotoRegular.copyWith(fontSize: Dimensions.paddingSizeDefault, color:Get.isDarkMode ? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ): Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  PriceConverter.convertPrice(double.parse(lowestPrice.toString())),
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.paddingSizeDefault,
                                      color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor
                                  ),
                                ),
                              ),
                            ],
                          )

                        ],
                      ),

                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              serviceController.service!.shortDescription!,
                              textAlign: TextAlign.start, maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: robotoRegular.copyWith(
                                  fontSize: 14,
                                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)
                              ),),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  useRootNavigator: true,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => ServiceCenterDialog(service: service, isFromDetails: true,)
                              );
                            },
                            child: Text('${"add".tr} +',style: robotoRegular.copyWith(color: Colors.white),),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
