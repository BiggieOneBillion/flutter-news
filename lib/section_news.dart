import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SectionNews extends StatefulWidget {
  final String section;
  const SectionNews({required this.section, super.key});

  @override
  State<SectionNews> createState() => _SectionNewsState();
}

class _SectionNewsState extends State<SectionNews> {
  Map<String, dynamic> trendingNewsData = {};
  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  // 35f81e68fa854e4b8f36ed72f667f642---API KEY.

  void _loadNews() async {
    String apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&category=${widget.section}&apiKey=35f81e68fa854e4b8f36ed72f667f642';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Successful response, parse the data
      print('Response data: ${response.body}');
      setState(() {
        trendingNewsData = json.decode(response.body);
      });
      print(trendingNewsData['articles'][0]['urlToImage']);
    } else {
      // Handle errors, e.g., show an error message
      print('Error: ${response.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              //  GoRouter.of(context).go('/home');
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.black45,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Card(
                elevation: 8.0,
                color: Colors.black87,
                // shape: const StadiumBorder(),
                margin:
                    const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    '${widget.section} News',
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(child: _trendingNewsSection(trendingNewsData)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trendingNewsSection(info) {
    var result = ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: info.isNotEmpty ? info['articles'].length : 1,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // GoRouter.of(context).go('/home/reading');
            _showDetailedScreen(context, info['articles'][index]);
          },
          child: Card(
            color: Colors.blueGrey,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              color: Colors.white54,
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    info.isNotEmpty &&
                            info['articles'][index]['urlToImage'] != null
                        ? Image.network(
                            info['articles'][index]['urlToImage'],
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
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
                      '${info.isNotEmpty ? info['articles'][index]['title'].substring(0, 45) : 'Loading'}.....',
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
    );
    return result;
  }

  _showDetailedScreen(context, Map info) {
    showGeneralDialog(
        context: context,
        barrierDismissible:
            true, // should dialog be dismissed when tapped outside
        barrierLabel: "Modal", // label for barrier
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, __, ___) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    //  GoRouter.of(context).go('/home');
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.black45,
                  )),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 70),
                color: Colors.grey.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      info['urlToImage'],
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      info['title'],
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                      info['description'] != null && info['content'] != null
                          ? '${info['description']} ${info['content']}'
                          : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
            )),
          );
        });
  }
}
