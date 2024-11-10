import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class CountryPicker {
  static showPicker(
    BuildContext context, {
    required Function(Country) onSelected,
  }) {
    showCountryPicker(
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 70.percentHeight(context),
        padding: EdgeInsets.only(top: 25.pxV(context), left: 5, right: 5),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.pxV(context)),
          topLeft: Radius.circular(24.pxV(context)),
        ),
        backgroundColor: MyColors.primaryDarkBlue060A19,
        searchTextStyle: myTextStyle.font_16wRegular.copyWith(
          color: MyColors.white,
        ),
        inputDecoration: InputDecoration(
          hintText: lc(context).searchYourCountry,
          hintMaxLines: 1,
          hintStyle: 15.txt(context).w400.copyWith(
                color: MyColors.white788598,
              ),
          contentPadding: 12.paddingH(context).copyWith(top: 10.pxV(context)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          constraints: BoxConstraints.tight(
              Size(100.percentWidth(context), 56.pxV(context))),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.pxV(context)),
            borderSide: const BorderSide(
              width: 1,
              style: BorderStyle.solid,
              color: MyColors.secondaryBlue141F48,
            ),
            gapPadding: 0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.pxV(context)),
            borderSide: const BorderSide(
              width: 1,
              style: BorderStyle.solid,
              color: MyColors.secondaryBlue141F48,
            ),
            gapPadding: 0,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.pxV(context)),
            borderSide: const BorderSide(
              width: 1,
              style: BorderStyle.solid,
              // color: textContainerborderColor,
            ),
            gapPadding: 0,
          ),
          labelStyle: 16.txt(context).w400.copyWith(
                color: Colors.red,
              ),
        ),
        textStyle: myTextStyle.font_16wRegular.copyWith(
          color: MyColors.white,
        ),
      ),
      context: context,
      useSafeArea: true,
      onSelect: (Country myCountry) {
        primaryFocus!.unfocus();
        onSelected(myCountry);
      },
    );
  }
}
