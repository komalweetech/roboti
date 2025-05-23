// import 'package:roboti/utils/app_constants/app_context.dart';
// import 'package:roboti/utils/enums/apis_enum.dart';
// import 'package:roboti/utils/enums/status_enum.dart';
// import 'package:flutter/material.dart' as material;
// import 'package:flutter_redux/flutter_redux.dart';

// import 'base_state.dart';

// class BaseDispatch {
//   static material.BuildContext context = GlobalContext.currentContext!;

//   void _dispatch<T>({required State state}) {
//     StoreProvider.of<T>(context).dispatch(State);
//   }

//   void dispatchGet<T>({
//     required APIsEnum type,
//     required ResponseStatus status,
//     dynamic payload,
//     String error = '',
//   }) {
//     _dispatch<T>(
//       state: StateGet(
//         type: type,
//         status: status,
//         payloadData: payload,
//         error: error,
//       ),
//     );
//   }

//   void dispatchPost<T>({
//     required APIsEnum type,
//     required ResponseStatus status,
//     dynamic payload,
//     String error = '',
//   }) {
//     _dispatch<T>(
//       state: StateAdd(
//         type: type,
//         status: status,
//         payloadData: payload,
//         error: error,
//       ),
//     );
//   }

//   void dispatchUpdate<T>({
//     required APIsEnum type,
//     required ResponseStatus status,
//     dynamic payload,
//     String error = '',
//   }) {
//     _dispatch<T>(
//       state: StateUpdate(
//         type: type,
//         status: status,
//         payloadData: payload,
//         error: error,
//       ),
//     );
//   }

//   void dispatchDelete<T>({
//     required APIsEnum type,
//     required ResponseStatus status,
//     dynamic payload,
//     String error = '',
//   }) {
//     _dispatch<T>(
//       state: StateDelete(
//         type: type,
//         status: status,
//         payloadData: payload,
//         error: error,
//       ),
//     );
//   }
// }
