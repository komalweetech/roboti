// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

// class DLServices {
//   static void initRoute() {
//     route = null;
//   }

//   static Future<void> __handleDeepLinks() async {
//     FirebaseDynamicLinks.instance.onLink;

//     // Handle initial deep link when the app is cold started
//     final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
//     if (initialLink == null) {
//     } else {
//       if (initialLink.link.path == "/news") {
//         route = DLRoute.robotiNews;
//       } else if (initialLink.link.path == "/globalNews") {
//         route = DLRoute.globalNews;
//       }
//     }


//   }

//   static Future<DLRoute?> getDLRoute() async {
//     if (route == null) {
//       await __handleDeepLinks();
//     }
//     return route;
//   }

//   static DLRoute? route;
// }

// enum DLRoute { robotiNews, globalNews }
