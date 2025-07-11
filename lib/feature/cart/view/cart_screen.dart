import 'package:get/get.dart';
import 'package:khidmh/utils/core_export.dart';
import 'package:khidmh/feature/cart/widget/cart_product_widget.dart';


class CartScreen extends StatefulWidget {
  final bool fromNav;
  const CartScreen({super.key, required this.fromNav});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ConfigModel configModel = Get.find<SplashController>().configModel;

  ProviderData? providerData;

  @override
  void initState() {
    super.initState();
    Get.find<CartController>().getCartListFromServer().then((value) {

      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        Get.find<CartController>().showMinimumAndMaximumOrderValueToaster();
        if(Get.find<CartController>().checkProviderUnavailability() && Get.currentRoute.contains(RouteHelper.cart)){
          showModalBottomSheet(
            useRootNavigator: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: Get.context!, builder: (context) =>  AvailableProviderWidget(
            subcategoryId:Get.find<CartController>().cartList.first.subCategoryId,
            showUnavailableError: true,
          ),);
        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return CustomPopScopeWidget(
      child: Scaffold(
        endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
        appBar: CustomAppBar( title: 'cart'.tr,
          isBackButtonExist: (ResponsiveHelper.isDesktop(context) || !widget.fromNav),
          onBackPressed: (){
          if(Navigator.canPop(context)){
            Get.back();
          }else{
            Get.offAllNamed(RouteHelper.getMainRoute("home"));
          }},
        ),
        body: SafeArea(child: GetBuilder<CartController>(builder: (cartController){

          providerData = Get.find<CartController>().cartList.isNotEmpty ? Get.find<CartController>().cartList[0].provider : null;

          bool timeSlotAvailable;
          if(cartController.cartList.isNotEmpty &&  cartController.cartList[0].provider!= null && cartController.cartList[0].provider!.timeSchedule != null ){
            String? startTime = cartController.cartList[0].provider?.timeSchedule?.startTime;
            String? endTime = cartController.cartList[0].provider?.timeSchedule?.endTime;
            final weekends = cartController.cartList[0].provider?.weekends ?? [];
            String currentTime = DateConverter.convertStringTimeToDate(DateTime.now());

            String dayOfWeek = DateConverter.dateToWeek(DateTime.now());

            if(startTime!=null && endTime !=null){
              timeSlotAvailable = _isUnderTime(currentTime, startTime, endTime) && (!weekends.contains(dayOfWeek.toLowerCase()));
            }else{
              timeSlotAvailable = false;
            }
          }else{
            timeSlotAvailable = false;
          }


          return Column( children: [
            Expanded(
              child: FooterBaseView(
                isCenter: (cartController.cartList.isEmpty),
                child: WebShadowWrap(
                  child: SizedBox(
                    width: Dimensions.webMaxWidth,
                    child: GetBuilder<CartController>(
                      builder: (cartController) {

                        if (cartController.isLoading) {
                          return SizedBox(
                            height: ResponsiveHelper.isMobile(context) ? MediaQuery.of(context).size.height * 0.8 : MediaQuery.of(context).size.height * 0.6,
                              child: const Center(child: CustomLoader())
                          );
                        } else {
                          if (cartController.cartList.isNotEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [


                                Column(
                                  children: [
                                    (cartController.cartList.isNotEmpty && cartController.cartList[0].provider != null) ?
                                    Container(
                                      width: ResponsiveHelper.isDesktop(context) ? 600 : Dimensions.webMaxWidth,
                                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05)),
                                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                                      child: Container(
                                        decoration : BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                                        ),
                                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault,),
                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                          Text('provider_info'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                                          const SizedBox(height: Dimensions.paddingSizeDefault),
                                          Row(children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                              child: CustomImage(
                                                height: 50, width: 50,
                                                image: "${cartController.cartList[0].provider?.logoFullPath}",
                                              ),
                                            ),
                                            const SizedBox(width: Dimensions.paddingSizeDefault),
                                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                              Text(cartController.cartList[0].provider?.companyName ?? "" , style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                                              const SizedBox(height : Dimensions.paddingSizeDefault),
                                              Text(cartController.maskNumberWithoutCountryCode(cartController.cartList[0].provider?.contactPersonPhone ?? ''), style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),

                                            ],)
                                          ]),
                                        ],
                                        ),
                                      ),
                                    ) : const SizedBox(),


                                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Padding(
                                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${cartController.cartList.length} ${'services_in_cart'.tr}",
                                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GridView.builder(
                                        key: UniqueKey(),
                                        gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: Dimensions.paddingSizeLarge,
                                          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ?
                                          Dimensions.paddingSizeLarge :
                                          Dimensions.paddingSizeMini,
                                          childAspectRatio: ResponsiveHelper.isMobile(context) ?  5 : 6 ,
                                          crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 :cartController.cartList.length > 1 ? 2:1,
                                          mainAxisExtent:ResponsiveHelper.isMobile(context) ? 140 : 150,
                                        ),
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: cartController.cartList.length,
                                        itemBuilder: (context, index) {
                                          return cartController.cartList[index].service != null
                                              ? CartServiceWidget(cart: cartController.cartList[index], cartIndex: index)
                                              : const SizedBox();
                                        },
                                      ),
                                      const SizedBox(height: Dimensions.paddingSizeSmall),
                                    ]),

                                  ],
                                ),

                                if(ResponsiveHelper.isWeb() && !ResponsiveHelper.isTab(context) && !ResponsiveHelper.isMobile(context))
                                  cartController.cartList.isNotEmpty ?
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),
                                    child: Column( children: [
                                      cartController.cartList[0].provider!= null && cartController.cartList[0].provider!.timeSchedule != null ?
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: cartController.cartList[0].provider?.serviceAvailability ==0 ? Theme.of(context).colorScheme.error.withValues(alpha: 0.1) : Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                                          border: Border(bottom: BorderSide(color: cartController.cartList[0].provider?.serviceAvailability ==0 ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary ),),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeLarge),
                                        child: Center(child: Text( timeSlotAvailable && cartController.cartList[0].provider?.serviceAvailability == 1 ? '${'provider_is_available_from'.tr} ${DateConverter.convertStringDateTimeToTime(cartController.cartList[0].provider!.timeSchedule!.startTime!)} ${'to'.tr}'
                                            ' ${DateConverter.convertStringDateTimeToTime(cartController.cartList[0].provider!.timeSchedule!.endTime!)}' : "provider_is_currently_on_a_break".tr,
                                          style: robotoMedium, textAlign: TextAlign.center,)),
                                      ) : const Divider(),
                                      SizedBox(
                                        height: 50,
                                        child: Center(
                                          child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[

                                            Text('${"total_price".tr} ',
                                              style: robotoRegular.copyWith(
                                                fontSize: Dimensions.fontSizeLarge,
                                                color: Theme.of(context).textTheme.bodyLarge!.color,
                                              ),
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Text(PriceConverter.convertPrice(Get.find<CartController>().totalPrice),
                                                style: robotoBold.copyWith(
                                                  color: Theme.of(context).colorScheme.error,
                                                  fontSize: Dimensions.fontSizeLarge,
                                                ),
                                              ),
                                            )]),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          if(Get.find<SplashController>().configModel.content?.directProviderBooking==1)
                                          providerData !=null ?
                                          GestureDetector(
                                            onTap: (){
                                              showModalBottomSheet(
                                                useRootNavigator: true,
                                                isScrollControlled: true,
                                                backgroundColor: Colors.transparent,
                                                context: context, builder: (context) =>  AvailableProviderWidget(
                                                subcategoryId: cartController.cartList.first.subCategoryId,
                                              ),);
                                            },
                                            child: SelectedProductWidget(
                                              providerData: providerData,
                                            ),
                                          ): GestureDetector(
                                            onTap: (){
                                              showModalBottomSheet(
                                                useRootNavigator: true,
                                                isScrollControlled: true,
                                                backgroundColor: Colors.transparent,
                                                context: context, builder: (context) => AvailableProviderWidget(
                                                subcategoryId: cartController.cartList.first.subCategoryId,
                                              ),);
                                            },
                                            child: const SizedBox(),
                                           // child: const UnselectedProductWidget(),
                                          ),
                                          if(Get.find<SplashController>().configModel.content?.directProviderBooking==1)
                                          const SizedBox(width: Dimensions.paddingSizeSmall),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: Dimensions.paddingSizeSmall,
                                              ),
                                              child: CustomButton(
                                                height: 50,
                                                width: Get.width,
                                                radius: Dimensions.radiusDefault,
                                                buttonText: 'proceed_to_checkout'.tr,
                                                onPressed: cartController.checkProviderUnavailability() ? (){
                                                  customSnackBar("your_selected_provider_is_unavailable_right_now".tr);
                                                } : Get.find<SplashController>().configModel.content!.minBookingAmount! >  cartController.totalPrice ? (){
                                                  cartController.showMinimumAndMaximumOrderValueToaster();
                                                } : () {
                                                  if (Get.find<SplashController>().configModel.content?.guestCheckout== 0 && !Get.find<AuthController>().isLoggedIn()) {
                                                    Get.toNamed(RouteHelper.getNotLoggedScreen(RouteHelper.cart,"cart"));
                                                  } else {
                                                    Get.find<CheckOutController>().updateState(PageState.orderDetails);
                                                    Get.toNamed(RouteHelper.getCheckoutRoute('cart','orderDetails','null'));
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    ),
                                  ):
                                  const SizedBox(),
                              ],
                            );
                          } else {
                            return NoDataScreen(
                              text: "cart_is_empty".tr,
                              type: NoDataType.cart,
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            if((ResponsiveHelper.isTab(context) || ResponsiveHelper.isMobile(context) )&& cartController.cartList.isNotEmpty )
            Column(children: [
              cartController.cartList.isNotEmpty && cartController.cartList[0].provider !=null && cartController.cartList[0].provider!.timeSchedule != null ?
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cartController.cartList[0].provider?.serviceAvailability ==0 ? Theme.of(context).colorScheme.error.withValues(alpha: 0.1) : Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  border: Border(bottom: BorderSide(color: cartController.cartList[0].provider?.serviceAvailability ==0 ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary ),),
                ),
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeLarge),
                child: Center(child: Text( timeSlotAvailable && cartController.cartList[0].provider?.serviceAvailability == 1 ? '${'provider_is_available_from'.tr} ${DateConverter.convertStringDateTimeToTime(cartController.cartList[0].provider!.timeSchedule!.startTime!)} ${'to'.tr}'
                    ' ${DateConverter.convertStringDateTimeToTime(cartController.cartList[0].provider!.timeSchedule!.endTime!)}' : "provider_is_currently_on_a_break".tr,
                  style: robotoMedium, textAlign: TextAlign.center,)),
              ): Divider(height: 2,color: Theme.of(context).shadowColor,),

              Container(
                height: 50,
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,),
                child: Center(
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('total_price'.tr,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: .6),
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(' ${PriceConverter.convertPrice((cartController.totalPrice),
                            isShowLongPrice: true)} ', style: robotoBold.copyWith(color: Theme.of(context).colorScheme.error, fontSize: Dimensions.fontSizeLarge,),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(
                  left: Dimensions.paddingSizeDefault,
                  right: Dimensions.paddingSizeDefault,
                  bottom: Dimensions.paddingSizeSmall,
                ),
                child: Row(
                  children: [
                    if(Get.find<SplashController>().configModel.content?.directProviderBooking==1)
                    cartController.cartList.isNotEmpty && cartController.cartList[0].provider !=null ?
                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                          useRootNavigator: true,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context, builder: (context) => AvailableProviderWidget(
                          subcategoryId: cartController.cartList.first.subCategoryId,
                        ),);
                      },
                      child: SelectedProductWidget(
                        providerData: providerData,
                      ),
                    ):
                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                          useRootNavigator: true,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context, builder: (context) => AvailableProviderWidget(
                          subcategoryId: cartController.cartList.first.subCategoryId,
                        ),);
                      },
                      child: const SizedBox(),
                      //child: const UnselectedProductWidget(),
                    ),
                    if(Get.find<SplashController>().configModel.content?.directProviderBooking==1)
                    const SizedBox(width: Dimensions.paddingSizeEight,),


                    Expanded(
                      child: CustomButton(
                        width: Get.width,
                        height:  ResponsiveHelper.isDesktop(context)? 50 : 45,
                        radius: Dimensions.radiusDefault,
                        buttonText: 'proceed_to_checkout'.tr,
                        onPressed: cartController.checkProviderUnavailability() ? (){
                          customSnackBar("your_selected_provider_is_unavailable_right_now".tr);
                        }: (Get.find<SplashController>().configModel.content?.minBookingAmount ?? 0) >  cartController.totalPrice ? (){
                         cartController.showMinimumAndMaximumOrderValueToaster();
                        } : () {
                          if (Get.find<SplashController>().configModel.content?.guestCheckout== 0 && !Get.find<AuthController>().isLoggedIn()) {
                            Get.toNamed(RouteHelper.getNotLoggedScreen(RouteHelper.cart,"cart"));
                          } else {
                            Get.find<CheckOutController>().updateState(PageState.orderDetails);
                            Get.toNamed(RouteHelper.getCheckoutRoute('cart','orderDetails','null'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],)
          ]);},
        )),
      ),
    );
  }

  bool _isUnderTime(String time, String startTime, String? endTime) {
    return DateConverter.convertTimeToDateTime(time).isAfter(DateConverter.convertTimeToDateTime(startTime))
        && DateConverter.convertTimeToDateTime(time).isBefore(DateConverter.convertTimeToDateTime(endTime!));
  }
}
