
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/injection_container.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/widgets/article_tile.dart';

class SavedNews extends StatelessWidget {
  const SavedNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>()..add(const GetSavedArticles()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text('Saved news', style: TextStyle(fontSize: 18, color: Colors.black)),
    );
  }

  _buildBody() {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
      builder: (context, state) {
        if (state is LocalArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is LocalArticlesDone) {
          return _buildArticlesList(state.articles!);
        }
        return const SizedBox.shrink();
      },
    );
  }

  _buildArticlesList(List<Article> articles) {
    if (articles.isEmpty) {
      return const Center(
        child: Text("No saved articles", style: TextStyle(color: Colors.black),),
      );
    } else {
      return ListView.builder(itemBuilder: (context, index) {
        return ArticleWidget(
          isRemovable: true,
          article: articles[index],
        );
      },
      itemCount: articles.length);
    }
  }
}
