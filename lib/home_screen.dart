import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/Testing.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:news_app/Home/util_function.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {
  Map<String, dynamic> trendingNewsData = {};
  Map<String, dynamic> latestNewsData = {};
  bool isLoadingLtNews = true;
  bool _isLoading = true;
  bool isSaving = false;
  bool _isLoadingsaved = false;
  @override
  void initState() {
    super.initState();
    // loadNews(setState, trendingNewsData);
    _loadNews();
    _loadLatestNews();
  }



  Future<void> _loadLatestNews() async {
    String apiUrl = 'https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&from=2024-02-27&to=2024-02-27&sortBy=popularity&apiKey=35f81e68fa854e4b8f36ed72f667f642';
    try {
       final response  = await http.get(Uri.parse(apiUrl));
       if (response.statusCode == 200) {
         setState(() {
           latestNewsData = json.decode(response.body);
           isLoadingLtNews = false;
         });
       } else {
         // Handle error
         print('Failed to load data. Status code: ${response.statusCode}');
       }
    } catch (e) {
      // Handle network or parsing errors
      print('Error: $e');
    }
  }

  // 35f81e68fa854e4b8f36ed72f667f642---API KEY.

  Future<void> _loadNews() async {
    String apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=35f81e68fa854e4b8f36ed72f667f642';
    // final response = await http.get(Uri.parse(apiUrl));

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // final Map<String, dynamic> data = json.decode(response.body);
        // final List<dynamic> articles = data['articles'];

        setState(() {
          // trendingNewsData = List<Map<String, dynamic>>.from(articles);
          trendingNewsData = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        // Handle error
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or parsing errors
      print('Error: $e');
    }

    // if (response.statusCode == 200) {
    //   // Successful response, parse the data
    //   print('Response data: ${response.body}');
    //   setState(() {
    //     trendingNewsData = json.decode(response.body);
    //   });
    //   print(trendingNewsData['articles'][0]['urlToImage']);
    // } else {
    //   // Handle errors, e.g., show an error message
    //   print('Error: ${response.statusCode}');
    // }
  }


  List<String> categories = [
    'General',
    'Sports',
    'Business',
    'Technology',
    'Transportation',
    'Politics'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading || isLoadingLtNews ? Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Text(
                    'RT News',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Container(
                    height: 5,
                    width: 50,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 58,
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      border: Border.symmetric(
                          vertical: BorderSide.none,
                          horizontal:
                              BorderSide(color: Colors.grey, width: 1))),
                  child: _categoriesList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                _sectionName(
                    name: 'Trending News',
                    textColor: Colors.white,
                    bgColor: Colors.black),
                const SizedBox(
                  height: 10,
                ),
                _trendingNewsSection(context),
                const SizedBox(
                  height: 50,
                ),
                _sectionName(
                    name: 'Lastest News',
                    textColor: Colors.white,
                    bgColor: Colors.black),
                const SizedBox(
                  height: 10,
                ),
                _lastestNewsSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoriesList() {
    var result = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.push(
              '/home/section',
              extra: categories[index],
            );
          },
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey, // Border color
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                categories[index],
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        );
      },
    );
    return result;
  }

  Widget _sectionName(
      {required String name,
      required Color textColor,
      required Color bgColor}) {
    // This if block is suppose check what the name variable is and update the route title and information going to the route
    // if (name == 'trending news') {

    // } else if(name == 'latest news')
    //
    //
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          elevation: 8.0,
          color: bgColor,
          shape: const StadiumBorder(),
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              name,
              style: TextStyle(
                  color: textColor, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            context.push(
              '/home/more',
              extra: {"data": trendingNewsData, "sectionName": name},
            );
          },
          child: const Text(
            'More',
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                decorationColor: Colors.black,
                decoration: TextDecoration.underline,
                decorationThickness: 2.5,
                decorationStyle: TextDecorationStyle.dashed),
          ),
        ),
      ],
    );
  }

  Widget _trendingNewsSection(BuildContext context) {
    var result = Container(
      height: 300,
      child:
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trendingNewsData.isNotEmpty
            ? trendingNewsData['articles'].length
            : 3,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.push(
                '/home/reading',
                extra: {"data": trendingNewsData['articles'][index], "isFromSA": false},
              );
            },
            child: Card(
              color: Colors.blueGrey,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                color: Colors.white54,
                width: 300,
                height: 150.0,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      trendingNewsData.isNotEmpty &&
                              trendingNewsData['articles'][index]
                                      ['urlToImage'] !=
                                  null
                          ? Image.network(
                              trendingNewsData['articles'][index]['urlToImage'],
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Image.asset(
                                    'images/news.jpg'); // Replace with your placeholder image asset path
                              },
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              child: Text(
                                'No Image',
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white54),
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${trendingNewsData.isNotEmpty ? trendingNewsData['articles'][index]['title'].substring(0, 45) : 'Loading'}.....',
                        // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    return result;
  }

  Widget _lastestNewsSection(context) {
    var result = Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: latestNewsData.isNotEmpty ? latestNewsData['articles'].length : 5,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: (){
              context.push(
                '/home/reading',
                extra: {"data": latestNewsData['articles'][index], "isFromSA": false},
              );
            },
            child: Card(
              color: Colors.blueGrey,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                color: Colors.white54,
                width: 300,
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Image.asset(
                      //   'images/news.jpg',
                      //   height: 30,
                      //   width: 100,
                      //   fit: BoxFit.cover,
                      // ),
                      latestNewsData.isNotEmpty &&
                          latestNewsData['articles'][index]
                          ['urlToImage'] !=
                              null
                          ? Image.network(
                            latestNewsData['articles'][index]['urlToImage'],
                            height: 30,
                            width: 100,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Image.asset(
                                  'images/news.jpg'); // Replace with your placeholder image asset path
                            },
                      )
                          : const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                            child: Text(
                              'No Image',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white54),
                            ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          '${latestNewsData.isNotEmpty ? latestNewsData['articles'][index]['title'].substring(0, 25) : 'Loading'}.....',
                          // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    return result;
  }


}




