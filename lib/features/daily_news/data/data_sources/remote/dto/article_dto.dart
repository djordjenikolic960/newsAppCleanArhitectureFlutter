import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/model/article.dart';

class ArticleDto extends Equatable {
  final int? id;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleDto({
    this.id,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @override
  List<Object?> get props => [
    id,
    author,
    title,
    description,
    url,
    urlToImage,
    publishedAt,
    content,
  ];

  Article toArticle() {
    return Article(
        id: id,
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content
    );
  }

  factory ArticleDto.fromJson(Map<String, dynamic> map) {
    return ArticleDto(
      author: map['author'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      url: map['url'] ?? "",
      urlToImage: map['urlToImage'] ?? "",
      publishedAt: map['publishedAt'] ?? "",
      content: map['content'] ?? "",
    );
  }
}