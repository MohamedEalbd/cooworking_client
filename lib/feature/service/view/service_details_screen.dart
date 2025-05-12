import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khidmh/utils/core_export.dart';

import '../model/services_static_model.dart';
import 'meeting_room_search.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String serviceID;
  final String fromPage;
  const ServiceDetailsScreen({super.key, required this.serviceID,this.fromPage="others"}) ;

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();
  late   SharedPreferences sharedPreferences;
  @override
  void initState()  {

    Get.find<ServiceDetailsController>().getServiceDetails(widget.serviceID, fromPage: widget.fromPage == "search_page" ? "search_page" : "");

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<ServiceTabController>().pageSize??0;
        if (Get.find<ServiceTabController>().offset! < pageSize) {
          Get.find<ServiceTabController>().getServiceReview(widget.serviceID, Get.find<ServiceTabController>().offset!+1);
        }}
    });

      Get.find<ServiceController>().getRecentlyViewedServiceList(1,true,);

    super.initState();
  }
  List<ServicesStaticModel> servicesStaticList = [
    ServicesStaticModel(id: 1,icon: Images.userServicesIcon,name: "استقبال"),
    ServicesStaticModel(id: 2,icon: Images.printerIcon,name: "طباعة"),
    ServicesStaticModel(id: 3,icon: Images.iconsWifi,name: "انترنت"),

  ];
  List<ServicesStaticModel> servicesStaticListSex = [
    ServicesStaticModel(id: 4,icon: Images.coffeeIcon,name: "قهوة"),
    ServicesStaticModel(id: 5,icon: Images.groupIcon,name: "4 مواقف"),
    ServicesStaticModel(id: 6,icon: Images.wifiIcon,name: "متاح"),
  ];
  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
  updateQuantity()async{
    Future.delayed(const Duration(milliseconds: 500));
    Get.find<CartController>().updateQuantity(0,true);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
        endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
        //appBar: CustomAppBar(centerTitle: false, title: 'service_details'.tr,showCart: true,),
        body: GetBuilder<ServiceDetailsController>(
          builder: (serviceController) {
            if(serviceController.service != null){
              if(serviceController.service!.id != null){
                Service? service = serviceController.service;
                Discount discount = PriceConverter.discountCalculation(service!);
                Get.find<CartController>().setInitialCartList(service);

                Get.find<CartController>().updatePreselectedProvider(null, shouldUpdate: false);
                Get.find<AllSearchController>().searchFocus.unfocus();
                updateQuantity();
                double lowestPrice = 0.0;
                if(service.variationsAppFormat!.zoneWiseVariations != null){
                  lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
                  for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
                    if (service.variationsAppFormat!.zoneWiseVariations![i].price! < lowestPrice) {
                      lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
                    }
                  }
                }
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox.expand(
                              child: CustomImage(
                                image: service.coverImageFullPath ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.80),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(Icons.arrow_back, color: Color(0xff6B7280), size: 16),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 230,
                              child: SmoothPageIndicator(
                                  controller: pageController,  // PageController
                                  count:  3,
                                  effect: const WormEffect(
                                    dotHeight: 12,dotWidth: 12,
                                    activeDotColor: Color(0xff018995),
                                    dotColor: Colors.white,
                                  ),  // your preferred effect
                                  onDotClicked: (index){
                                  }
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    Container(
                      //height: 200,
                      margin: const EdgeInsets.only(top: 260),
                      padding:const EdgeInsets.only(top:16,left: 16,right: 16),
                      width: MediaQuery.of(context).size.width,
                      decoration:const BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(24),topLeft: Radius.circular(24)),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                 Text("${service.name}",style: const TextStyle(fontSize: 18,fontWeight:FontWeight.w500,color: Color(0xff283435)),),
                                const Spacer(),
                                Row(
                                  spacing: 5,
                                  children: [
                                    const Text('2 - 8 م',maxLines: 1,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff6C757D)),),
                                    SvgPicture.asset(Images.radio_button),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 14,),
                            Row(children: [
                              Image.asset(Images.priceCheckImage,width: 20,height: 28.26,),
                              const SizedBox(width: 16,),
                              Row(
                                children: [
                                  //price with discount
                                  if(discount.discountAmount! > 0)
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
                                  discount.discountAmount! > 0 ?
                                  Padding(
                                    padding:  EdgeInsets.only(left: Get.find<LocalizationController>().isLtr ? Dimensions.paddingSizeExtraSmall : 0.0),
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text(PriceConverter.convertPrice(
                                        lowestPrice,
                                        discount: discount.discountAmount!.toDouble(),
                                        discountType: discount.discountAmountType,
                                        isShowLongPrice:true,
                                      ),
                                        style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff606D6E)),
                                      ),
                                    ),
                                  ): Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      PriceConverter.convertPrice(double.parse(lowestPrice.toString())),
                                      style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff606D6E),
                                    )),
                                  ),
                                ],
                              )
                             // const Text('3000 ريال/شهر',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff606D6E)),),
                            ],),
                            const SizedBox(height: 8,),
                             Align(
                                alignment: Alignment.centerRight,
                                child: Text("services".tr,style:const TextStyle(fontSize: 18,fontWeight:FontWeight.w500,color: Color(0xff283435)),)),
                            const SizedBox(height: 12,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ...List.generate(servicesStaticList.length, (index)
                                {
                                  return  CustomCard(title: servicesStaticList[index].name!, image: servicesStaticList[index].icon!,);
                                }),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ...List.generate(servicesStaticListSex.length, (index){
                                  return  CustomCard(title: servicesStaticListSex[index].name!,image: servicesStaticListSex[index].icon!,);
                                }),
                              ],
                            ),
                            const SizedBox(height: 8,),
                             Row(
                               children: [
                                 Text("address".tr,style:const TextStyle(fontSize: 18,fontWeight:FontWeight.w500,color: Color(0xff283435)),),
                                 const SizedBox(width: 8,),
                                 const Text("جدة",style:TextStyle(fontSize: 18,fontWeight:FontWeight.w500,color: Color(0xff283435)),),
                               ],
                             ),
                            Image.asset(Images.mapImage,height: 180,width: double.infinity,fit: BoxFit.cover,),
                            const SizedBox(height: 12,),
                            //const Spacer(),
                            GetBuilder<CartController>(
                              builder: (cartControllerInit) {
                                return GetBuilder<CartController>(
                                  builder: (cartController) {
                                    bool addToCart = true;
                                    return cartController.isLoading ? const Center(child: CircularProgressIndicator())
                                        :
                                     CustomButton(buttonText: "add".tr,
                                      onPressed: cartControllerInit.isButton
                                          ?
                                          () async{

                                          if(addToCart) {
                                            addToCart = false;
                                            await cartController.addMultipleCartToServer(providerId: cartController.selectedProvider?.id ?? service.id ??"");
                                            await cartController.getCartListFromServer(shouldUpdate: true);
                                          }
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  MeetingRoomSearch(service: service,)));
                                      // showModalBottomSheet(
                                      //     context: context,
                                      //     useRootNavigator: true,
                                      //     isScrollControlled: true,
                                      //     backgroundColor: Colors.transparent,
                                      //     builder: (context) => ServiceCenterDialog(service: service, isFromDetails: true,)
                                      // );
                                    } :null,);
                                  }
                                );
                              }
                            ),
                            const SizedBox(height: 12,),

                          ],
                        ),
                      ),
                    ),
                  ],
                );
                return  FooterBaseView(
                  isScrollView:ResponsiveHelper.isMobile(context) ? false: true,
                  child: SizedBox(
                    width: Dimensions.webMaxWidth,
                    child: DefaultTabController(
                      length: Get.find<ServiceDetailsController>().service!.faqs!.isNotEmpty ? 3 :2,
                      child: Column(
                        children: [
                          if(!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context))
                            const SizedBox(height: Dimensions.paddingSizeDefault,),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all((!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context)) ?  const Radius.circular(8): const Radius.circular(0.0)),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            width: Dimensions.webMaxWidth,
                                            height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                            child: CustomImage(image: service.coverImageFullPath ?? ""),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            width: Dimensions.webMaxWidth,
                                            height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                            decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.6)
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: Dimensions.webMaxWidth,
                                          height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                          child: Center(child: Text(service.name ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 140,)
                                ],
                              ),
                              Positioned(
                                  bottom: -15,
                                  left: Dimensions.paddingSizeSmall,
                                  right: Dimensions.paddingSizeSmall,
                                  child: ServiceInformationCard(discount: discount,service: service,lowestPrice: lowestPrice)),
                            ],
                          ),
                          //Tab Bar
                          GetBuilder<ServiceTabController>(
                            init: Get.find<ServiceTabController>(),
                            builder: (serviceTabController) {
                              return Container(
                                color:Theme.of(context).scaffoldBackgroundColor,
                                child: Center(
                                  child: Container(
                                    width: ResponsiveHelper.isMobile(context) ?null : Get.width / 3,
                                    color: Get.isDarkMode?Theme.of(context).scaffoldBackgroundColor:Theme.of(context).cardColor,
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                    child: DecoratedTabBar(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Theme.of(context).colorScheme.primary.withOpacity(.3),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      tabBar: TabBar(
                                          padding: const EdgeInsets.only(top: Dimensions.paddingSizeMini),
                                          unselectedLabelColor: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.4),
                                          controller: serviceTabController.controller!,
                                          labelColor:Get.isDarkMode? Colors.white : Theme.of(context).primaryColor,
                                          labelStyle: robotoBold.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                          ),
                                          indicatorColor: Theme.of(context).colorScheme.primary,
                                          indicatorPadding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                                          labelPadding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                                          indicatorWeight: 2,
                                          onTap: (int? index) {
                                            switch (index) {
                                              case 0:
                                                serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.serviceOverview);
                                                break;
                                              case 1:
                                                serviceTabController.serviceDetailsTabs().length > 2 ?
                                                serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.faq):
                                                serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.review);
                                                break;
                                              case 2:
                                                serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.review);
                                                break;
                                            }
                                          },
                                          tabs: serviceTabController.serviceDetailsTabs()
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          //Tab Bar View
                          GetBuilder<ServiceTabController>(
                            initState: (state){
                              Get.find<ServiceTabController>().getServiceReview(serviceController.service!.id!,1);
                            },
                            builder: (controller){
                              Widget tabBarView = TabBarView(
                                controller: controller.controller,
                                children: [
                                  SingleChildScrollView(child: ServiceOverview(description:service.description!)),
                                  if(Get.find<ServiceDetailsController>().service!.faqs!.isNotEmpty)
                                    const SingleChildScrollView(child: ServiceDetailsFaqSection()),
                                  if(controller.reviewList != null)
                                    SingleChildScrollView(
                                      child: ServiceDetailsReview(
                                        serviceID: serviceController.service!.id!,
                                       ),
                                    )
                                  else
                                    const EmptyReviewWidget()
                                ],
                              );

                              if(ResponsiveHelper.isMobile(context)){
                                return Expanded(
                                  child: tabBarView,
                                );
                              }else{
                                return SizedBox(
                                  height: 500,
                                  child: tabBarView,);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }else{
                return NoDataScreen(text: 'no_service_available'.tr,type: NoDataType.service,);
              }
            }else{
              return const ServiceDetailsShimmerWidget();
            }
      
          },
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.title,  this.image='',this.onTap});
  final void Function()? onTap;
  final String title;
  final String image ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: const Color(0xffF5FAFB)
        ),
        child: Row(
          children: [
            if(image.isNotEmpty)
              SvgPicture.asset(image,width: 24,height: 24,),
            const SizedBox(width: 12,),
            Text(title,style:const TextStyle(
              fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff38494A),
            ),),
          ],
        ),
      ),
    );
  }
}
