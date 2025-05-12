import 'package:flutter_svg/svg.dart';
import 'package:khidmh/feature/home/widget/build_category_widget.dart';
import 'package:khidmh/feature/home/widget/location_banner_view_widget.dart';
import 'package:khidmh/feature/home/widget/nearby_provider_listview.dart';
import 'package:get/get.dart';
import 'package:khidmh/feature/home/widget/person_view_vertical.dart';
import 'package:khidmh/utils/core_export.dart';

import 'all_company_screen.dart';

class HomeScreen extends StatefulWidget {
  static Future<void> loadData(bool reload, {int availableServiceCount = 1}) async {

    if(availableServiceCount==0){
      Get.find<BannerController>().getBannerList(reload);
    }else{
      await Future.wait([
        Get.find<ServiceController>().getRecommendedSearchList(),
        Get.find<ServiceController>().getAllServiceList(1,reload),
        Get.find<BannerController>().getBannerList(reload),
        Get.find<AdvertisementController>().getAdvertisementList(reload),
        Get.find<CategoryController>().getCategoryList(reload),
        Get.find<ServiceController>().getPopularServiceList(1,reload),
        Get.find<ServiceController>().getTrendingServiceList(1,reload),
        Get.find<ProviderBookingController>().getProviderList(1,reload),
        Get.find<NearbyProviderController>().getProviderList(1,reload),
        Get.find<NearbyProviderController>().getProviderIndependentList(1,reload),
        Get.find<CampaignController>().getCampaignList(reload),
        //Get.find<ServiceController>().getRecommendedServiceList(1, reload),
        Get.find<CheckOutController>().getOfflinePaymentMethod(false, shouldUpdate: false),
        Get.find<ServiceController>().getFeatherCategoryList(reload),
        // Get.find<ServiceAreaController>().getZoneList(reload: reload),
        // Get.find<WebLandingController>().getWebLandingContent(),
        //Get.find<ServiceController>().getRecommendedSearchList(),
        if(Get.find<AuthController>().isLoggedIn())  Get.find<AuthController>().updateToken(),
        if(Get.find<AuthController>().isLoggedIn())  Get.find<ServiceController>().getRecentlyViewedServiceList(1,reload),
      ]);

      Get.find<BookingDetailsController>().manageDialog();

    }
  }
  final AddressModel? addressModel;
  final bool showServiceNotAvailableDialog;
  const HomeScreen({super.key, this.addressModel, required this.showServiceNotAvailableDialog}) ;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AddressModel? _previousAddress;
  int availableServiceCount = 0;

  @override
  void initState() {
    super.initState();

    Get.find<LocalizationController>().filterLanguage(shouldUpdate: false);
    if(Get.find<AuthController>().isLoggedIn()) {
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
    }
    if(Get.find<LocationController>().getUserAddress() !=null){
      availableServiceCount = Get.find<LocationController>().getUserAddress()!.availableServiceCountInZone!;
    }
    HomeScreen.loadData(false, availableServiceCount: availableServiceCount);

    _previousAddress = widget.addressModel;

    if (_previousAddress != null && availableServiceCount == 0 && widget.showServiceNotAvailableDialog) {
      Future.delayed(const Duration(microseconds: 1000), () {
        Get.dialog(
            ServiceNotAvailableDialog(
              address: _previousAddress,
              forCard: false,
              showButton: true,
              onBackPressed: () {
                Get.back();
                Get.find<LocationController>().setZoneContinue('false');
              },
            )
        );
      });
    }
  }

  homeAppBar({GlobalKey<CustomShakingWidgetState>? signInShakeKey}){
    if(ResponsiveHelper.isDesktop(context)){
      return WebMenuBar(signInShakeKey: signInShakeKey,);
    }else{
      return const AddressAppBar(backButton: false);
    }
  }
  final ScrollController scrollController = ScrollController();
  final signInShakeKey = GlobalKey<CustomShakingWidgetState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      //appBar: homeAppBar(signInShakeKey: signInShakeKey),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer() : null,
      body: ResponsiveHelper.isDesktop(context)
          ?
      WebHomeScreen(scrollController: scrollController, availableServiceCount: availableServiceCount, signInShakeKey : signInShakeKey,)
          :
      SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {

            if(availableServiceCount > 0){
              await Get.find<ServiceController>().getAllServiceList(1,true);
              await Get.find<BannerController>().getBannerList(true);
              await  Get.find<AdvertisementController>().getAdvertisementList(true);
              await Get.find<CategoryController>().getCategoryList(true);
              //await Get.find<ServiceController>().getRecommendedServiceList(1,true);
              await Get.find<ProviderBookingController>().getProviderList(1, true);
              await Get.find<ServiceController>().getPopularServiceList(1,true,);
              await Get.find<ServiceController>().getRecentlyViewedServiceList(1,true,);
              await Get.find<ServiceController>().getTrendingServiceList(1,true,);
              await Get.find<CampaignController>().getCampaignList(true);
              await Get.find<ServiceController>().getFeatherCategoryList(true);
              await Get.find<CartController>().getCartListFromServer();
            }else{
              await Get.find<BannerController>().getBannerList(true);
            }
          },
          child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: GetBuilder<SplashController>(builder: (splashController){
                return GetBuilder<ProviderBookingController>(builder: (providerController){
                  return GetBuilder<ServiceController>(builder: (serviceController){
                    bool isAvailableProvider = providerController.providerList != null && providerController.providerList!.isNotEmpty;
                    int ? providerBooking = splashController.configModel.content?.directProviderBooking;
                    bool isLtr = Get.find<LocalizationController>().isLtr;
                    return  CustomScrollView(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: ClampingScrollPhysics()
                      ),
                      slivers: [
                        SliverAppBar(
                          titleSpacing: 0,
                          expandedHeight: 160,
                          flexibleSpace: PreferredSize(preferredSize:const Size(double.infinity, 350),
                            child:
                            Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(fit: BoxFit.cover,image: AssetImage(Images.bgAppBar))
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 18,
                                children: [
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      SvgPicture.asset(Images.titleLogo,height: 40,width: 224,),
                                      const Spacer(),
                                      Container(
                                        height: 45,width: 45,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color:const Color(0xffFFFFFF).withOpacity(0.05),
                                            shape: BoxShape.circle,
                                            boxShadow:const [
                                              BoxShadow(
                                                color: Color(0xFF181F1F),
                                                offset: Offset(2, 2),
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                              )
                                            ]
                                        ),
                                        child:SvgPicture.asset(Images.bellRinging,height: 24,width: 24,),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                        
                                          onTap: () => Get.dialog(const SearchSuggestionDialog(), transitionCurve: Curves.easeIn),
                                        
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              left: Get.find<LocalizationController>().isLtr ? Dimensions.paddingSizeDefault : 0,
                                              right:   Get.find<LocalizationController>().isLtr ? 0 : Dimensions.paddingSizeDefault,
                                            ),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                             // boxShadow: Get.find<ThemeController>().darkTheme ? null : searchBoxShadow,
                                             // borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
                                              color: const Color(0xff283435),
                                            ),
                                            child: Row( children: [

                                              const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                                              Expanded(child: Text('search_services'.tr,maxLines: 1, style: robotoRegular.copyWith(color: Theme.of(context).hintColor))),
                                              //const Spacer(),
                                              Container(height: 45, width: 45,
                                                // decoration: BoxDecoration(
                                                //     color: Theme.of(context).colorScheme.primary,shape: BoxShape.circle
                                                // ),
                                                margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                                child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall + 3),
                                                  child: Image.asset(Images.searchIcon),
                                                ),
                                              ),

                                            ]),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8,),
                                      //const Spacer(),
                                      InkWell(
                                        onTap: (){
                                          Get.toNamed(RouteHelper.getProviderWebView());
                                          //GetPlatform.isWeb ? '${AppConstants.baseUrl}/provider/auth/sign-up' : RouteHelper.getProviderWebView();
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 127,
                                             height: 45,
                                            //padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                                            decoration: BoxDecoration(
                                              color:const Color(0xFFFFDD00),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text("registerAsAServiceProvider".tr,style: const TextStyle(color: Color(0xff181F1F),fontWeight: FontWeight.w500,fontSize: 12),)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ),

                          ),
                          ),
                        ),

                       // const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeSmall)),

                       // const HomeSearchWidget(),

                        SliverToBoxAdapter(
                          child: Center(
                              child: SizedBox(width: Dimensions.webMaxWidth, child: Column(children: [

                            const BannerView(),

                            availableServiceCount > 0
                                ?
                            Column(
                              children: [
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: BuildCategoryWidget(img:Images.categoryOne,txt:"sharedSpaces".tr,onTap:(){
                                            Navigator.push(context, MaterialPageRoute(builder: (_) =>  AllCompanyScreen(txt: "sharedSpaces".tr,)));
                                          })
                                      ),
                                      const SizedBox(width: 16,),
                                      Expanded(
                                          child: BuildCategoryWidget(img:Images.bussinesIcon,txt:"businessServices".tr,onTap:(){
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: SizedBox(
                                                          height: 150,
                                                          child: Center(
                                                            child: Text(
                                                              'soon'.tr,
                                                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 8,
                                                        right: 8,
                                                        child: GestureDetector(
                                                          onTap: () => Navigator.of(context).pop(),
                                                          child: const Icon(Icons.close, size: 24),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );

                                          })
                                      ),
                                    ],
                                  ),
                                ),
                              // const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                              //   child: CategoryView(),
                              // ),

                              // const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                              //   child: HighlightProviderWidget(),
                              // ),

                             // const SizedBox(height: Dimensions.paddingSizeLarge),
                             // HorizontalScrollServiceView(fromPage: 'popular_services',serviceList: serviceController.popularServiceList),

                             // const RandomCampaignView(),

                              // const SizedBox(height: Dimensions.paddingSizeLarge),
                             //  RecommendedServiceView(height: isLtr ? 225 : 240,),

                             // SizedBox(height: (providerBooking == 1 && (isAvailableProvider || providerController.providerList == null)) ? Dimensions.paddingSizeLarge : 0,),


                              NearbyProviderListview(height:  isLtr ? 190 : 205,fromHome: true,),

                                //const LocationBannerViewWidget(),
                              ///
                              // (providerBooking == 1 && (isAvailableProvider || providerController.providerList == null)) ?
                              // Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeLarge),
                              //   child: SizedBox(
                              //     height: 160,
                              //     child: ExploreProviderCard(showShimmer: providerController.providerList == null,),
                              //   ),
                              // ) : const SizedBox(),

                              // if(Get.find<SplashController>().configModel.content?.directProviderBooking==1)
                              //   const HomeRecommendProvider(height: 220,),
                              //
                              // if(Get.find<SplashController>().configModel.content?.biddingStatus == 1)
                              //   (serviceController.allService != null && serviceController.allService!.isNotEmpty) ?
                              //   const Padding(
                              //     padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeLarge),
                              //     child: HomeCreatePostView(showShimmer: false,),
                              //   ) : const SizedBox(),
                              //
                              //
                              // if(Get.find<AuthController>().isLoggedIn())
                              //   HorizontalScrollServiceView(fromPage: 'recently_view_services',serviceList: serviceController.recentlyViewServiceList),
                              // const CampaignView(),
                              // HorizontalScrollServiceView(fromPage: 'trending_services',serviceList: serviceController.trendingServiceList),
                              //
                              // const FeatheredCategoryView(),

                              // (serviceController.allService != null && serviceController.allService!.isNotEmpty) ? (ResponsiveHelper.isMobile(context) || ResponsiveHelper.isTab(context))?  Padding(
                              //   padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 15, Dimensions.paddingSizeDefault,  Dimensions.paddingSizeSmall,),
                              //   child: TitleWidget(
                              //     textDecoration: TextDecoration.underline,
                              //     title: 'all_service'.tr,
                              //     onTap: () => Get.toNamed(RouteHelper.getSearchResultRoute()),
                              //   ),
                              // ) : const SizedBox.shrink() : const SizedBox.shrink(),
                                ///
                                  //PersonViewVertical(height:  isLtr ? 190 : 205),
                                ///
                                // itemView: ServiceViewVertical(
                                //   service: serviceController.serviceContent != null ? serviceController.allService : null,
                                //   padding: EdgeInsets.symmetric(
                                //     horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault,
                                //     vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0,
                                //   ),
                                //   type: 'others',
                                //   noDataType: NoDataType.home,
                                // ),
                              //),
                            ],)
                                :
                            SizedBox( height: MediaQuery.of(context).size.height *.6, child: const ServiceNotAvailableScreen())

                          ]))),
                        ),
                      ],
                    );
                  });
                });
              })
          ),
        ),
      ),
    );
  }


}

