import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SavedArticle extends StatefulWidget {
  const SavedArticle({super.key});

  @override
  State<SavedArticle> createState() => _SavedArticleState();
}

class _SavedArticleState extends State<SavedArticle> {
  List<dynamic> dataList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    String apiUrl = 'https://flutternewsdb.onrender.com';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          dataList = json.decode(response.body);
          _isLoading = false;
        });

        print(dataList);
      } else {
        // Handle error
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or parsing errors
      print('Error: $e');
    }
  }

  void _filterDataList (var id) {
    List<dynamic> filteredList = dataList.where((element) => element["_id"] != id).toList();
    setState(() {
      dataList = filteredList;
    });
    print('Done and Dusted!!!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _isLoading  ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ) : RefreshIndicator(
            onRefresh: _loadNews,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: const Text('Saved News', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: Colors.black87),),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                        child: const Text('Pull Down To Refresh, To get Updated List!', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: dataList.isNotEmpty ? dataList.length : 5,
                          itemBuilder: (BuildContext context, index) {
                            return GestureDetector(
                              onTap: (){
                                context.push(
                                  '/home/reading',
                                  extra: {"data": dataList[index],"isFromSA": true, "del": _filterDataList},
                                );
                              },
                              child: Card(
                                color: Colors.blueGrey,
                                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                                child: Container(
                                  color: Colors.white54,
                                  width: 300,
                                  height: 150.0,
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
                                        dataList.isNotEmpty &&
                                            dataList[index]
                                            ['urlToImage'] !=
                                                null
                                            ? Image.network(
                                          dataList[index]['urlToImage'],
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
                                            '${dataList.isNotEmpty ? dataList[index]['title'] : 'Loading'}.....',
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
                      )
                    ]
                    ),
                  )
              ),
            ),
          )
      ),
    );
  }


}