import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class SubscriptionPlansList extends StatefulWidget {
  final List<Package> packages;

  const SubscriptionPlansList({super.key, required this.packages});

  @override
  State<SubscriptionPlansList> createState() => _SubscriptionPlansListState();
}

class _SubscriptionPlansListState extends State<SubscriptionPlansList> {
  int? selectedValue;

  int calculateDiscount(int index) {
    final multiplier = index == 1 ? 4 : 48;
    final price = widget.packages[0].storeProduct.price;
    final otherPrice = widget.packages[index].storeProduct.price;
    final discount = 100 - ((otherPrice / (price * multiplier)) * 100).round();
    return discount;
  }

  LinearGradient discountGradient(int index) {
    return switch (index) {
      1 => const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MyColors.blue601FD2,
            MyColors.blue4B3EE1,
            Color(0xff2575FC),
          ],
        ),
      2 => const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffD21F79), Color(0xffFC2525)],
        ),
      _ => throw UnimplementedError(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.packages.length,
        (index) {
          Package package = widget.packages[index];
          return Stack(
            children: [
              Container(
                height: 76.pxH(context),
                margin: 8.paddingBottom(context),
                // padding: 8.paddingAll(context),
                width: 100.percentWidth(context),
                decoration: BoxDecoration(
                  color: MyColors.grey161A27,
                  borderRadius: BorderRadius.circular(10.pxH(context)),
                  border: selectedValue == index
                      ? Border.all(color: MyColors.blue296FF9)
                      : null,
                ),
                child: RadioListTile<int>(
                  enableFeedback: true,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  activeColor: MyColors.blue296FF9,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  contentPadding: 7.paddingAll(context),
                  title: TextView(
                    package.storeProduct.title,
                    style: myTextStyle.font_16wRegular,
                  ),
                  subtitle: TextView(
                    package.storeProduct.priceString,
                    style: myTextStyle.font_16wRegular
                        .textColor(MyColors.grey74747B),
                  ),
                  value: index,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() => selectedValue = value);
                    subscriptionBloc.selectedPackage = package;
                  },
                ),
              
              ),
              if (index != 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 25,
                    width: 89.pxV(context),
                    decoration: BoxDecoration(
                      gradient: discountGradient(index),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${calculateDiscount(index)}% OFF',
                        textAlign: TextAlign.center,
                        style:
                            myTextStyle.font_12w500.textColor(MyColors.white),
                      ),
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );

    // Column(
    //   children: List.generate(widget.packages.length, (index) {
    //     final package = widget.packages[index];

    //     final showDiscount = package.storeProduct.title != 'Weekly Plan';

    //     return Stack(
    //       children: [
    //         Container(
    //           height: 76.pxH(context),
    //           margin: 8.paddingBottom(context),
    //           // padding: 8.paddingAll(context),
    //           width: 100.percentWidth(context),
    //           decoration: BoxDecoration(
    //             color: MyColors.grey161A27,
    //             borderRadius: BorderRadius.circular(10.pxH(context)),
    //             border: Border.all(color: MyColors.blue296FF9),
    //           ),
    //           child: RadioListTile<int>(
    //             enableFeedback: true,
    //             visualDensity: const VisualDensity(
    //                 horizontal: VisualDensity.minimumDensity,
    //                 vertical: VisualDensity.minimumDensity),
    //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //             contentPadding: 7.paddingAll(context),
    //             title: TextView(
    //               package.storeProduct.title,
    //               style: myTextStyle.font_16wRegular,
    //             ),
    //             subtitle: TextView(
    //               package.storeProduct.priceString,
    //               style: myTextStyle.font_16wRegular
    //                   .textColor(MyColors.grey74747B),
    //             ),
    //             value: index,
    //             groupValue: selectedValue,
    //             onChanged: (value) {
    //               setState(() => selectedValue = value);
    //               subscriptionBloc.selectedPackage = package;
    //             },
    //           ),
    //         ),
    //         if (showDiscount)
    //           Positioned(
    //             top: 0,
    //             right: 0,
    //             child: Container(
    //               height: 25,
    //               width: 89.pxV(context),
    //               decoration: BoxDecoration(
    //                 gradient: discountGradient(index),
    //                 borderRadius: const BorderRadius.only(
    //                   topRight: Radius.circular(10),
    //                 ),
    //               ),
    //               child: Align(
    //                 alignment: Alignment.center,
    //                 child: Text(
    //                   '${calculateDiscount(index)}% OFF',
    //                   textAlign: TextAlign.center,
    //                   style: myTextStyle.font_12w500.textColor(MyColors.white),
    //                 ),
    //               ),
    //             ),
    //           ),
    //       ],
    //     );
    //   }),
    // );
  }
}
