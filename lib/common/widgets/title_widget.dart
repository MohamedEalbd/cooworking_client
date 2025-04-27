import 'package:get/get.dart';
import 'package:khidmh/utils/core_export.dart';

class TitleWidget extends StatelessWidget {
  final String? title;
  final TextDecoration? textDecoration;
  final Function()? onTap;
  const TitleWidget(
      {super.key, required this.title, this.onTap, this.textDecoration});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        child: Text(
          title!.tr,
          style: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge,
            color: title == 'recently_view_services'
                ? Colors.white
                : const Color(0xff018995),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const SizedBox(
        width: Dimensions.paddingSizeSmall,
      ),
      (onTap != null)
          ? InkWell(
              onTap: onTap,
              child: Text(
                'see_all'.tr,
                style: robotoRegular.copyWith(
                  //decoration: textDecoration,
                  color: Get.isDarkMode
                      ? const Color(0xff6C757D)
                      : title == 'recently_view_services'
                          ? Colors.white
                          : const Color(0xff6C757D),
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ),
            )
          : const SizedBox(),
    ]);
  }
}
