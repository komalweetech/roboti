import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/presentation/base_screen/ui/widget/btm_navbar_list.dart';
import 'package:roboti_app/presentation/base_screen/ui/widget/screens.dart';
import 'package:roboti_app/presentation/chat/ui/screen/chat_screen.dart';
import 'package:roboti_app/presentation/home/ui/widget/drawer/my_drawer.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_drawer_icon.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class BaseScreen extends StatefulWidget {
  static const String route = "base_screen.dart";
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    homeBloc.add(ForceUpdateEvent());

    // setMataData();
    super.initState();
    // handleDeepLinks();
    // handleDeepLinks();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant BaseScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  int currrentIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // DLRoute? route;

  // void dlRouting() {
  //   DLServices.getDLRoute().then((r) {
  //     if (r != null) {
  //       if (r == DLRoute.robotiNews) {
  //         route = r;
  //         currrentIndex = 4;
  //         if (mounted) setState(() {});
  //         DLServices.initRoute();
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // if (route == null) dlRouting();
    return Scaffold(
      key: _key,
      appBar: MyAppBar(
        leadingWidget:
            MyDrawerIcon(onTap: () => _key.currentState!.openDrawer()),
        title: const MyLogoWidget(),
        actionWidgets: const [LocalizationButton()],
      ),
      drawer: MyDrawer(navigationKey: _key),
      body: Screens.getCurrentScreen(currrentIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 23.35,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: currrentIndex,
        onTap: (index) {
          if (currrentIndex != index) {
            if (index != BtmNavbar.askIndex) {
              setState(() => currrentIndex = index);
            } else {
              context.pushNamed(ChatScreen.route);
            }
          }
        },
        backgroundColor: MyColors.primaryDarkBlue060A19,
        selectedItemColor: MyColors.purple6C63FF,
        unselectedItemColor: MyColors.whiteFFFFFF,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            myTextStyle.font_13w300.regular.textColor(MyColors.purple6C63FF),
        unselectedLabelStyle:
            myTextStyle.font_13w300.regular.textColor(MyColors.whiteFFFFFF),
        items: BtmNavbar.getnavBarItems(context),
      ),
    );
  }
}
