import 'dart:convert';
import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:news_app/NewsQueryModel.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({Key? key}) : super(key: key);

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {

  List<String> newsItem = ["Top News","Pak Tv","Ary News","Geo Headlines","Khyber Tv","Daily Aaj"];

  final List items =["assets/images/headline.jpg"];

  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  List<NewsQueryModel> newsModelProvider = <NewsQueryModel>[];


  bool isLoading = true;

   getNewsQuery(String query) async {

    String url = "https://newsapi.org/v2/everything?q=$query&from=2022-02-10&sortBy=publishedAt&apiKey=b00c42479149492e9ca62a368db80f94";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = NewsQueryModel();
      newsQueryModel = NewsQueryModel.fromMap(element);
      newsModelList.add(newsQueryModel);
      setState(() {
        isLoading = false;
      });
      });
    });
  }


  getNewsProvider(String provider) async {

    String url = "https://newsapi.org/v2/everything?q=$provider&from=2022-02-10&sortBy=publishedAt&apiKey=b00c42479149492e9ca62a368db80f94";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelProvider.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsQuery("pakistan");
    getNewsProvider("india");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("NEWS APP"),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.grey,width:2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:const TextField(
                  decoration: InputDecoration(
                    hintText: "Search Here",
                    prefixIcon:Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            Container(
              height: 50,
              child:ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: newsItem.length,
                  itemBuilder:(context,index){
                    return InkWell(
                      onTap: (){

                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                        margin: const EdgeInsets.symmetric(horizontal:8,vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child:Center(
                          child: Text(newsItem[index],
                          style: const TextStyle(
                            fontSize:15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                          ),
                        ),
                      ),
                    );
                  }
              )
            ),

            CarouselSlider(
              options: CarouselOptions(
                  height: 320.0,
                  autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: newsModelProvider.map((instance) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15,),
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          height: 320.0,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          child:Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child:Image.network(instance.urlToImage,fit: BoxFit.fitHeight,height: 320.0,
                                    ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child:Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                      child:Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children:[
                                          Text(instance.newsHead,style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.white,
                                          ),
                                          ),
                                          const SizedBox(height: 3,),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(instance.newsDesc.length > 50 ? "${instance.newsDesc.substring(0,55)}..." :instance.newsDesc ,style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Colors.white,
                                            ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
              child: Container(
                child: const Text("LATEST NEWS",style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.green,
                ),
                ),
              ),
            ),

            Container(
              child:ListView.builder(
                  physics:NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:newsModelList.length,
                  itemBuilder:(context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child:Image.network(newsModelList[index].urlToImage
                                  )
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child:Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                    child:Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children:[
                                        Text(newsModelList[index].newsHead,style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.white
                                        ),
                                        ),
                                        const SizedBox(height: 3,),
                                        Text(newsModelList[index].newsDesc.length > 50 ? "${newsModelList[index].newsDesc.substring(0,55)}..." :newsModelList[index].newsDesc ,style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white
                                        ),
                                        ),
                                      ],
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      )
    );
  }
}
