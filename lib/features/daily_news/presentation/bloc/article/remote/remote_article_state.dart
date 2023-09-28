import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/model/article.dart';

abstract class RemoteArticleState extends Equatable {
  final List<Article>? articles;
  final DioException? exception;

  const RemoteArticleState({this.articles, this.exception});

  @override
  List<Object> get props => [articles!, exception!];
}

class RemoteArticlesLoading extends RemoteArticleState {
  const RemoteArticlesLoading();
}

class RemoteArticlesDone extends RemoteArticleState {
  const RemoteArticlesDone(List<Article> article) : super(articles: article);
}

class RemoteArticleException extends RemoteArticleState {
  const RemoteArticleException(DioException exception): super(exception: exception);
}