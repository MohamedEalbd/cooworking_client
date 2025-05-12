import 'package:khidmh/feature/provider/view/nearby_provider/widget/nearby_provider_list_item_view.dart';
import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

import '../all_company_screen.dart';

class NearbyProviderListview extends StatelessWidget {
  final double height;
  final bool fromHome;
  final GlobalKey<CustomShakingWidgetState>?  signInShakeKey;
  const NearbyProviderListview({super.key, required this.height, this.signInShakeKey,this.fromHome = false}) ;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearbyProviderController>(
        builder: (providerBookingController){
          return providerBookingController.providerList != null && providerBookingController.providerList!.isNotEmpty
              ?
          Column(children: [
           // const SizedBox(height: Dimensions.paddingSizeDefault),
          
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault,  0,),
              child: TitleWidget(
                textDecoration: TextDecoration.underline,
                title:'bestRated'.tr,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>  AllCompanyScreen(txt: "sharedSpaces".tr,)));
                },
                //onTap: () => Get.toNamed(RouteHelper.getNearByProviderScreen(tabIndex: 0)),
              ),
            ),
            // SizedBox( height:  Get.find<LocalizationController>().isLtr ? 160 : 180,
            //   child: ListView.builder(
            //     controller: scrollController,
            //     physics: const ClampingScrollPhysics(),
            //     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeEight -1),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: providerBookingController.providerList?.length,
            //     itemBuilder: (context, index){
            //       Discount discountValue =  PriceConverter.discountCalculation(serviceController.recommendedproviderBookingController.providerList![index]);
            //       return SizedBox(
            //         width: ResponsiveHelper.isDesktop(context) ? Dimensions.webMaxWidth / 3.2 : ResponsiveHelper.isTab(context)? Get.width/ 2.5 :  Get.width/1.16,
            //         child: ServiceWidgetHorizontal(
            //           providerBookingController.providerList: serviceController.recommendedproviderBookingController.providerList!,
            //           discountAmountType: discountValue.discountAmountType,
            //           discountAmount: discountValue.discountAmount,
            //           index: index,
            //           signInShakeKey: signInShakeKey,
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault,  Dimensions.paddingSizeSmall,),
              child: GridView.builder(
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: Dimensions.paddingSizeLarge,
                    //mainAxisSpacing:  Dimensions.paddingSizeDefault,
                    mainAxisExtent: ResponsiveHelper.isDesktop(context) ?  270 : 220 ,
                   // childAspectRatio: 3/2,
                    crossAxisCount: ResponsiveHelper.isDesktop(context) ? 5 : ResponsiveHelper.isTab(context) ? 3 : 2 ),
                shrinkWrap: true, // يخليه ياخد ارتفاع العناصر فقط
                physics: const NeverScrollableScrollPhysics(),
                itemCount: fromHome == true ? providerBookingController.providerList!.length > 2 ? 2 : providerBookingController.providerList?.length : providerBookingController.providerList?.length,
                itemBuilder: (context, index){
                  return NearbyProviderListItemView(providerData: providerBookingController.providerList![index], index: index, signInShakeKey: signInShakeKey,);
                },
              ),
            ),
          ]) :  providerBookingController.providerList != null && providerBookingController.providerList!.isEmpty ? const SizedBox() :
          HomeRecommendedProviderShimmer(height: height,);

        });
  }
}