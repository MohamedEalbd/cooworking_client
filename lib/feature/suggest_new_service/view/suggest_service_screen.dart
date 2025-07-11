import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

class SuggestServiceScreen extends StatefulWidget {
  const SuggestServiceScreen({super.key}) ;

  @override
  State<SuggestServiceScreen> createState() => _SuggestServiceScreenState();
}

class _SuggestServiceScreenState extends State<SuggestServiceScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<CategoryController>().getCategoryList(false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(title: "service_request".tr, actionWidget: IconButton(
        onPressed: (){
          Get.to(()=> const SuggestedServiceListScreen());
        },
        icon: const Icon(Icons.list),
      )),
      body: GetBuilder<SuggestServiceController>(builder: (suggestServiceController){
        return FooterBaseView(
          child: Center(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: SizedBox(height: Get.height,
                  child: Stack(alignment: Alignment.bottomCenter,
                    children: [
                      if(ResponsiveHelper.isDesktop(context))
                      Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Align(
                          alignment: Get.find<LocalizationController>().isLtr? Alignment.topRight: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () => Get.toNamed(RouteHelper.getNewSuggestedServiceList()),
                            child: Container(
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context).colorScheme.primary
                              ),
                              padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault,vertical:Dimensions.paddingSizeSmall-2),
                              child: Text('see_request'.tr, style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault, color: Colors.white
                              )),
                            ),
                          ),
                        ),
                      ),
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Text('tell_us_more_about_your_service'.tr,
                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.9),
                              )
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeSmall),
                          child: Text('suggest_more_service_that_you_willing'.tr,
                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.7),
                            ), textAlign: TextAlign.center,
                          ),
                        ),

                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge,),
                            child: Image.asset(Images.suggestServiceIcon,width: suggestServiceController.initialImageSize,),
                          ),
                        ),

                        AnimatedOpacity(opacity: suggestServiceController.initialContainerOpacity,
                          duration: const Duration(milliseconds: 1500),
                          child: const SuggestServiceInputField(),
                        )
                      ]),

                      AnimatedPositioned(
                        top: suggestServiceController.initialButtonPadding,
                        duration: const Duration(milliseconds: 500),
                        child: suggestServiceController.isLoading==false?
                        CustomButton(width: 240, fontSize: Dimensions.fontSizeDefault,
                          buttonText: suggestServiceController.isShowInputField?"send_request".tr:'request_for_service'.tr,
                          onPressed: (){
                            if(!suggestServiceController.isShowInputField){
                              suggestServiceController.updateShowInputField();
                            }else{
                              if(suggestServiceController.selectedCategoryName==""){
                                customSnackBar('select_category'.tr,  type: ToasterMessageType.info);
                              }else if(suggestServiceController.serviceNameController.text==""){
                                customSnackBar('provide_your_desired_service_name'.tr,  type: ToasterMessageType.info);
                              }else if(suggestServiceController.serviceDetailsController.text.isEmpty){
                                customSnackBar("provide_some_details_about_your_service".tr,  type: ToasterMessageType.info);
                              }else{
                                suggestServiceController.submitNewServiceRequest();
                              }
                            }
                          },
                        ): const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
