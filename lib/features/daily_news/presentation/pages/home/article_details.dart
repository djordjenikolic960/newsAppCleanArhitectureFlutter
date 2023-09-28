import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/injection_container.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_event.dart';

class ArticleDetails extends StatelessWidget {
  final Article? article;

  const ArticleDetails({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(
        article!.title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 18, color: Colors.black87),
      ),
    );
  }

  _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(article!.urlToImage!),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            article!.description!,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            article!.content!,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
        )
      ],
    );
  }

  _buildFloatingActionButton() {
    return Builder(
        builder: (context) => FloatingActionButton(
            onPressed: () => _onFloatingActionButtonPressed(context),
            child: const Icon(Icons.bookmark)));
  }

  _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context, listen: false)
        .add(SaveArticle(article!));
  }
}
