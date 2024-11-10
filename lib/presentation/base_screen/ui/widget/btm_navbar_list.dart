import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/presentation/base_screen/ui/widget/btm_navbar_icon.dart';
import 'package:roboti_app/theme/my_icons.dart';

/// TODO: If u change any of the screens, please update the ask indsex

class BtmNavbar {
  static List<BottomNavigationBarItem> getnavBarItems(BuildContext context) {
    List<BottomNavigationBarItem> navBarItems = [
      BottomNavigationBarItem(
        icon: const BtmNavbarIcon(path: MyIcons.homeUntapped),
        activeIcon: const BtmNavbarIcon(path: MyIcons.homeTapped),
        label: lc(context).home,
      ),
      // BottomNavigationBarItem(
      //   icon: const BtmNavbarIcon(path: MyIcons.toolsUntapped),
      //   activeIcon: const BtmNavbarIcon(path: MyIcons.toolsTapped),
      //   label: lc(context).tools,
      // ),
      BottomNavigationBarItem(
        icon: const BtmNavbarIcon(path: MyIcons.chatUntapped),
        activeIcon: const BtmNavbarIcon(path: MyIcons.chatTapped),
        label: lc(context).ask,
      ),
      BottomNavigationBarItem(
        icon: const BtmNavbarIcon(path: MyIcons.historyUntapped),
        activeIcon: const BtmNavbarIcon(path: MyIcons.historyTapped),
        label: lc(context).history,
      ),
      BottomNavigationBarItem(
        icon: const BtmNavbarIcon(path: MyIcons.newsUntapped),
        activeIcon: const BtmNavbarIcon(path: MyIcons.newsTapped),
        label: lc(context).news,
      ),
    ];
    return navBarItems;
  }

  static int askIndex = 1;
}
