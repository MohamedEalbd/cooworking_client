import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';


class ProviderOfferListScreen extends StatefulWidget {
  final String? postId;
  final MyPostData? myPostData;
  final String? status;
  const ProviderOfferListScreen({super.key, this.postId, this.myPostData,  this.status}) ;

  @override
  State<ProviderOfferListScreen> createState() => _ProviderOfferListScreenState();
}

class _ProviderOfferListScreenState extends State<ProviderOfferListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CreatePostController>().getProvidersOfferList(1,widget.postId??"",reload: true);
  }
  @override
  Widget build(BuildContext context) {

    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar:  CustomAppBar(title: 'provider_offers'.tr),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body: GetBuilder<CreatePostController>(
        builder: (createPostController){
        return widget.postId == null || widget.myPostData == null ?  NoDataScreen(text: "no_data_found".tr, type: NoDataType.bookings,) : ExpandableBottomSheet(
          background: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox( width: Dimensions.webMaxWidth,
                  child: ConstrainedBox(constraints: BoxConstraints(
                    minHeight: Get.height*0.6),
                    child:createPostController.providerOfferModel!=null && createPostController.providerOfferModel!.content!=null && createPostController.listOfProviderOffer != null && createPostController.listOfProviderOffer!.isNotEmpty?
                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
                      child: PaginatedListView(
                        scrollController: scrollController,
                        totalSize: createPostController.providerOfferModel!.content!.total!,
                        onPaginate: (int offset) async => await createPostController.getProvidersOfferList(
                          offset, widget.postId??"" ,reload: false,
                        ),
                        offset: createPostController.providerOfferModel!.content!.currentPage,
                        itemView: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: ResponsiveHelper.isDesktop(context)?2:1,
                            mainAxisExtent: Get.find<LocalizationController>().isLtr? 165: 175,
                            crossAxisSpacing: Dimensions.paddingSizeDefault),
                          itemCount: createPostController.listOfProviderOffer?.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isDesktop(context)?0:Dimensions.paddingSizeDefault),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index){
                            return AcceptProviderRequestView(
                              providerOfferData: createPostController.listOfProviderOffer![index],
                              postId: widget.postId!,
                              length: createPostController.listOfProviderOffer?.length ?? 0,
                            );
                          },),
                      ),
                    ): createPostController.providerOfferModel==null ?
                    const Center(child: CircularProgressIndicator()):
                    Center(
                      child: Text('no_provider_bid_this_post'.tr,style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge
                      ),),
                    ) ,
                  ),
                ),

                if(ResponsiveHelper.isDesktop(context))
                PostDetailsExpandableContent(postData: widget.myPostData!,),
                if(ResponsiveHelper.isDesktop(context))
                const FooterView()
              ],
            ),
          ),
          persistentContentHeight: 400,
          expandableContent: ResponsiveHelper.isDesktop(context)
              ? const SizedBox()
              :PostDetailsExpandableContent(postData: widget.myPostData!,),
        );
      }),
    );
  }
}
