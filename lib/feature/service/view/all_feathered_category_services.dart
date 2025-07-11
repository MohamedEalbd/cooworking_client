import 'package:get/get.dart';
import 'package:khidmh/utils/core_export.dart';

class AllFeatheredCategoryServiceView extends StatefulWidget {
  final String? fromPage;
  final String? categoryId;
  const AllFeatheredCategoryServiceView({super.key, this.fromPage, this.categoryId});

  @override
  State<AllFeatheredCategoryServiceView> createState() => _AllFeatheredCategoryServiceViewState();
}

class _AllFeatheredCategoryServiceViewState extends State<AllFeatheredCategoryServiceView> {

  List<Service>? serviceList;
  @override
  void initState() {
    super.initState();
    Get.find<ServiceController>().getFeatherCategoryList(false);
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: CustomAppBar(
        title:widget.fromPage ,showCart: true,),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body:  FooterBaseView(
        child: GetBuilder<ServiceController>(builder: (serviceController){

          serviceController.categoryList?.forEach((element) {
            if(element.id == widget.categoryId){
              serviceList = element.servicesByCategory;
            }
          });

          return serviceController.categoryList != null &&  serviceController.categoryList!.isNotEmpty ?  SizedBox(
            width: Dimensions.webMaxWidth,
            child: (serviceList != null && serviceList!.isEmpty) || widget.categoryId == null ?  NoDataScreen(text: 'no_services_found'.tr,type: NoDataType.service,) :  serviceList != null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
              child: CustomScrollView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                slivers: [

                  if(ResponsiveHelper.isDesktop(context))
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          Dimensions.paddingSizeDefault,
                          Dimensions.fontSizeDefault,
                          Dimensions.paddingSizeDefault,
                          Dimensions.paddingSizeSmall,
                        ),
                        child: TitleWidget(
                          title: widget.fromPage,
                        ),
                      ),
                    ),

                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: Dimensions.paddingSizeDefault,
                      mainAxisSpacing:  Dimensions.paddingSizeDefault,
                      childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? .9 : .75,
                      crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
                      mainAxisExtent: 240,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return ServiceWidgetVertical(service: serviceList![index], fromType: widget.fromPage ?? "",);
                      },
                      childCount: serviceList!.length,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: Dimensions.webCategorySize,)),
                ],
              ),
            ) : GridView.builder(
              key: UniqueKey(),
              padding: const EdgeInsets.only(
                top: Dimensions.paddingSizeDefault,
                bottom: Dimensions.paddingSizeDefault,
                left: Dimensions.paddingSizeDefault,
                right: Dimensions.paddingSizeDefault,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: Dimensions.paddingSizeDefault,
                mainAxisSpacing:  Dimensions.paddingSizeDefault,
                childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? 1 : .70,
                crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ServiceShimmer(isEnabled: true, hasDivider: false);
              },
            ),
          ) : const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }




}

