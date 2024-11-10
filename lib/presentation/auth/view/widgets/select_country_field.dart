import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_text_field.dart';
import 'package:roboti_app/presentation/auth/view/widgets/country_widget.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class ChooseCountryWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(Country country) onSelected;
  const ChooseCountryWidget({
    super.key,
    required this.controller,
    required this.onSelected,
  });

  @override
  State<ChooseCountryWidget> createState() => _ChooseCountryWidgetState();
}

class _ChooseCountryWidgetState extends State<ChooseCountryWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CountryPicker.showPicker(
        context,
        onSelected: (country) => widget.onSelected(country),
      ),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      // child: BlocConsumer<AuthBloc, AuthState>(
      //   listener: (context, state) {
      //     // String name = state.user.countryName;
      //     // if (state is CountrySelectedState) {
      //     //   controller!.text = authBloc.user.countryName;
      //     // }
      //   },
      //   builder: (context, state) =>
      child: AbsorbPointer(
        absorbing: true,
        child: MyTextFormField(
          hintText: lc(context).chooseYourCountry,
          bottomSpace: 16,
          prefixIconPath: MyIcons.globeIcon,
          margin: 20.paddingH(context),
          readOnly: true,
          controller: widget.controller,
          suffixIcon: Container(
            width: 10.88.pxH(context),
            height: 10,
            padding: 22.paddingAll(context),
            child: SvgPicture.asset(
              MyIcons.arrowDownIcon,
            ),
          ),
        ),
      ),
      // ),
    );
  }
}

class DownArrowIconButton extends StatelessWidget {
  const DownArrowIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10.88.pxH(context),
      child: SvgPicture.asset(
        MyIcons.arrowDownIcon,
      ),
    );
  }
}
