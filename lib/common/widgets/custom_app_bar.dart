import 'package:get/get.dart';
import 'package:khidmh/utils/core_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subTitle;
  final bool? isBackButtonExist;
  final Function()? onBackPressed;
  final bool? showCart;
  final bool? centerTitle;
  final Color? bgColor;
  final Widget? actionWidget;
  final GlobalKey<CustomShakingWidgetState>?  shakeKey;
  final bool isBackgroundTransparent;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackButtonExist = true,
    this.onBackPressed,
    this.showCart = false,
    this.centerTitle = true,
    this.bgColor,
    this.actionWidget,
    this.subTitle,
    this.shakeKey,
    this.isBackgroundTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ?  WebMenuBar(searchbarShakeKey: shakeKey ) :
    AppBar(
      backgroundColor: isBackgroundTransparent ? Colors.transparent : Get.isDarkMode ? Theme.of(context).cardColor.withOpacity(.2) : Colors.white,
      centerTitle: centerTitle,
      shape: Border(bottom: BorderSide(width: .4, color: Theme.of(context).primaryColorLight.withOpacity(.2))), elevation: 0,
      titleSpacing: 0,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title!, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color:
          Get.isDarkMode ?Colors.white:Colors.black),),
          if(subTitle!=null) Text(subTitle!,style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color:  Theme.of(context).primaryColorLight),),

        ],
      ),

      leading: isBackButtonExist! ? IconButton(
        hoverColor:Colors.transparent,
        icon: Icon(Icons.arrow_back_ios, color:  Get.isDarkMode ?  Colors.white:Colors.black),
        color: Theme.of(context).textTheme.bodyLarge!.color,
        onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.of(context).canPop() ? Navigator.pop(context) : Get.offAllNamed(RouteHelper.getInitialRoute()),
      ) : const SizedBox(),

      actions: showCart! ? [
        IconButton(
          onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
          icon:  CartWidget(color: Get.isDarkMode ? Theme.of(context).primaryColorLight : Colors.black, size: Dimensions.cartWidgetSize),
        )] : actionWidget != null ? [actionWidget!] : null,
    );
  }
  @override
  Size get preferredSize => Size(Dimensions.webMaxWidth, ResponsiveHelper.isDesktop(Get.context) ? Dimensions.preferredSizeWhenDesktop : Dimensions.preferredSize );
}