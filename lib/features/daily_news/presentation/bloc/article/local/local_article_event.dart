import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/model/article.dart';

abstract class LocalArticleEvent extends Equatable {
  final Article? article;

  const LocalArticleEvent({this.article});

  @override
  List<Object> get props => [article!];
}

class GetSavedArticles extends LocalArticleEvent {
  const GetSavedArticles();
}

class SaveArticle extends LocalArticleEvent {
  const SaveArticle(Article article): super(article: article);
}

class RemoveArticle extends LocalArticleEvent {
  const RemoveArticle(Article article): super(article: article);
}