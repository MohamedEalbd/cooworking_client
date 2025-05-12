import 'package:flutter_svg/flutter_svg.dart';
import 'package:khidmh/feature/provider/widgets/provider_details_shimmer.dart';
import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

import '../../../common/widgets/new_build_custom_app_bar.dart';
import '../../home/widget/build_category_widget.dart';
import '../../service/view/new_all_service_view.dart';


class ProviderDetailsScreen extends StatefulWidget {
  final String providerId;
  const ProviderDetailsScreen({super.key,required this.providerId}) ;


  @override
  ProviderDetailsScreenState createState() => ProviderDetailsScreenState();
}

class ProviderDetailsScreenState extends State<ProviderDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  @override
  void initState() {
    Get.find<ProviderBookingController>().getProviderDetailsData(widget.providerId, true).then((value){
      tabController = TabController(length: 3, vsync: this);
      // tabController.addListener(() {
      //   if (!tabController.indexIsChanging) {
      //     setState(() {
      //       currentTabIndex = tabController.index;
      //     });
      //   }
      // });
      //tabController = TabController(length: Get.find<ProviderBookingController>().categoryItemList.length, vsync: this);
      Get.find<CartController>().updatePreselectedProvider(
          null
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
     // appBar: CustomAppBar(title: "provider_details".tr,showCart: true,),
      body: Center(
        child: GetBuilder<ProviderBookingController>(
          builder: (providerBookingController){
            if(providerBookingController.providerDetailsContent!=null){

              if(providerBookingController.categoryItemList.isEmpty){
                return Column(
                  children: [
                    NewBuildCustomAppBar(txt: "provider_details".tr),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                      
                            if(providerBookingController.providerDetailsContent?.provider?.serviceAvailability ==0)
                            Container(
                              width: Dimensions.webMaxWidth,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
                                  border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.error))
                              ),
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeLarge),
                              child: Center(child: Text('provider_is_currently_unavailable'.tr, style: robotoMedium,)),
                            ),
                      
                            SizedBox( width: Dimensions.webMaxWidth, child: ProviderDetailsTopCard( providerId: widget.providerId,)),
                            SizedBox(
                              height: Get.height*0.5, width: Dimensions.webMaxWidth,
                              child: Center(child: Text('no_subscribed_subcategories_available'.tr),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              else{
                return Column(
                  children: [
                    NewBuildCustomAppBar(txt: "provider_details".tr),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if(providerBookingController.providerDetailsContent?.provider?.serviceAvailability ==0)
                              SizedBox(
                                width: Dimensions.webMaxWidth,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
                                      border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.error))
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeLarge),
                                  child: Center(child: Text('provider_is_currently_unavailable'.tr, style: robotoMedium,)),
                                ),
                              ),
                      
                            SizedBox( height: Get.height * 0.9, width: Dimensions.webMaxWidth,
                              child:DefaultTabController(
                                length: 3,
                                child: NestedScrollView(
                                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                                    SliverAppBar(
                                      automaticallyImplyLeading: false,
                                      backgroundColor: Get.isDarkMode ? null : Theme.of(context).cardColor,
                                      pinned: true,
                                      floating: false,
                                      elevation: 0,
                                      toolbarHeight: ResponsiveHelper.isDesktop(context) ? 170 : 220,
                                      flexibleSpace: ProviderDetailsTopCard(providerId: widget.providerId),
                                      bottom: PreferredSize(
                                        preferredSize: const Size.fromHeight(45),
                                        child: Container(
                                          height: 45,
                                          width: Dimensions.webMaxWidth,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Theme.of(context).colorScheme.primary,
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                          child: TabBar(
                                            controller: tabController,
                                            isScrollable: false,
                                            indicatorColor: const Color(0xff293737),
                                            labelColor: const Color(0xff293737),
                                            unselectedLabelColor: const Color(0xff293737).withOpacity(0.7),
                                            unselectedLabelStyle: const TextStyle(color: Color(0xff898A8F),fontSize: 14,fontWeight: FontWeight.w500),
                                            tabs: [
                                              Tab(text: "aboutCompany".tr),
                                              Tab(text: 'services'.tr),
                                              Tab(text: "contactUs".tr),
                                            ],
                                            onTap: (index) {
                                              setState(() {
                                                currentTabIndex = index;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  body: TabBarView(
                                    controller: tabController,
                                    children: [
                                      _aboutCompanyWidget(),
                                      _servicesWidget(providerBookingController),
                                      _contactUsWidget(),
                                    ],
                                  ),
                                ),
                              ),
                              // child: VerticalScrollableTabView(
                              //   tabController: tabController,
                              //   listItemData: providerBookingController.categoryItemList,
                              //   verticalScrollPosition: VerticalScrollPosition.begin,
                              //   eachItemChild: (object, index){
                              //     if(index  == 0 ){
                              //       return Container(
                              //         padding: const EdgeInsets.all(16),
                              //         decoration: BoxDecoration(
                              //           color: Colors.white,
                              //           borderRadius: BorderRadius.circular(12),
                              //         ),
                              //         child: Column(
                              //           crossAxisAlignment: CrossAxisAlignment.start,
                              //           children: [
                              //             const Text(
                              //               "نبذة عن الشركة:",
                              //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              //             ),
                              //             const SizedBox(height: 8),
                              //             const Text(
                              //               "لوريم ايبسوم هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى)...",
                              //               style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                              //             ),
                              //             const SizedBox(height: 16),
                              //             const Divider(),
                              //             _buildInfoRow("المساحة الإجمالية", "8000 م²"),
                              //             const Divider(),
                              //             _buildInfoRow("الدور", "الثاني"),
                              //             const Divider(),
                              //             _buildInfoRow("المدينة", "الرياض"),
                              //             const Divider(),
                              //             _buildInfoRow("الحي", "الرياض"),
                              //           ],
                              //         ),
                              //       );
                              //     }
                              //     else if(index  == 1){
                              //       return CategorySection(
                              //         category: object as CategoryModelItem,
                              //         providerData: providerBookingController.providerDetailsContent?.provider,
                              //       );
                              //     }
                              //     else if(index  == 2 ){
                              //       return Row(
                              //         children: [
                              //           _buildSocialIcon(Images.insIcon,"انستغرام"),
                              //           _buildSocialIcon(Images.globalIcon,"الموقع الالكتروني"),
                              //           _buildSocialIcon(Images.location_icon,"غوغل ماب"),
                              //         ],
                              //       );
                              //     }
                              //     else{
                              //       return Container();
                              //     }
                              //   },
                              //   slivers: [
                              //     SliverAppBar(
                              //       automaticallyImplyLeading: false,
                              //       backgroundColor: Get.isDarkMode? null:Theme.of(context).cardColor,
                              //       pinned: true,
                              //       leading: const SizedBox(),
                              //       actions: const [ SizedBox()],
                              //       flexibleSpace: ProviderDetailsTopCard(providerId: widget.providerId,),
                              //       toolbarHeight: ResponsiveHelper.isDesktop(context) ? 170 : 220,
                              //       elevation: 0,
                              //       bottom: AppBar(
                              //         automaticallyImplyLeading: false,
                              //         backgroundColor: Theme.of(context).cardColor,
                              //         elevation: 0,
                              //         leadingWidth: 0,
                              //         centerTitle: false,
                              //         actions: const [
                              //           SizedBox()
                              //         ],
                              //         title: Container(
                              //           height: 45, width: Dimensions.webMaxWidth,
                              //           color: Theme.of(context).cardColor,
                              //           child: DecoratedBox(
                              //             decoration: BoxDecoration(
                              //               color: Colors.white.withValues(alpha: 0.0),
                              //               border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 0.5),),
                              //             ),
                              //             child: TabBar(
                              //               isScrollable: false,
                              //               controller: tabController,
                              //               indicatorColor: Theme.of(context).colorScheme.primary,
                              //               labelColor: Theme.of(context).colorScheme.primary,
                              //               unselectedLabelColor: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                              //               unselectedLabelStyle: robotoRegular,
                              //               tabs: [
                              //               Tab(text: "aboutCompany".tr),
                              //               Tab(text: 'services'.tr),
                              //               Tab(text: "contactUs".tr),
                              //               ],
                              //               onTap: (index){
                              //                 setState(() {
                              //                   currentTabIndex = index;
                              //                 });
                              //               },
                              //               // tabs: providerBookingController.categoryItemList.map((e) {
                              //               //   return Tab(text: e.title);
                              //               // }).toList(),
                              //               // onTap: (index) {
                              //               //   VerticalScrollableTabBarStatus.setIndex(index);
                              //               // },
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ),
                            ResponsiveHelper.isDesktop(context)?
                            const FooterView() : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

            }else{
              return const FooterBaseView(child: ProviderDetailsShimmer());
            }
          },
        ),
      ),
    );
  }
  Widget _aboutCompanyWidget() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("نبذة عن الشركة:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          const Text("شركة مساحات عمل تقدم بيئة عمل مرنة ومجهزة بالكامل للمستقلين والشركات الناشئة. توفر مكاتب خاصة، قاعات اجتماعات، مساحات مشتركة، وخدمات إدارية، مما يساعد على تعزيز الإنتاجية والتواصل المهني في أجواء محفزة وعصرية.",
              style: TextStyle(fontSize: 12, height: 1.5,color: Color(0xff6C757D))),
          const SizedBox(height: 16),
          const Divider(),
          _buildInfoRow("المساحة الإجمالية", "8000 م²"),
          const Divider(),
          _buildInfoRow("الدور", "الثاني"),
          const Divider(),
          _buildInfoRow("المدينة", "الرياض"),
          const Divider(),
          _buildInfoRow("الحي", "الرياض"),
        ],
      ),
    );
  }

   _servicesWidget(ProviderBookingController providerBookingController) {
    return GetBuilder<CategoryController>(
      builder: (categoryController) {
        return  categoryController.categoryList != null && categoryController.categoryList!.isEmpty
            ?
        const SizedBox()
            :
        categoryController.categoryList != null ? GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 16,
              childAspectRatio: 1,
              mainAxisSpacing:  16,
              mainAxisExtent: ResponsiveHelper.isDesktop(context) ?  270 : 120 ,
              crossAxisCount: ResponsiveHelper.isDesktop(context) ? 5 : ResponsiveHelper.isTab(context) ? 3 : 2 ),
          itemCount: categoryController.categoryList!.length,
          itemBuilder: (context, index) {
           // final category = providerBookingController.categoryItemList[index];
            return BuildCategoryWidget(
              onTap: () {
                _showBottomSheetWithList(context,categoryController.categoryList![index].id!);
            },
              img: categoryController.categoryList![index].imageFullPath!,
              txt: categoryController.categoryList![index].name!,);
            // return CategorySection(
            //   category: category,
            //   providerData: providerBookingController.providerDetailsContent?.provider,
            // );
          },
        ) : const CategoryShimmer();
      }
    );
  }
  void _showBottomSheetWithList(BuildContext context,String categoryID) {

    int selectedRadioIndex = -1;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return  GetBuilder<CategoryController>(
            initState: (state){
              Get.find<CategoryController>().getSubCategoryList(categoryID ?? "",shouldUpdate: false); //banner id is category here

            },
          builder: (categoryController) {
            List<bool> checked = List.filled(
                categoryController.subCategoryList?.length ?? 0, false);
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: categoryController.subCategoryList != null &&  categoryController.subCategoryList!.isEmpty
                      ?
                  const SizedBox()
                      :
                  categoryController.subCategoryList != null
                      ?
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: categoryController.subCategoryList!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Radio<int>(
                                value: index, // ✅ قيمة الزر هذا
                                groupValue: selectedRadioIndex, // ✅ المتغير الذي يخزن القيمة المختارة
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedRadioIndex = value ?? 0;
                                  });
                                },
                                activeColor: const Color(0xff018995), // ✅ لون الدائرة عندما تكون محددة
                                fillColor: MaterialStateProperty.all(const Color(0xff018995)), // ✅ لون التعبئة
                              ),
                              // leading: Checkbox(
                              //   value: checked[index],
                              //   onChanged: (bool? value) {
                              //     setState(() {
                              //       checked[index] = value ?? false;
                              //     });
                              //   },
                              //   side: const BorderSide(
                              //     color:  Color(0xff018995), // ✅ لون الـ border هنا
                              //     width: 2,
                              //   ),
                              //   activeColor: const Color(0xff018995), // ✅ لون التعبئة عند التحديد
                              //   checkColor: Colors.white,  // ✅ لون علامة الصح
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(4),
                              //   ),
                              // ),
                              title: Text(
                                categoryController.subCategoryList![index].name!,
                                textAlign: TextAlign.right,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8,),
                      CustomButton(buttonText: 'choose'.tr,onPressed: selectedRadioIndex == -1 ? null :(){
                        Get.find<ServiceController>().cleanSubCategory();
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => NewAllServiceView()));
                        Get.toNamed(RouteHelper.allServiceScreenRoute(categoryController.subCategoryList![selectedRadioIndex].id!.toString()));
                        
                      },),
                      const SizedBox(height: 8,),
                    ],
                  ) : const SizedBox(),
                );
              },
            );
          }
        );
      },
    );
  }

  Widget _contactUsWidget() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSocialIcon(Images.insIcon, "انستغرام"),
          _buildSocialIcon(Images.globalIcon, "الموقع الالكتروني"),
          _buildSocialIcon(Images.location_icon, "غوغل ماب"),
        ],
      ),
    );
  }

  _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Color(0xff6C757D),fontWeight:FontWeight.w400)),
          Text(value, style:  const TextStyle(fontSize: 12, color: Color(0xff181F1F),fontWeight:FontWeight.w400)),
        ],
      ),
    );
  }

   _buildSocialIcon(String assetPath, String label) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
            decoration: const BoxDecoration(
              color: Color(0xffF5FAFB),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(assetPath),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff334243),
            ),
          ),
        ],
      ),
    );
  }

}