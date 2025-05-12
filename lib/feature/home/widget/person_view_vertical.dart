import 'package:khidmh/feature/home/widget/person_card.dart';
import 'package:khidmh/feature/provider/view/nearby_provider/widget/nearby_provider_list_item_view.dart';
import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

class PersonViewVertical extends StatelessWidget {
  final double height;
  final GlobalKey<CustomShakingWidgetState>?  signInShakeKey;
  const PersonViewVertical({super.key, required this.height, this.signInShakeKey}) ;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearbyProviderController>(
        builder: (providerBookingController){
          return providerBookingController.providerList != null && providerBookingController.providerList!.isNotEmpty
              ?
          Column(children: [
            const SizedBox(height: Dimensions.paddingSizeDefault),

            Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 15, Dimensions.paddingSizeDefault,  Dimensions.paddingSizeSmall,),
              child: TitleWidget(
                textDecoration: TextDecoration.underline,
                title:'bestRated'.tr,
               // onTap: () => Get.toNamed(RouteHelper.getNearByProviderScreen(tabIndex: 0)),
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
              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 15, Dimensions.paddingSizeDefault,  Dimensions.paddingSizeSmall,),
              child: GridView.builder(
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: Dimensions.paddingSizeLarge,
                    //mainAxisSpacing:  Dimensions.paddingSizeDefault,
                    mainAxisExtent: ResponsiveHelper.isDesktop(context) ?  270 : 240 ,
                    // childAspectRatio: 3/2,
                    crossAxisCount: ResponsiveHelper.isDesktop(context) ? 5 : ResponsiveHelper.isTab(context) ? 3 : 2 ),
                shrinkWrap: true, // يخليه ياخد ارتفاع العناصر فقط
                physics: const NeverScrollableScrollPhysics(),
                itemCount: providerBookingController.providerIndependentList!.length > 2 ? 2 : providerBookingController.providerIndependentList?.length,
                itemBuilder: (context, index){
                  return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
                    child: SizedBox(
                      width: ResponsiveHelper.isDesktop(context) ? Dimensions.webMaxWidth / 3.2 : ResponsiveHelper.isTab(context)? Get.width/ 2.5 :  Get.width/1.16,
                      child: PersonCard(providerData: providerBookingController.providerIndependentList![index],),
                      // child: NearbyProviderListItemView(providerData: providerBookingController.providerList![index], index: index, signInShakeKey: signInShakeKey,),
                    ),
                  );
                },
              ),
            ),
          ]) :  providerBookingController.providerIndependentList != null && providerBookingController.providerIndependentList!.isEmpty ? const SizedBox() :
          HomeRecommendedProviderShimmer(height: height,);

        });
  }
}