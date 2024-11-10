import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/profile_image_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/profile/ui/screen/profile_screen.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_states.dart';
import 'package:roboti_app/presentation/subscription/views/widgets/membership_pop_up.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class UserProfileTile extends StatefulWidget {
  final LoginResponse profile;
  const UserProfileTile({super.key, required this.profile});

  @override
  State<UserProfileTile> createState() => _UserProfileTileState();
}

class _UserProfileTileState extends State<UserProfileTile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      bloc: subscriptionBloc,
      listener: (context, state) {
        if (state is SubscriptionExpiryUpdated) {
          if (mounted) setState(() {});
        }
      },
      builder: (context, state) => GestureDetector(
        onTap: () => context.pushNamed(ProfileScreen.route),
        child: Container(
          padding: 7.6.paddingV(context).copyWith(
                left: 11.pxH(context),
                right: 11.pxH(context),
              ),
          margin: 20.paddingH(context),
          //EdgeInsets.symmetric(horizontal: 4.65.percentWidth(context)),
          width: 100.percentWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.pxV(context)),
            color: MyColors.secondaryBlue141F48,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImageWidget(
                imageUrl: widget.profile.imageUrl,
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
                      widget.profile.name!.trim().isEmpty
                          ? lc(context).anonymousUser
                          : widget.profile.name!.trim(),
                      style:
                          myTextStyle.font_20wMedium.w200.copyWith(height: 1),
                      maxLine: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (!Platform.isAndroid)
                Container(
                  height: 25.pxV(context),
                  alignment: Alignment.center,
                  margin: 20.paddingBottom(context),
                  padding: 15.paddingH(context),
                  decoration: BoxDecoration(
                    color: state is LoadSubscriptionstatusState
                        ? MyColors.blue6C63FF
                        : getMemberShip().$2,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextView(
                    state is LoadSubscriptionstatusState
                        ? "  ${lc(context).loading}...  "
                        : getMemberShip().$1,
                    style: myTextStyle.font_13w300,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  (String, Color) getMemberShip() {
    final freeMember = (lc(context).freeMember, MyColors.blue0351FF);

    final starterMember = (lc(context).starterMember, MyColors.orangeF88B2E);
    final premiumMember = (lc(context).premiumMember, MyColors.green00D17F);
    final expiredMember = (lc(context).expired, MyColors.red);

    if (subscriptionBloc.trialModel!.isFreeUser) {
      return freeMember;
    }

    if (subscriptionBloc.trialModel?.trialLimit != 0) {
      // Started Member
      return starterMember;
    } else if (Platform.isAndroid) {
      return starterMember;
    } else {
      if (TrialRequestHandler.isPremium()) {
        return premiumMember;
      } else if (TrialRequestHandler.isExpired()) {
        return expiredMember;
      }
      return starterMember;
    }
  }
}
