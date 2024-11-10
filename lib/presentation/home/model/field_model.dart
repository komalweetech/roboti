import 'package:flutter/material.dart';
import 'package:roboti_app/presentation/home/model/field_options.dart';
import 'package:roboti_app/presentation/home/view_model/common/fields_enum.dart';

class FieldModel {
  final String id;
  final String name;
  final FieldType type;
  final String? placeHolder;
  final String? translatedPlaceHolder;
  final bool optional;
  final List<FieldOption> options;
  int? order;
  TextEditingController? textController;

  FieldModel({
    required this.id,
    required this.name,
    required this.placeHolder,
    required this.translatedPlaceHolder,
    required this.optional,
    required this.type,
    required this.options,
    required this.textController,
    required this.order,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    FieldType type = _getFieldType(json["type"]);

    List<FieldOption> options = [];

    if (json['option'] != null) {
      for (Map<String, dynamic> option in json['option']) {
        FieldOption optionModel = FieldOption.fromJson(option);
        options.add(optionModel);
      }
    }

    return FieldModel(
      id: json['_id'],
      name: json['name'],
      placeHolder: json['placeholder'].toString(),
      translatedPlaceHolder: json['placeholder_ar'].toString(),
      optional: json['optional'],
      type: type,
      options: options,
      textController: null,
      order: json['sorting'] == null
          ? null
          : int.parse(json['sorting'].toString()),
    );
  }

  bool get isDropdown => type == FieldType.dropDown;

  static FieldType _getFieldType(String field) {
    switch (field.toLowerCase()) {
      case "input":
        return FieldType.input;
      case "dropdown":
        return FieldType.dropDown;
      default:
        return FieldType.textArea;
    }
  }
}

/*
  {
                    "_id": "65d4a541be63e6f37062a6ab",
                    "name": "dropdown 1",
                    "type": "dropdown",
                    "placeholder": null,
                    "placeholder_ar": null,
                    "option": [
                        {
                            "text": "abc",
                            "value": "abc"
                        },
                        {
                            "text": "abc",
                            "value": "abc"
                        }
                    ],
                    "taskId": "65d4a541be63e6f37062a6a9",
                    "optional": false,
                    "createdAt": "2024-02-20T13:12:33.468Z",
                    "updatedAt": "2024-02-20T13:12:33.468Z",
                    "__v": 0
                }
 */