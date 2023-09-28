
import 'package:floor/floor.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/local/entity/article_entity.dart';

@dao
abstract class ArticleDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertArticle(ArticleEntity articleEntity);

  @delete
  Future<void> deleteArticle(ArticleEntity articleEntity);

  @Query('SELECT * FROM article')
  Future<List<ArticleEntity>> getArticles();
}