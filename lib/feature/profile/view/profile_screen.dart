import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khidmh/feature/profile/model/profile_cart_item_model.dart';
import 'package:khidmh/utils/core_export.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<UserController>().getUserInfo(reload: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool pickedAddress =
        Get.find<LocationController>().getUserAddress() != null;

    final profileCartModelList = [
      ProfileCardItemModel(
        'personal_information'.tr,
        Images.profileIcon2,
        // Get.find<AuthController>().isLoggedIn()
        //     ?
        RouteHelper.getPersonalInformation()
          //  : RouteHelper.getNotLoggedScreen(RouteHelper.profile, "profile"),
      ), ProfileCardItemModel(
        'modify_mobile_number'.tr,
        Images.edit2,
        // Get.find<AuthController>().isLoggedIn()
        //     ?
        RouteHelper.getEditPhoneNumber()
            //: RouteHelper.getNotLoggedScreen(RouteHelper.profile, "profile"),
      ),ProfileCardItemModel(
        'payment_methods'.tr,
        Images.card,
        Get.find<AuthController>().isLoggedIn()
            ? RouteHelper.getEditPhoneNumber()
            : RouteHelper.getNotLoggedScreen(RouteHelper.profile, "profile"),
      ),ProfileCardItemModel(
        'my_reservations'.tr,
        Images.hogzat,
        Get.find<AuthController>().isLoggedIn()
            ? RouteHelper.getEditPhoneNumber()
            : RouteHelper.getNotLoggedScreen(RouteHelper.profile, "profile"),
      ),ProfileCardItemModel(
        'favourite'.tr,
        Images.heart,
        Get.find<AuthController>().isLoggedIn()
            ? RouteHelper.getEditPhoneNumber()
            : RouteHelper.getNotLoggedScreen(RouteHelper.profile, "profile"),
      ),
      //* address 1
      // ProfileCardItemModel(
      //   'my_address'.tr,
      //   Images.address,
      //   Get.find<AuthController>().isLoggedIn()
      //       ? RouteHelper.getAddressRoute('fromProfileScreen')
      //       : RouteHelper.getNotLoggedScreen(RouteHelper.profile, "profile"),
      // ),
      //* notifications 2
      ProfileCardItemModel(
        'notifications'.tr,
        Images.notification_icons,
        pickedAddress
            ? RouteHelper.getNotificationRoute()
            : RouteHelper.getPickMapRoute(
                RouteHelper.notification, true, 'false', null, null),
      ), ProfileCardItemModel(
        'contact_us'.tr,
        Images.message_text,
        pickedAddress
            ? RouteHelper.getNotificationRoute()
            : RouteHelper.getPickMapRoute(
                RouteHelper.notification, true, 'false', null, null),
      ),ProfileCardItemModel(
        'privacy_policy'.tr,
        Images.shield_tick,
        pickedAddress
            ? RouteHelper.getNotificationRoute()
            : RouteHelper.getPickMapRoute(
                RouteHelper.notification, true, 'false', null, null),
      ),
      //* sign in  3
      if (!Get.find<AuthController>().isLoggedIn())
        ProfileCardItemModel(
          'sign_in'.tr,
          Images.logout2,
          RouteHelper.getSignInRoute(fromPage: RouteHelper.profile),
        ),

      //* suggest new services 4
      if (Get.find<AuthController>().isLoggedIn())
        ProfileCardItemModel(
          'suggest_new_service'.tr,
          Images.suggestServiceIcon,
          pickedAddress
              ? RouteHelper.getNewSuggestedServiceScreen()
              : RouteHelper.getPickMapRoute(
                  RouteHelper.suggestService, true, 'false', null, null),
        ),
      //* delete account 5
      if (Get.find<AuthController>().isLoggedIn())
        ProfileCardItemModel(
          'delete_account'.tr,
          Images.accountDelete,
          'delete_account',
        ),
      //* logout 6
      if (Get.find<AuthController>().isLoggedIn())
        ProfileCardItemModel(
          'logout'.tr,
          Images.logoutIcons2,
          'sign_out',
        ),
    ];

    return CustomPopScopeWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        endDrawer:
            ResponsiveHelper.isDesktop(context) ? const MenuDrawer() : null,
         appBar: AppBar(
           titleSpacing: 0,
          // expandedHeight: 160,
           toolbarHeight: 160,
           flexibleSpace: PreferredSize(preferredSize:const Size(double.infinity, 350),
             child:
             Stack(
               alignment: Alignment.bottomCenter,
               clipBehavior: Clip.none,
               children: [
                 Container(
                   width: double.infinity,
                   decoration: BoxDecoration(
                       image: DecorationImage(fit: BoxFit.cover,image: AssetImage(Images.bgAppBar))
                   ),
                   child: Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16),
                     child:Column(
                       mainAxisAlignment: MainAxisAlignment.start,
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

                       ],
                     ),

                   ),

                 ),
                 GetBuilder<UserController>(
                   builder: (userController) {
                     return Positioned(
                       bottom:-20,
                       child: Container(
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           color: Colors.red,
                         ),
                         height: 50,width: 50,
                       ),
                       // ProfileHeader(
                       //   userInfoModel: userController.userInfoModel,
                       // ),
                     );
                   }
                 ),
               ],
             ),
           ),
         ),

        // CustomAppBar(
        //   title: 'profile'.tr,
        //   centerTitle: true,
        //   bgColor: Theme.of(context).primaryColor,
        //   isBackButtonExist: true,
        //   onBackPressed: (){
        //     if(Navigator.canPop(context)){
        //       Get.back();
        //     }else{
        //       Get.offAllNamed(RouteHelper.getMainRoute("home"));
        //     }
        //   },
        // ),

        body: GetBuilder<UserController>(
          builder: (userController) {
            return userController.userInfoModel == null &&
                    Get.find<AuthController>().isLoggedIn()
                ? const Center(child: CircularProgressIndicator())
                : FooterBaseView(
                    child: WebShadowWrap(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileHeader(
                            userInfoModel: userController.userInfoModel,
                          ),
                          const SizedBox(height: Dimensions.paddingSizeLarge),
                          ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              itemBuilder: (_, index) {
                                return ProfileCardItem(
                                  title: profileCartModelList[index].title,
                                  leadingIcon:
                                  profileCartModelList[index].loadingIcon,
                                  onTap: () {
                                    if (profileCartModelList[index].routeName ==
                                        'sign_out') {
                                      if (Get.find<AuthController>()
                                          .isLoggedIn()) {
                                        Get.dialog(
                                            ConfirmationDialog(
                                                icon: Images.logoutIcon,
                                                title:
                                                'are_you_sure_to_logout'.tr,
                                                description:
                                                "if_you_logged_out_your_cart_will_be_removed"
                                                    .tr,
                                                yesButtonColor:
                                                Theme.of(Get.context!)
                                                    .colorScheme
                                                    .primary,
                                                onYesPressed: () async {
                                                  Get.find<AuthController>()
                                                      .clearSharedData();
                                                  Get.find<AuthController>()
                                                      .googleLogout();
                                                  Get.find<AuthController>()
                                                      .signOutWithFacebook();
                                                  Get.find<AuthController>()
                                                      .signOutWithFacebook();
                                                  Get.offAllNamed(RouteHelper
                                                      .getInitialRoute());
                                                }),
                                            useSafeArea: false);
                                      } else {
                                        Get.toNamed(RouteHelper.getSignInRoute());
                                      }
                                    } else if (profileCartModelList[index]
                                        .routeName ==
                                        'delete_account') {
                                      Get.dialog(
                                          ConfirmationDialog(
                                              icon: Images.deleteProfile,
                                              title:
                                              'are_you_sure_to_delete_your_account'
                                                  .tr,
                                              description:
                                              'it_will_remove_your_all_information'
                                                  .tr,
                                              yesButtonText: 'delete',
                                              noButtonText: 'cancel',
                                              onYesPressed: () =>
                                                  userController.removeUser()),
                                          useSafeArea: false);
                                    } else {
                                      Get.toNamed(
                                          profileCartModelList[index].routeName);
                                    }
                                  },
                                );
                              },
                              separatorBuilder: (_, index) =>const SizedBox(height: 12,),
                             itemCount: profileCartModelList.length,
                          ),
                          // GridView.builder(
                          //   physics: const NeverScrollableScrollPhysics(),
                          //   shrinkWrap: true,
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: Dimensions.paddingSizeDefault),
                          //   gridDelegate:
                          //       SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount:
                          //         ResponsiveHelper.isMobile(context) ? 1 : 2,
                          //     childAspectRatio: 6,
                          //     crossAxisSpacing:
                          //         Dimensions.paddingSizeExtraLarge,
                          //     mainAxisSpacing: Dimensions.paddingSizeSmall,
                          //   ),
                          //   itemCount: profileCartModelList.length,
                          //   itemBuilder: (context, index) {
                          //     return ProfileCardItem(
                          //       title: profileCartModelList[index].title,
                          //       leadingIcon:
                          //           profileCartModelList[index].loadingIcon,
                          //       onTap: () {
                          //         if (profileCartModelList[index].routeName ==
                          //             'sign_out') {
                          //           if (Get.find<AuthController>()
                          //               .isLoggedIn()) {
                          //             Get.dialog(
                          //                 ConfirmationDialog(
                          //                     icon: Images.logoutIcon,
                          //                     title:
                          //                         'are_you_sure_to_logout'.tr,
                          //                     description:
                          //                         "if_you_logged_out_your_cart_will_be_removed"
                          //                             .tr,
                          //                     yesButtonColor:
                          //                         Theme.of(Get.context!)
                          //                             .colorScheme
                          //                             .primary,
                          //                     onYesPressed: () async {
                          //                       Get.find<AuthController>()
                          //                           .clearSharedData();
                          //                       Get.find<AuthController>()
                          //                           .googleLogout();
                          //                       Get.find<AuthController>()
                          //                           .signOutWithFacebook();
                          //                       Get.find<AuthController>()
                          //                           .signOutWithFacebook();
                          //                       Get.offAllNamed(RouteHelper
                          //                           .getInitialRoute());
                          //                     }),
                          //                 useSafeArea: false);
                          //           } else {
                          //             Get.toNamed(RouteHelper.getSignInRoute());
                          //           }
                          //         } else if (profileCartModelList[index]
                          //                 .routeName ==
                          //             'delete_account') {
                          //           Get.dialog(
                          //               ConfirmationDialog(
                          //                   icon: Images.deleteProfile,
                          //                   title:
                          //                       'are_you_sure_to_delete_your_account'
                          //                           .tr,
                          //                   description:
                          //                       'it_will_remove_your_all_information'
                          //                           .tr,
                          //                   yesButtonText: 'delete',
                          //                   noButtonText: 'cancel',
                          //                   onYesPressed: () =>
                          //                       userController.removeUser()),
                          //               useSafeArea: false);
                          //         } else {
                          //           Get.toNamed(
                          //               profileCartModelList[index].routeName);
                          //         }
                          //       },
                          //     );
                          //   },
                          // ),
                          const SizedBox(
                            height: Dimensions.paddingSizeDefault,
                          )
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
