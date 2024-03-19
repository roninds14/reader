import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Comic {
  Comic({
    required this.title,
    required this.shortTitle,
    required this.author,
    required this.source,
    required this.description,
    required this.language,
    required this.cover,
    required this.urlModel,
    required this.initialPageNumber,
    required this.numberPages,
    required this.decimals,
    required this.decimalsSeparator,
    required this.colectionCode,
    required this.tags,
  });

  final String title;
  final String shortTitle;
  final String author;
  final String source;
  final String description;
  final String language;
  final String cover;
  final String urlModel;
  final int initialPageNumber;
  final int numberPages;
  final int decimals;
  final String decimalsSeparator;
  final int colectionCode;
  final List<String> tags;

  factory Comic.fromJson(Map<String, dynamic> json) => Comic(
        title: json['title'] as String,
        shortTitle: json['shortTitle'] as String,
        author: json['author'] as String,
        source: json['source'] as String,
        description: json['description'] as String,
        language: json['language'] as String,
        cover: json['cover'] as String,
        urlModel: json['urlModel'] as String,
        initialPageNumber: json['initialPageNumber'] as int,
        numberPages: json['numberPages'] as int,
        decimals: json['decimals'] as int,
        decimalsSeparator: json['decimalsSeparator'] as String,
        colectionCode: json['colectionCode'] as int,
        tags: List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => _$ComicToJson(this);

  Map<String, dynamic> _$ComicToJson(Comic instance) => <String, dynamic>{
        "title": instance.title,
        "shortTitle": instance.shortTitle,
        "author": instance.author,
        "source": instance.source,
        "description": instance.description,
        "language": instance.language,
        "cover": instance.cover,
        "urlModel": instance.urlModel,
        "initialPageNumber": instance.initialPageNumber,
        "numberPages": instance.numberPages,
        "decimals": instance.decimals,
        "decimalsSeparator": instance.decimalsSeparator,
        "colectionCode": instance.colectionCode,
        "tags": List<dynamic>.from(instance.tags.map((x) => x)),
      };
}
