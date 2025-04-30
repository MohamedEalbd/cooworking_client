import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:khidmh/common/widgets/new_build_custom_app_bar.dart';
import 'package:khidmh/feature/home/widget/nearby_provider_listview.dart';

import '../../helper/responsive_helper.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../language/controller/localization_controller.dart';
import '../provider/controller/nearby_provider_controller.dart';
import '../provider/controller/provider_booking_controller.dart';
import '../provider/view/nearby_provider/widget/nearby_provider_list_item_view.dart';

class AllCompanyScreen extends StatefulWidget {
  const AllCompanyScreen({super.key,required this.txt});
  final String txt;
  @override
  State<AllCompanyScreen> createState() => _AllCompanyScreenState();
}

class _AllCompanyScreenState extends State<AllCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ProviderBookingController>(
          builder: (providerController) {
            bool isAvailableProvider = providerController.providerList != null && providerController.providerList!.isNotEmpty;
            bool isLtr = Get.find<LocalizationController>().isLtr;
            return Column(
              children: [
                NewBuildCustomAppBar(txt: widget.txt),

                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: FiltersRow(),
                ),
                const SizedBox(height: 16,),
                Expanded(
                    child:((isAvailableProvider || providerController.providerList == null)) ?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: GetBuilder<NearbyProviderController>(
                        builder: (providerBookingController) {
                          return GridView.builder(
                            key: UniqueKey(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: Dimensions.paddingSizeDefault,
                                //mainAxisSpacing:  Dimensions.paddingSizeDefault,
                                mainAxisExtent: ResponsiveHelper.isDesktop(context) ?  270 : 260 ,
                                // childAspectRatio: 3/2,
                                crossAxisCount: ResponsiveHelper.isDesktop(context) ? 5 : ResponsiveHelper.isTab(context) ? 3 : 2 ),
                            shrinkWrap: true, // يخليه ياخد ارتفاع العناصر فقط
                            physics: const ClampingScrollPhysics(),
                            itemCount: providerBookingController.providerList?.length,
                            itemBuilder: (context, index){
                              return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
                                child: SizedBox(
                                  width: ResponsiveHelper.isDesktop(context) ? Dimensions.webMaxWidth / 3.2 : ResponsiveHelper.isTab(context)? Get.width/ 2.5 :  Get.width/1.16,
                                  child: NearbyProviderListItemView(providerData: providerBookingController.providerList![index], index: index,),
                                  // child: NearbyProviderListItemView(providerData: providerBookingController.providerList![index], index: index, signInShakeKey: signInShakeKey,),
                                ),
                              );
                            },
                          );
                        }
                      ),
                    ): const SizedBox(),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}

class FiltersRow extends StatefulWidget {
  @override
  State<FiltersRow> createState() => _FiltersRowState();
}

class _FiltersRowState extends State<FiltersRow> {
  String selectedOption = 'الأفضل تقييما';
  List<String> options = [
    'الأفضل تقييما',
    'الأقل سعرا',
    'الأقرب',
  ];

  final GlobalKey _key = GlobalKey(); // مفتاح لتحديد مكان الزر

  void _showPopupMenu() async {
    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    String? selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width,
        offset.dy,
      ),
      items: options.map((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    );

    if (selected != null) {
      setState(() {
        selectedOption = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // الزر الثاني (الأفضل تقييما)
        GestureDetector(
          onTap: _showPopupMenu,
          child: Container(
            key: _key,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedOption,
                  style: const TextStyle(
                    color: Color(0xff0D4D63),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                SvgPicture.asset(Images.arrow_down)
              ],
            ),
          ),
        ),
        // الزر الأول (حسب التوفر)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child:  Row(
            children: [
              const SizedBox(width: 8),
              SvgPicture.asset(Images.filterIcon,width: 17,height: 15,),
              const SizedBox(width: 8),
              const Text(
                'حسب التوفر',
                style: TextStyle(
                  color: Color(0xff0D4D63),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              const CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xff1B7B9C),
                child: Text(
                  '1',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),




              // Icon(
              //   Icons.tune, // يمكن تغييره لأيقونة مشابهة للأصل
              //   size: 18,
              //   color: Colors.teal,
              // ),
            ],
          ),
        ),

      ],
    );
  }
}
