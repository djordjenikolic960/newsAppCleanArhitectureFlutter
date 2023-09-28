
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticlesUseCase implements UseCase<List<Article>, void> {
  final ArticleRepository _articleRepository;

  GetSavedArticlesUseCase(this._articleRepository);

  @override
  Future<List<Article>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }

}