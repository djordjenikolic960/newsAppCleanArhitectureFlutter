import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/constants/constants.dart';
import 'package:flutter_clean_architecture/core/resources/data_state.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/local/entity/article_entity.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  
  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<Article>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticle(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data
            .map((articleDto) => articleDto.toArticle())
            .toList());
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<Article>> getSavedArticles() async {
    List<ArticleEntity> articleEntities = await _appDatabase.articleDao.getArticles();
    return articleEntities.map((articleEntity) => articleEntity.toArticle()).toList();
  }

  @override
  Future<void> removeArticle(Article article) {
    return _appDatabase.articleDao.deleteArticle(const ArticleEntity().fromArticle(article));
  }

  @override
  Future<void> saveArticle(Article article) {
   return _appDatabase.articleDao.insertArticle(const ArticleEntity().fromArticle(article));
  }
}
