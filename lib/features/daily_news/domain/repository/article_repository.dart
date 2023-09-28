import 'package:flutter_clean_architecture/core/resources/data_state.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/model/article.dart';

abstract class ArticleRepository {
  // API methods
  Future<DataState<List<Article>>> getNewsArticles();

  // Database methods
  Future<List<Article>> getSavedArticles();

  Future<void> saveArticle(Article article);

  Future<void> removeArticle(Article article);
}