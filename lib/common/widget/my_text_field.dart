import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

class MyTextFormField extends StatefulWidget {
  final String hintText;
  final Color? titleColor,
      backgroundColor,
      enabledColor,
      hintColor,
      borderColor,
      filledColor;
  final TextEditingController? controller;
  final String prefixIconPath;
  final Widget? suffixIcon;
  final VoidCallback? titleBtnOnTap;
  final int? maxLength;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final Function()? onTap;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? textInputFormater;
  final bool? focusColorEnable, obscure;
  final bool? showTitle, isShowTitleBtn;
  final bool readOnly;
  final double focusedBorderWidth, textFieldHeight;
  final double? bottomSpace;
  final EdgeInsets margin;
  final TextStyle? inputTextStyle;
  final int? maxLines;

  const MyTextFormField({
    Key? key,
    this.titleColor,
    this.backgroundColor,
    this.controller,
    this.hintText = '',
    required this.prefixIconPath,
    this.maxLength,
    this.keyboardType,
    this.filledColor,
    this.borderColor,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.textCapitalization,
    this.textInputFormater,
    this.suffixIcon,
    this.focusColorEnable = false,
    this.obscure = false,
    this.readOnly = false,
    this.showTitle = true,
    this.enabledColor,
    this.hintColor,
    this.focusedBorderWidth = 1.0,
    this.titleBtnOnTap,
    this.isShowTitleBtn,
    this.margin = EdgeInsets.zero,
    this.textFieldHeight = 48,
    this.bottomSpace,
    this.maxLines = 1,
    // this.textStyleCustom,
    this.inputTextStyle,
    this.onTap,
  }) : super(key: key);

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  final FocusNode _focusNode = FocusNode();
  // bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      // setState(() {
      //   _isFocused = _focusNode.hasFocus;
      // });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin.copyWith(bottom: widget.bottomSpace?.pxV(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Focus(
            onFocusChange: (hasFocus) {
              // if (widget.readOnly != null && !widget.readOnly!) {
              // setState(() {
              //   _isFocused = hasFocus;
              // });
              // }
            },
            child: TextFormField(
              maxLines: widget.maxLines,
              readOnly: widget.readOnly,
              obscureText: widget.obscure!,
              onFieldSubmitted: (val) {
                if (widget.onFieldSubmitted == null) {
                  FocusScope.of(context).nextFocus();
                } else {
                  widget.onFieldSubmitted!(val);
                }
              },
              onTap: widget.onTap,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: widget.textInputAction,
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              // maxLength: widget.maxLength,
              controller: widget.controller,
              style: widget.inputTextStyle ??
                  myTextStyle.font_16wRegular.copyWith(
                    color: MyColors.white,
                  ),
              focusNode: _focusNode,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? MyColors.transparent,
                  ),
                ),
                counterText: '',
                // prefixIcon: widget.prefixIcon,
                prefixIcon: widget.prefixIconPath.isNotEmpty
                    ? Container(
                        // width: 24,
                        padding: EdgeInsets.fromLTRB(isEng ? 20 : 0, 8, 0, 10),
                        child: SvgPicture.asset(
                          widget.prefixIconPath,
                          // color: _isFocused
                          //     ? Colors.white
                          //     : MyColors.lightblue6B79AD,
                          color: MyColors.lightblue6B79AD,
                          fit: BoxFit.none,
                          width: 24,
                        ),
                      )
                    : null,
                suffixIcon: widget.suffixIcon,
                filled: true,
                errorStyle:
                    myTextStyle.font_13w300Black.copyWith(color: MyColors.red),
                fillColor: widget.filledColor ?? MyColors.secondaryBlue141F48,
                hintText: widget.hintText,
                hintStyle: myTextStyle.font_14w500.copyWith(
                  color: const Color.fromRGBO(107, 121, 173, 1),
                  // color: _isFocused && !widget.readOnly
                  //     ? Colors.white
                  //     : widget.hintColor ??
                  //         const Color.fromRGBO(107, 121, 173, 1),
                ),
                prefix: Padding(
                  padding: EdgeInsets.only(
                      left: widget.prefixIconPath.isNotEmpty ? 15 : 0),
                ),
                contentPadding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.focusColorEnable!
                        ? MyColors.black0D0D0D
                        // MyThemeColor.textFieldBorderColor(
                        //     context,
                        //     lightColor: MyColors.black,
                        //     darkColor: MyColors.white,
                        //   )
                        : MyColors.transparent,
                    width: widget.focusedBorderWidth,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: widget.validator,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              inputFormatters: widget.textInputFormater ??
                  [FilteringTextInputFormatter.singleLineFormatter],
            ),
          ),
        ],
      ),
    );
  }
}
