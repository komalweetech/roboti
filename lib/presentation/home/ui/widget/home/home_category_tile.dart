import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/model/category_model.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/category_image_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class HomeCategoryTile extends StatelessWidget {
  final HomeCategoryModel category;
  final bool fromEng;
  const HomeCategoryTile({
    super.key,
    required this.category,
    required this.fromEng,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.percentHeight(context),
      width: 43.48.percentWidth(context),
      decoration: BoxDecoration(
        color: MyColors.secondaryBlue141F48,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: 25.paddingAll(context).copyWith(bottom: 0),
      child: InkWell(
        onTap: () => homeBloc
            .add(SelectCategoryEvent(context: context, category: category)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryImageWidget(
              url: category.imageUrl,
              name: category.title.isNotEmpty ? category.title[0] : "",
            ),
            4.9.vSpace(context),
            FittedBox(
              child: TextView(
                fromEng ? category.title : category.translatedTitle,
                style: myTextStyle.font_25wRegular,
                maxLine: 1,
              ),
            ),
            15.vSpace(context),
            Expanded(
              child: TextView(
                fromEng ? category.description : category.translatedDescription,
                style: myTextStyle.font_25wRegular.copyWith(
                  fontSize: 12.4.pxV(context),
                ),
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // const Spacer(),
            8.vSpace(context)
          ],
        ),
      ),
    );
  }
}
