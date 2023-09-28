
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/model/article.dart';

abstract class LocalArticleState extends Equatable {
  final List<Article>? articles;

  const LocalArticleState({this.articles});

  @override
  List<Object> get props => [articles!];
}

class LocalArticlesLoading extends LocalArticleState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticleState {
  const LocalArticlesDone(List<Article> articles): super(articles: articles);
}