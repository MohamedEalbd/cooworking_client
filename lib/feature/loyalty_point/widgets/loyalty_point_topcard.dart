import 'package:khidmh/utils/core_export.dart';
import 'package:get/get.dart';

class LoyaltyPointTopCard extends StatelessWidget {
  const LoyaltyPointTopCard({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoyaltyPointController>(builder: (loyaltyPointController){
      return Container(height: Dimensions.walletTopCardHeight,
        margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withValues(alpha: 0.9)],
          ),
        ),

        child: Stack(alignment: AlignmentDirectional.bottomEnd,children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Image.asset(Images.loyaltyPointBackground,height: Dimensions.walletTopCardHeight*0.6,),
          ),
          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(Images.myPoint,width:30),
                  const SizedBox(),
                  if(ResponsiveHelper.isDesktop(context))
                  InkWell(
                    onTap: (){
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        transitionDuration: const Duration(milliseconds: 500),
                        barrierLabel: MaterialLocalizations.of(context).dialogLabel,
                        barrierColor: Colors.black.withValues(alpha: 0.5),
                        pageBuilder: (context, _, __) {
                          return const LoyaltyPointUsesManualDialog();
                        },
                        transitionBuilder: (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOut,
                            ).drive(Tween<Offset>(
                              begin: const Offset(0, -1.0),
                              end: Offset.zero,
                            )),
                            child: child,
                          );
                        },
                      );
                    },
                    child: Image.asset(Images.info,width: 20,height: 20,color: Colors.white,),
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                    child: Text(loyaltyPointController.loyaltyPointModel?.content?.loyaltyPoint?.toStringAsFixed(2) ?? "0",style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge,color: Colors.white),)),
              ),
              Text('your_loyalty_point'.tr,style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Colors.white.withValues(alpha: 0.8))),
              const Row()

            ]),
          )
        ]),
      );
    });
  }
}
