import 'package:roboti_app/app/app_view.dart';

class NewsModel {
  final String id;
  final String title, translatedTitle;
  final String description, translatedDescription;
  final DateTime publishDate;
  final String imageUrl;
  final bool? isSvg;
  final String? newsUrl;
  final String? sourceName;
  final String? sourceUrl;
  final String? tags;
  final String content, translatedContent;
  final String type, translatedType;

  const NewsModel({
    required this.id,
    required this.title,
    required this.translatedTitle,
    required this.description,
    required this.translatedDescription,
    required this.content,
    required this.translatedContent,
    required this.publishDate,
    required this.imageUrl,
    required this.newsUrl,
    required this.isSvg,
    required this.tags,
    required this.type,
    required this.translatedType,
    this.sourceName,
    this.sourceUrl,
  });

  factory NewsModel.fromGlobalNews(Map<String, dynamic> json) {
    String imageUrl = json['image'] ?? "";
    bool? isSvg;

    if (imageUrl.isNotEmpty) {
      isSvg = imageUrl.toLowerCase().contains("svg");
    }

    return NewsModel(
      id: json['_id'],
      title: json['title'],
      translatedTitle: json['translateTitle'] ?? "",
      description: json['description'],
      translatedDescription: json['translateDescription'] ?? "",
      content: json['content'] ?? "",
      translatedContent: json['translateContent'] ?? "",
      publishDate: DateTime.parse(json['publishedAt']),
      imageUrl: imageUrl,
      newsUrl: json['url'],
      isSvg: isSvg,
      tags: null,
      type: "News",
      translatedType: "أخبار",
      sourceName: json['source']['name'],
      sourceUrl: json['source']['url'],
    );
  }

  factory NewsModel.fromRobotiNews(Map<String, dynamic> json) {
    String imageUrl = json['image'] ?? "";
    bool? isSvg;

    if (imageUrl.isNotEmpty) {
      isSvg = imageUrl.toLowerCase().contains("svg");
    }
    return NewsModel(
      id: json['_id'],
      title: json['name'],
      translatedTitle: json['translateName'] ?? "",
      description: json['description'],
      translatedDescription: json['translateDescription'] ?? "",
      content: "",
      translatedContent: "",
      publishDate: DateTime.parse(json['createdAt']),
      imageUrl:
          imageUrl.isEmpty ? "" : "https://roboti.s3.amazonaws.com$imageUrl",
      newsUrl: null,
      isSvg: isSvg,
      tags: json['tag'],
      type: "Roboti News",
      translatedType: "أخبار روبوتي",
    );
  }

  // Using for sharing info using share-plus package
  @override
  String toString() {
    String ti = isEng ? title : translatedTitle;
    String ds = isEng ? description : translatedDescription;
    String cn = isEng ? content : translatedContent;
    // String pd = publishDate.toString();
    String link = newsUrl ?? "";
    String tp = isEng ? type : translatedType;
    String img = imageUrl;

    return "Title:$ti\nDescription:$ds\nImage:$img\nType$tp\n$cn\n$link";
  }
}
