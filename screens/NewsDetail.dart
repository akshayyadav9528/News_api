import 'package:flutter/material.dart';
import 'package:news/models/news_model.dart';

class NewsdetailScreen extends StatelessWidget {
  final News news;
  const NewsdetailScreen({Key? key, required this.news});

  void sendMessage(String m) {
    print(m);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        actions: [
          IconButton(
            onPressed: () {
              sendMessage("welcome");
            },
            icon: Icon(Icons.share),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border)),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      news.category,
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                  Text(
                    '${news.publishedAt.toLocal()}',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                news.title,
                style: TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                news.source,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.network(
                  news.imageURL ?? "",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
              ),
              SizedBox(height: 20),
              Text(news.content, style: TextStyle(fontSize: 16, height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }
}
