import 'package:khidmh/utils/core_export.dart';

class UnselectedProductWidget extends StatelessWidget {
  const UnselectedProductWidget({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  ResponsiveHelper.isDesktop(context)? 50 : 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),width: 0.7),
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Center(child: Hero(tag: 'provide_image',
        child: ClipRRect( borderRadius: BorderRadius.circular(Dimensions.radiusExtraMoreLarge),
          child: Image.asset(Images.providerImage,height: 30,width: 30,),
        ),
      )),
    );
  }
}
