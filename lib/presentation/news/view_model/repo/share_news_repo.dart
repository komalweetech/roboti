import 'package:roboti_app/app/app_view.dart';
import 'package:share_plus/share_plus.dart';

class ShareNews {
  static Future<void> share(bool isGlobalNews) async {
    String msg =
        "${isEng ? "Here is the news for Roboti news" : "هذه هي الأخبار لأخبار Roboti"} https://roboti.page.link/news";

    if (isGlobalNews) {
      msg =
          "${isEng ? "Here is the news for Global news" : "هنا الأخبار للأخبار العالمية"} https://roboti.page.link/globalNews";
    }
    await Share.share(msg.toString());
  }
}
