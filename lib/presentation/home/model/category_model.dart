import 'package:roboti_app/utils/extensions/string_extendsions.dart';

class HomeCategoryModel {
  final String id;
  final String title;
  final String translatedTitle;
  final String description;
  final String translatedDescription;
  final String imageUrl;
  final String sorting;

  const HomeCategoryModel({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.title,
    required this.translatedTitle,
    required this.translatedDescription,
    required this.sorting,
  });

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    return HomeCategoryModel(
      id: json['_id'],
      description: json['descripiton'].toString().capitalizeFirst(),
      imageUrl: json['image'] == null
          ? ""
          : "https://roboti.s3.amazonaws.com${json['image']}",
      title: json['name'].toString().capitalizeFirst(),
      translatedTitle: json['translatName'].toString().capitalizeFirst(),
      translatedDescription:
          json['translatDescription'].toString().capitalizeFirst(),
      sorting: json['sorting'].toString(),
    );
  }
}


/*

  {
                "_id": "65801c8486224fa68a1db187",
                "name": "Letters",
                "translatName": "المراسلات",
                "descripiton": "Write effective & formal business letters.",
                "translatDescription": "اكتب رسائل أعمال رسمية  ",
                "image": "/image/645dc154c3a5e6b07671c7c9/1703773427240.svg",
                "count": 0,
                "index": 2,
                "isActive": true,
                "isfavorite": true,
                "createdAt": "2023-12-18T10:18:44.548Z",
                "updatedAt": "2024-01-23T18:31:51.895Z",
                "__v": 0
            },

 */
