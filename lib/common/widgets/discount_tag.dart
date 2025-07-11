import 'package:khidmh/helper/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:khidmh/utils/dimensions.dart';
import 'package:khidmh/utils/styles.dart';

class DiscountTag extends StatelessWidget {
  final num? discount;
  final String? discountType;
  final double? fromTop;
  final double? fontSize;
  final bool? freeDelivery;
  final Color? color;
  const DiscountTag({super.key, required this.discount, required this.discountType, this.fromTop = 5, this.fontSize, this.freeDelivery = false, this.color});

  @override
  Widget build(BuildContext context) {
    return (discount! > 0 || freeDelivery!) ? Positioned(
      top: fromTop, right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          color: color?? Theme.of(context).colorScheme.error.withValues(alpha: 0.9),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(Dimensions.radiusSmall),
              bottomLeft: Radius.circular(Dimensions.radiusSmall),
          ),
        ),
        child: Text(
          PriceConverter.percentageOrAmount('$discount','$discountType'),
          style: robotoRegular.copyWith(color: Colors.white),
        ),
      ),
    ) : const SizedBox();
  }
}
