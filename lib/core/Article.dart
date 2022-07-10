class Article {
  final int id;
  final String title;
  final String description;
  final String author;
  final String link;
  final String source;
  final String feedSourceImgLink;
  final String imageURL;

  const Article(
      {required this.id,
      required this.title,
      required this.description,
      required this.author,
      required this.link,
      required this.source,
      required this.feedSourceImgLink,
      required this.imageURL,
      });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        author: json['author'] as String,
        link: json['link'] as String,
        source: json['source'] as String,
        feedSourceImgLink: json['feedSourceImgLink']==null? "": json['feedSourceImgLink']  as String,
        imageURL: json['imageURL']==null? "": json['imageURL']  as String);
        
  }
}
