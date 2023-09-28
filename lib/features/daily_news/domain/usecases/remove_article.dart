import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/repository/article_repository.dart';

class RemoveArticleUseCase implements UseCase<void, Article> {
  final ArticleRepository _articleRepository;

  RemoveArticleUseCase(this._articleRepository);

  @override
  Future<void> call({Article ? params}) {
    return _articleRepository.removeArticle(params!);
  }

}