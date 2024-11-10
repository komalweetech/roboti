import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/common/widget/no_data_widget.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_states.dart';
import 'package:roboti_app/presentation/subscription/views/screens/subscription_success.dart';
import 'package:roboti_app/presentation/subscription/views/widgets/app_features_widget.dart';
import 'package:roboti_app/presentation/subscription/views/widgets/subscription_bottom_widget.dart';
import 'package:roboti_app/presentation/subscription/views/widgets/subscription_plans_list.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/date_time.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

import '../../../home/ui/widget/drawer/drawer_close_btn.dart';

class SubscriptionPlan extends StatefulWidget {
  static const String route = "subscription-plan";
  const SubscriptionPlan({super.key});
  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {
  @override
  void initState() {
    super.initState();
    subscriptionBloc.add(GetSubscriptionPlansEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black0D0D0D,
      // appBar: const RobotiLogoAppbar(),
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionSuccessState) {
            context.pushReplacementNamed(SubscriptionSuccessFull.route);
          }
        },
        builder: (context, state) {
          return ListView(
            padding: 25.paddingH(context),
            physics: const BouncingScrollPhysics(),
            children: [
              MyAppBar(
                leadingWidth: 30,
                leadingWidget: DrawerCloseButton(
                  onTap: () => context.pop(),
                  iconColor: MyColors.white,
                  iconSize: 20,
                  size: 27,
                ),
                title: const MyLogoWidget(),
                actionWidgets: const [LocalizationButton()],
                actionsRightMargin: 0,
                leadingWidgetLeftMargin: 0,
              ),
              42.vSpace(context),
              Image.asset(MyIcons.subscriptionplanlogo),
              15.vSpace(context),
              const AppFeaturesWidget(),
              15.vSpace(context),
              if (state is SubscriptionPlanLoadingState)
                CustomCupertinoLoader.showLoaderWidget()
              else if (state is SubscriptionPlanErrorState)
                SizedBox(
                  height: 100.pxV(context),
                  child: NoDataWidget(text: lc(context).noPlans),
                )
              else
                SubscriptionPlansList(packages: subscriptionBloc.allPackages),
              TextView(
                'Subscriptions automatically renew unless canceled at least 24 hours before the end of the current period. The renewal charge will be applied to your iTunes account within 24 hours prior to the end of the current period. You can manage and cancel your subscriptions at any time via your iTunes account settings. Any unused portion of a free trial period will be forfeited when you purchase a subscription.',
                style: myTextStyle.font_14w400,
              ),
              if (state is! SubscriptionPlanLoadingState &&
                  state is! SubscriptionPlanErrorState) ...[
                13.vSpace(context),
                // MyElevatedButton(

                MyLoaderElvButton(
                  state: null,
                  text: lc(context).subscribe,
                  textStyle: myTextStyle.font_20wMedium,
                  onPressed: () =>
                      subscriptionBloc.add(PurchaseSubscriptionEvent()),
                ),
              ],
              17.vSpace(context),
              const SubscriptionBottomWidget(),
              15.percentHeight(context).vSpace(context),
              if (subscriptionBloc.recentSubscriptionExpiryDate.isNotEmpty)
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${lc(context).expired}:  ${subscriptionBloc.recentSubscriptionExpiryDate.toDDMMYYYYHHMM()}",
                    style: 12.txt(context).textColor(MyColors.grey181924),
                  ),
                ),
              48.vSpace(context),
            ],
          );
        },
      ),
    );
  }
}
