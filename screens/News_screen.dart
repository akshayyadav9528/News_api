import 'package:flutter/material.dart';
import 'package:news/models/news_model.dart';
import 'package:news/screens/NewsDetail.dart';
import 'package:provider/provider.dart';
import 'package:news/providers/News_providers.dart';
import 'package:intl/intl.dart';

class News_Screen extends StatefulWidget {
  const News_Screen({super.key});

  @override
  State<News_Screen> createState() => _News_Screen();
}

class _News_Screen extends State<News_Screen> {
  final _dateFormat = DateFormat('MMM d, yyyy');
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsProvider = Provider.of<NewsProviders>(context, listen: false);
      newsProvider.fetchCategories();
      newsProvider.fetchNews("All");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Consumer<NewsProviders>(
        builder: (context, newsProvider, child) {
          return newsProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCategoriesSection(newsProvider),
                        SizedBox(height: 10),
                        newsProvider.newsList.isNotEmpty
                            ? _buildLatestNewsCard(newsProvider.newsList.first)
                            : _buildEmptyState("No latest news available"),
                        SizedBox(height: 20),
                        _buildSectionwithaction(
                          'Around The World',
                          actionText: 'See All',
                        ),
                        SizedBox(height: 20),
                        _buildHorizontalNewsList(newsProvider),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(Icons.search, color: Colors.blueGrey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(NewsProviders newsProvider) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 16),
      child: newsProvider.category.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsProvider.category.length,
              itemBuilder: (context, index) {
                final category = newsProvider.category[index];
                final isSelected =
                    category.name.toLowerCase() ==
                    (newsProvider.selectedCategory ?? '').toLowerCase();

                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        final categoryName = category.name == "All"
                            ? null
                            : category.name;
                        newsProvider.fetchNews(categoryName);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.purple[100]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (category.icon != null) ...[
                              Icon(
                                IconData(
                                  category.icon == 'computer'
                                      ? 0xe1bd
                                      : // computer
                                        category.icon == 'crickets'
                                      ? 0xe175
                                      : // sports
                                        category.icon == 'health_and_safety'
                                      ? 0xe33c
                                      : // health
                                        category.icon == 'business'
                                      ? 0xe0af
                                      : // business
                                        0xe88a, // default icon
                                  fontFamily: 'MaterialIcons',
                                ),
                                color: isSelected
                                    ? Colors.purple[800]
                                    : Colors.grey[600],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              category.name,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.purple[800]
                                    : Colors.grey[600],
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildLatestNewsCard(News news) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            news.title,
            maxLines: 3,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple[800],
            ),
          ),
          ...[
            SizedBox(height: 8),
            Text(
              news.description!,
              style: TextStyle(fontSize: 14, color: Colors.purple[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Text(message, style: TextStyle(color: Colors.grey)),
    );
  }
}

_buildHorizontalNewsList(NewsProviders newsProvider) {
  return SizedBox(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: newsProvider.newsList.length,
      itemBuilder: (context, index) {
        final news = newsProvider.newsList[index];
        return _buildAround(news, context);
      },
    ),
  );
}

_buildAround(News news, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewsdetailScreen(news: news)),
      );
    },
    child: Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(news.imageURL ?? ""),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black12.withOpacity(0.4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              news.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

_buildSectionwithaction(
  String title, {
  String? actionText,
  VoidCallback? onActionTap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(title, style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      if (actionText != null)
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionText!,
            style: TextStyle(color: Colors.blue),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

      const SizedBox(height: 6),
      Text(title, style: TextStyle(color: Colors.white70)),
    ],
  );
}
