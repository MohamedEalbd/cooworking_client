import 'package:get/get.dart';
import 'package:khidmh/utils/core_export.dart';


class ProfileCardItem extends StatelessWidget {
  final String leadingIcon;
  final bool? isDarkItem;
  final String title;
  final IconData? trailingIcon;
  final Function()? onTap;
  const ProfileCardItem({super.key,this.trailingIcon=Icons.arrow_forward_ios,required this.title,required this.leadingIcon,this.onTap,this.isDarkItem=false}) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 12,right: 12,top: 16),
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          color: Theme.of(context).hoverColor,
          boxShadow: Get.find<ThemeController>().darkTheme ? null : cardShadow,
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(leadingIcon,width: Dimensions.profileImageSize,),
            const SizedBox(width: Dimensions.paddingSizeDefault,),
            Text(title,style:const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff38494A)),),
          ],
        ),
        //ListTile(
         // title:
          // trailing: isDarkItem==false?Icon(trailingIcon,size: Dimensions.fontSizeDefault,color: Theme.of(context).colorScheme.primary,):
          // GetBuilder<ThemeController>(builder: (themeController){
          //   return Switch(value: themeController.darkTheme, onChanged: (value){
          //     themeController.toggleTheme();
          //   });
          // }),
        //  onTap: onTap,
       // ),
      ),
    );
  }
}
