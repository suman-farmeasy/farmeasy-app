class NewsData {
  final List<AgricultureNews>? results;

  NewsData({this.results});

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      results: (json['results'] as List?)
          ?.map((item) => AgricultureNews.fromJson(item))
          .toList(),
    );
  }
}

class AgricultureNews {
  final String article_id;
  final String title;
  final String image_url;
  final String source_id;
  final String description;
  // final String fullDescription;
  // final String author;
  // final DateTime date;
  // final List<String> category;
  // final String region;
  // final String fullNewsLink;
  // final List<String> tags;
  // final String readTime;
  // final int views;
  // final int shareCount;

  AgricultureNews({
    required this.article_id,
    required this.title,
    required this.description,
    required this.image_url,
    required this.source_id,
    // required this.fullDescription,
    // required this.author,
    // required this.date,
    // required this.category,
    // required this.region,
    // required this.fullNewsLink,
    // required this.tags,
    // required this.readTime,
    // required this.views,
    // required this.shareCount,
  });

  // Convert from JSON
  factory AgricultureNews.fromJson(Map<String, dynamic> json) {
    return AgricultureNews(
      article_id: json['article_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image_url: json['image_url'] as String? ?? '',
      source_id: json['source_id'] as String? ?? '',
      // fullDescription: json['fullDescription'] as String,
      // author: json['author'] as String,
      // date: DateTime.parse(json['date'] as String),
      // category: List<String>.from(json['category']),
      // region: json['region'] as String,
      // fullNewsLink: json['fullNewsLink'] as String,
      // tags: List<String>.from(json['tags']),
      // readTime: json['readTime'] as String,
      // views: json['views'] as int,
      // shareCount: json['shareCount'] as int,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'article_id': article_id,
      'title': title,
      'description': description,
      'image_url': image_url,
      'source_id': source_id,
      // 'fullDescription': fullDescription,
      // 'author': author,
      // 'date': date.toIso8601String(),
      // 'category': category,
      // 'region': region,
      // 'fullNewsLink': fullNewsLink,
      // 'tags': tags,
      // 'readTime': readTime,
      // 'views': views,
      // 'shareCount': shareCount,
    };
  }
}
