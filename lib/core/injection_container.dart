import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/get_articles.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/remove_article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/save_article.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

   final database = await $FloorAppDatabase.databaseBuilder('app_database').build();
   sl.registerSingleton<AppDatabase>(database);

  //when using register singleton one instance is used during app lifecycle
   sl.registerSingleton<Dio>(Dio());

   sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

   sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

   sl.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(sl()));

   sl.registerSingleton<GetSavedArticlesUseCase>(GetSavedArticlesUseCase(sl()));

   sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

   sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

   //when using register factory new instance is created every time
   sl.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(sl()));

   sl.registerFactory<LocalArticleBloc>(() => LocalArticleBloc(sl(), sl(), sl()));
}