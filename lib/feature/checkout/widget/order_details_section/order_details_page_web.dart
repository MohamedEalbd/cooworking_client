import 'package:khidmh/feature/checkout/widget/choose_booking_type_widget.dart';
import 'package:khidmh/feature/checkout/widget/order_details_section/create_account_widget.dart';
import 'package:khidmh/feature/checkout/widget/order_details_section/repeat_booking_schedule_widget.dart';
import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

class OrderDetailsPageWeb extends StatelessWidget {
  final String pageState;
  final String addressId;
  const OrderDetailsPageWeb({super.key, required this.pageState, required this.addressId}) ;

  @override
  Widget build(BuildContext context) {




    return Center( child: SizedBox(width: Dimensions.webMaxWidth * 0.9,
      child: GetBuilder<ScheduleController>(builder: (scheduleController){
        return GetBuilder<LocationController>(builder: (locationController){
          return GetBuilder<SplashController>(builder: (splashController){
            return GetBuilder<CartController>(builder: (cartController){

              bool isLoggedIn  = Get.find<AuthController>().isLoggedIn();
              bool createGuestAccount = splashController.configModel.content?.createGuestUserAccount == 1;
              AddressModel? addressModel = CheckoutHelper.selectedAddressModel(selectedAddress: locationController.selectedAddress, pickedAddress: locationController.getUserAddress());
              bool contactPersonInfoAvailable = addressModel !=null && addressModel.contactPersonNumber !=null && addressModel.contactPersonNumber != "";

              return Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [

                Expanded(child: WebShadowWrap( backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.03),minHeight: Get.height * 0.1, child: Column( mainAxisSize: MainAxisSize.min, children: [
                  isLoggedIn && splashController.configModel.content?.repeatBooking == 1 ? const ChooseBookingTypeWidget() : const SizedBox(),
                  const SizedBox(height: Dimensions.paddingSizeSmall,),

                  (scheduleController.selectedServiceType == ServiceType.regular || !isLoggedIn) ?
                  const ServiceSchedule() : const RepeatBookingScheduleWidget(),

                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  const AddressInformation(),

                  if(!isLoggedIn && createGuestAccount &&  contactPersonInfoAvailable) const CreateAccountWidget(),

                  if(!isLoggedIn && createGuestAccount && contactPersonInfoAvailable) const SizedBox(height: Dimensions.paddingSizeDefault,),

                  ( cartController.cartList.isNotEmpty && cartController.cartList.first.provider !=null) ?  ProviderDetailsCard(
                    providerData: cartController.cartList.first.provider,
                  ) : const SizedBox(),

                  const SizedBox(height: Dimensions.paddingSizeDefault,),

                  Get.find<AuthController>().isLoggedIn() ? const ShowVoucher() : const SizedBox(),

                ]))),

                const SizedBox(width: 20,),
                Expanded(
                  child: WebShadowWrap(
                    backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.03),
                    minHeight: Get.height * 0.1  ,
                    child: Column(
                      children: [
                        const CartSummery(),
                        const SizedBox(height: Dimensions.paddingSizeEight,),
                        ProceedToCheckoutButtonWidget(pageState: pageState,addressId: addressId,)
                      ],
                    ),
                  ),
                ),

              ]);
            });
          });
        });
      }),
    ));
  }
}


