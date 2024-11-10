import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/contact-us/ui/widgets/contact_us_list_tile.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  static const String route = 'contact-us';
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: const MyLogoWidget(),
        leadingWidget: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actionWidgets: const [LocalizationButton()],
      ),
      body: Padding(
        padding: 20.paddingH(context).copyWith(
              top: 8.pxV(context),
              bottom: 8.pxV(context),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              lc(context).contactUs,
              style: myTextStyle.font_25wRegular,
            ),
            12.vSpace(context),
            ContactUsListTile(
              heading: lc(context).emailAddress,
              value: "info@hilance.app",
              icon: Icons.email,
              onTap: () async => await launchUrl(
                Uri.parse("mailto:info@hilance.app"),
                mode: LaunchMode.externalApplication,
              ),
            ),
            ContactUsListTile(
              heading: lc(context).phone,
              value: "+964 770 783 8786",
              icon: Icons.phone,
              onTap: () async => await launchUrl(
                Uri.parse("tel:+9647707838786"),
              ),
            ),
            ContactUsListTile(
              heading: lc(context).phone,
              value: "+234 80 6699 1590",
              icon: Icons.phone,
              onTap: () async => await launchUrl(
                Uri.parse("tel:+2348066991590"),
              ),
            ),
            ContactUsListTile(
              heading: lc(context).website,
              value: "https://roboti.app/",
              icon: Icons.insert_link_rounded,
              onTap: () async => await launchUrl(
                Uri.parse("https://roboti.app/"),
                mode: LaunchMode.externalApplication,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
