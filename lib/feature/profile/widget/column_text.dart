import 'package:get/get.dart';
import 'package:khidmh/utils/core_export.dart';

class ColumnText extends StatelessWidget {
  final String accountAgo;
  final bool isProfileTimeAgo;
  final num amount;
  final String title;
   const ColumnText({super.key,required this.title,required this.amount,  this.accountAgo ='',  this.isProfileTimeAgo = false}) ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveHelper.isDesktop(context) ? Dimensions.webMaxWidth * .40 : Get.width * .40,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isProfileTimeAgo? accountAgo.
              replaceAll('days ago', 'days_ago'.tr).
              replaceAll('a day ago', 'a_day_ago'.tr).
              replaceAll('a moment ago', 'a_moment_ago'.tr).
              replaceAll('a minute ago', 'a_minute_ago'.tr).
              replaceAll('a moment ago', 'a_moment_ago'.tr).
              replaceAll('minutes ago', 'minutes_ago'.tr).
              replaceAll('about a month ago', 'about_a_month_ago'.tr).
              replaceAll('about an hour ago', 'about_an_hour_ago'.tr).
              replaceAll('months ago', 'months_ago'.tr).
              replaceAll('hours ago', 'hours_ago'.tr).
              replaceAll('about a year ago', 'about_a_year_ago'.tr)
                  : amount.toString(),
              style: robotoBold.copyWith(fontSize: 16,
                  color:  Theme.of(context).colorScheme.primary,
              ),
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: robotoMedium.copyWith(
                fontSize: 12,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
