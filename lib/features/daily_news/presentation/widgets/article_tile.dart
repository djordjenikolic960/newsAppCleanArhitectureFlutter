import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/model/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/pages/home/article_details.dart';

class ArticleWidget extends StatelessWidget {
  final Article? article;
  final bool isRemovable;

  const ArticleWidget({super.key, this.article, required this.isRemovable});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onArticlePressed(context, article!);
      },
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 14, end: 14, bottom: 14),
        height: MediaQuery.of(context).size.width / 2.2,
        child: Row(
          children: [
            _buildImage(context),
            _buildTitleAndDescription(context),
          ],
        ),
      ),
    );
  }

  _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article!.urlToImage!,
      imageBuilder: (context, imageProvider) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.08),
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.08),
            ),
          ),
        ),
      ),
    );
  }

  _buildTitleAndDescription(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article!.title ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Colors.black87),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(article!.content ?? "", maxLines: 2),
            )),
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  article!.publishedAt!,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            isRemovable ? IconButton(icon: const Icon(Icons.delete), onPressed: () {
              BlocProvider.of<LocalArticleBloc>(context, listen: false).add(RemoveArticle(article!));
            }) : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  void _onArticlePressed(BuildContext context, Article article) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ArticleDetails(article: article);
    }));
  }
}
