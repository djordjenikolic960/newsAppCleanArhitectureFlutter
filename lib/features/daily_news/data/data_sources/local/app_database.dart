import 'package:floor/floor.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/local/DAO/article_dao.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/local/entity/article_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleEntity])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
