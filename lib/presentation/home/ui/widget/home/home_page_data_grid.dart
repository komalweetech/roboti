import 'package:flutter/material.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/presentation/home/model/category_model.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/home_category_tile.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class HomepageDataGrid extends StatelessWidget {
  final List<HomeCategoryModel> categories;
  const HomepageDataGrid({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 20.paddingH(context),
      child: Wrap(
        runSpacing: 1.604.percentHeight(context),
        spacing: 3.72.percentWidth(context),
        children: categories
            .map(
              (cat) => HomeCategoryTile(category: cat, fromEng: isEng),
            )
            .toList(),
      ),
    );
    // return Expanded(
    //   child: GridView.builder(
    //     physics: const BouncingScrollPhysics(),
    //     padding: EdgeInsets.symmetric(horizontal: 4.65.percentWidth(context)),
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       mainAxisExtent: 20.percentHeight(context),
    //       mainAxisSpacing: 1.604.percentHeight(context),
    //       crossAxisSpacing: 3.72.percentWidth(context),
    //     ),
    //     itemCount: data.length + 2,
    //     itemBuilder: (context, index) {
    //       if (index < data.length) {
    //         return HomeCategoryTile(
    //           category: data[index],
    //           fromEng: isEng,
    //         );
    //       }
    //       return 80.vSpace(context);
    //     },
    //   ),
    // );
  }
}
