import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_text_field.dart';
import '../../../helper/phone_verification_helper.dart';

class EditNumberScreen extends StatefulWidget {
  const EditNumberScreen({super.key});

  @override
  State<EditNumberScreen> createState() => _EditNumberScreenState();
}

class _EditNumberScreenState extends State<EditNumberScreen> {
  var signInPhoneController = TextEditingController();
  var signInPasswordController = TextEditingController();

  final _passwordFocus = FocusNode();
  final _phoneFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("modify_mobile_number".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "new_number".tr,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff181F1F),
                height: (14 / 24),),
            ),
            const SizedBox(
                height: 8
            ),
            CustomTextField(
              // onCountryChanged: (countryCode) => authController.countryDialCode = countryCode.dialCode!,
              // countryDialCode: authController.isNumberLogin || (manualLogin == 0 && otpLogin ==1) ? authController.countryDialCode : null,
              title: 'email_phone'.tr,
              hintText:// authController.selectedLoginMedium == LoginMedium.otp || (manualLogin == 0 && otpLogin ==1)
                 // ?
              "please_enter_phone_number".tr ,//: 'enter_email_or_phone'.tr,
              controller: signInPhoneController,
              focusNode: _phoneFocus,
              nextFocus: _passwordFocus,
              isShowBorder: true,
              capitalization: TextCapitalization.words,
              onChanged: (String text){
                // if(authController.selectedLoginMedium != LoginMedium.otp){
                //
                //
                //   final numberRegExp = RegExp(r'^[+]?[0-9]+$');
                //
                //   if(text.isEmpty && authController.isNumberLogin){
                //     authController.toggleIsNumberLogin();
                //
                //   }
                //   if(text.startsWith(numberRegExp) && !authController.isNumberLogin && manualLogin == 1){
                //     authController.toggleIsNumberLogin();
                //     final cursorPosition = signInPhoneController.selection.baseOffset;
                //     signInPhoneController.text = text.replaceAll("+", "");
                //     signInPhoneController.selection = TextSelection.fromPosition(TextPosition(offset: cursorPosition));
                //   }
                //   final emailRegExp = RegExp(r'@');
                //   if(text.contains(emailRegExp) && authController.isNumberLogin && manualLogin == 1){
                //     authController.toggleIsNumberLogin();
                //   }
                //
                //   _phoneFocus.requestFocus();
                // }
              },
              onValidate: (String? value){
                // if(otpLogin == 1 && manualLogin == 0 && PhoneVerificationHelper.getValidPhoneNumber(authController.countryDialCode+signInPhoneController.text.trim(), withCountryCode: true) == ""){
                //   return "enter_valid_phone_number".tr;
                // }
                // if(authController.isNumberLogin && PhoneVerificationHelper.getValidPhoneNumber(authController.countryDialCode+signInPhoneController.text.trim(), withCountryCode: true) == ""){
                //   return "enter_valid_phone_number".tr;
                // }
                // return (PhoneVerificationHelper.getValidPhoneNumber(authController.countryDialCode+signInPhoneController.text.trim(), withCountryCode: true) != "" || GetUtils.isEmail( value ?? "")) ? null : 'enter_email_or_phone'.tr;
              },
            ),
          ],
        ),
      ),
    );
  }
}
