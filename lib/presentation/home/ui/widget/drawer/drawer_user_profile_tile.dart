import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_buttons/my_elevated_button.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/profile_image_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_bloc.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_events.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class DrawerUserProfileTile extends StatelessWidget {
  final LoginResponse profile;
  const DrawerUserProfileTile({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.paddingV(context).copyWith(
            left: 16.pxH(context),
            right: 16.pxH(context),
          ),
      margin: 20.paddingLeft(context).copyWith(right: 17.pxH(context)),
      width: 100.percentWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.pxV(context)),
        color: MyColors.secondaryBlue141F48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ProfileImageWidget(
                imageUrl: homeBloc.loginResponse.imageUrl,
                file: homeBloc.loginResponse.file,
              ),
              13.2.hSpace(context),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextView(
                      lc(context).hello,
                      style:
                          myTextStyle.font_20wMedium.w200.copyWith(height: 1),
                    ),
                    4.vSpace(context),
                    TextView(
                      profile.name!.trim().isEmpty
                          ? lc(context).anonymousUser
                          : profile.name!.trim(),
                      style:
                          myTextStyle.font_20wMedium.w200.copyWith(height: 1),
                      maxLine: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          7.2.vSpace(context),
          MyElevatedButton(
            height: 48.pxV(context),
            width: 206.pxH(context),
            text: lc(context).editProfile,
            onPressed: () => {
              context.pop(),
              profileBloc.add(GotoEditProfileEvent(context: context)),
            },
            borderRadius: BorderRadius.circular(10.pxV(context)),
            buttonBGColor: MyColors.blue23326A,
            textStyle: myTextStyle.font_20wMedium.regular,
          ),
        ],
      ),
    );
  }
}
