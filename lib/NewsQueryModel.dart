class NewsQueryModel{

  late String newsHead;
  late String newsDesc;
  late String url;
  late String urlToImage;

  NewsQueryModel({this.newsHead = "NewsHead",this.newsDesc = "NewsDescription",this.url = "UrlData",this.urlToImage = "UrlToImage"});

  factory NewsQueryModel.fromMap(news){
    return NewsQueryModel(
      newsHead: news['title'],
      newsDesc: news['description'],
      url: news['url'],
      urlToImage: news['urlToImage']
    );
  }
}