import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeCategoryScreenCarousel extends StatefulWidget {
  final List<Widget> data;
  final Duration? animationDuration;
  final Curve animationCurve;
  final int length;
  const HomeCategoryScreenCarousel({
    super.key,
    required this.data,
    required this.length,
    this.animationDuration,
    this.animationCurve = Curves.fastEaseInToSlowEaseOut,
  });

  @override
  State<HomeCategoryScreenCarousel> createState() =>
      _HomeCategoryScreenCarouselState();
}

class _HomeCategoryScreenCarouselState
    extends State<HomeCategoryScreenCarousel> {
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.55.pxV(context),
      width: 100.percentWidth(context),
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: widget.length,
            itemBuilder: (context, index) => const SizedBox(),
          ),
          CarouselSlider.builder(
            itemCount: widget.length,
            itemBuilder: (context, index, index2) => container(
              context,
              widget.data[index + (isEng ? 0 : widget.length)],
            ),
            options: CarouselOptions(
              height: 220.pxV(context),
              autoPlay: widget.length > 1,
              viewportFraction: 0.9,
              aspectRatio: 18 / 9,
              enableInfiniteScroll: widget.length > 1,
              enlargeCenterPage: widget.length > 1,
              enlargeFactor: widget.length > 1 ? 0.2 : 0.3,
              autoPlayCurve: widget.animationCurve,
              onPageChanged: (index, reason) {
                if (controller.hasClients) {
                  if (index == 0) {
                    controller.jumpToPage(index);
                  } else {
                    controller.animateToPage(
                      index,
                      duration: duration,
                      curve: widget.animationCurve,
                    );
                  }
                }
              },
            ),
          ),
          if (widget.length > 1)
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(
                    controller: controller, // PageController
                    count: widget.length,
                    effect: const ExpandingDotsEffect(
                      radius: 100,
                      dotHeight: 7,
                      dotWidth: 7,
                      spacing: 3,
                      activeDotColor: Colors.white,
                      dotColor: Colors.white,
                      paintStyle: PaintingStyle.fill,
                    ), // your preferred effect
                    onDotClicked: (index) {},
                  ),
                  16.vSpace(context),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Duration get duration =>
      widget.animationDuration ?? const Duration(milliseconds: 500);

  Widget container(context, Widget child) {
    return Container(
      height: 250.pxV(context),
      width: 100.percentWidth(context),
      margin: 0.paddingH(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.pxV(context)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.pxV(context)),
        child: child,
      ),
    );
  }
}
