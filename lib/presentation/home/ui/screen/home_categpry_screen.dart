// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/no_data_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/home_category_shimmer.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/home_page_carousel.dart';
// import 'package:roboti_app/presentation/home/ui/widget/home/home_page_carousel.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/home_page_data_grid.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/user_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class HomeCategoryScreen extends StatefulWidget {
  static const route = 'home-screen';

  const HomeCategoryScreen({super.key});

  @override
  State<HomeCategoryScreen> createState() => _HomeCategoryScreenState();
}

class _HomeCategoryScreenState extends State<HomeCategoryScreen> {
  bool loader = false;
  // final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    homeBloc.add(GetCategoriesEvent());
  }

  List<Widget> data = [
    Image.asset(MyImages.banner1En, fit: BoxFit.cover),
    Image.asset(MyImages.banner2En, fit: BoxFit.cover),
    Image.asset(MyImages.banner1Ar, fit: BoxFit.cover),
    Image.asset(MyImages.banner2Ar, fit: BoxFit.cover),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _key,
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) => buildUi(context, state),
      ),
    );
  }

  Widget buildUi(BuildContext context, HomeState state) {
    if (state is HomeDataLoadingState) {
      return HomeCategoryScreenLoadingShimmer(data: data);
    } else {
      return displayData(context);
    }
  }

  Widget displayData(BuildContext context) {
    if (homeBloc.categories.isEmpty) {
      return NoDataWidget(text: lc(context).noCategoriesToDisplay);
    } else {
      return ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          12.vSpace(context),
          HomeCategoryScreenCarousel(data: data, length: 2),
          16.vSpace(context),
          UserProfileTile(profile: homeBloc.loginResponse),
          16.vSpace(context),
          HomepageDataGrid(categories: homeBloc.categories),
          16.vSpace(context),
        ],
      );
    }
  }
}
