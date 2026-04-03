import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MobilePhoneField extends StatelessWidget {
  const MobilePhoneField({
    super.key,
    this.phoneController,
    this.countryController,
  });

  final TextEditingController? countryController;
  final TextEditingController? phoneController;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      buildCounter:
          (
            context, {
            required currentLength,
            required isFocused,
            required maxLength,
          }) => null,
      flagsButtonPadding: EdgeInsets.only(left: 14.sp),
      dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      dropdownIconPosition: IconPosition.trailing,
      dropdownDecoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey)),
      ),
      controller: phoneController,
      decoration: InputDecoration(
        prefix: 10.horizontalSpace,
        hintText: '000 000 0000',
        filled: true,
        fillColor: const Color(0xffFAFAFB),
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color(0xff80e1e05).withValues(alpha: 0.05),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color(0xff80e1e05).withValues(alpha: 0.05),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color(0xff80e1e05).withValues(alpha: 0.04),
          ),
        ),
      ),
      onChanged: (phone) {
        countryController?.text = phone.countryCode;
        phoneController?.text = phone.number;
      },
      onCountryChanged: (country) {
        countryController?.text = "+${country.dialCode}";
      },
      validator: (value) {
        if (value == null || value.number.isEmpty) {
          return 'Phone number is required';
        }
        return null;
      },
    );
  }
}
