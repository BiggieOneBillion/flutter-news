import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ReadingScreen extends StatefulWidget {
  final Map data;
  final bool isFromSA;
  final Function? del;
  const ReadingScreen({super.key, required this.data, required this.isFromSA, this.del});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {

  bool _isLoadingsaved = false;
  bool isSaving = false;
  String prompt = '';

  

  Future <void> makePostRequest() async {
     setState(() {
       prompt = 'checking..';
     });
    try{
      // checking to see if entry exist in db first
      final getInfoFromDB = await http.get(Uri.parse('https://flutternewsdb.onrender.com'));

      if(getInfoFromDB.statusCode == 200 && !(json.decode(getInfoFromDB.body).isEmpty)){
        List<dynamic> dataList = json.decode(getInfoFromDB.body);
        // checks if the data to be saved is already saved or not
        // if it is not then it the runs the code block inside the if statement.
        // if it is saved then the process would stop and the user would get a message that it has been saved previously
         if(!(dataList.any((element) => element['title'] == widget.data['title'] && element['author'] == widget.data['author']))){
           setState(() {
             prompt = 'saving..';
           });
           Map<String, dynamic> news = {
             "author": widget.data['author'],
             "title": widget.data['title'],
             "description": widget.data['description'],
             "url": widget.data['url'],
             "urlToImage": widget.data['urlToImage'],
             "publishedAt": widget.data['publishedAt'],
             "content": widget.data['content'],
           };

           setState(() {
             _isLoadingsaved = true;
           });

           final url = Uri.parse('https://flutternewsdb.onrender.com');
           final headers = {'Content-Type': 'application/json'};
           final body = jsonEncode(news);

           final response = await http.post(url, headers: headers, body: body);

           if (response.statusCode == 201) {
             setState(() {
               isSaving = true;
               prompt = 'saved';
             });
             // Request successful, print response body
             print('Response body: ${response.body}');

           } else {
             setState(() {
               prompt = 'Try Again!';
               _isLoadingsaved = false;
             });
             // Request failed with an error status code, print error message
             print('Request failed with status: ${response.statusCode}');
           }
         }
         else {
           setState(() {
             prompt = 'Already Saved';
             _isLoadingsaved = true;
           });
         }
      }
    } catch (e){
      setState(() {
        _isLoadingsaved = false;
        prompt = 'Try Again!';
      });
      print('Request failed with status: ${e}');
    }
  }

  Future <void> deletePostRequest() async {
    setState(() {
      prompt = 'Deleting...';
    });
    try {
      final response = await http.delete(Uri.parse('https://flutternewsdb.onrender.com/${widget.data['_id']}'));
      if(response.statusCode == 200) {
         setState(() {
           prompt = 'Deleted';
         });
      }
     widget.del!(widget.data["_id"]);
    } catch (e){
      setState(() {
        prompt = 'Try Again';
      });
      print('Request failed with status: ${e}');
    }
  }


  @override
  Widget build(BuildContext context) {
    print(widget.isFromSA);

    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              //  GoRouter.of(context).go('/home');
              Navigator.of(context).pop();
             },
            child: const Icon(Icons.arrow_back, size: 24, color: Colors.black45,)),
        actions: [
          widget.isFromSA ?
          GestureDetector(
              onTap:(){
                deletePostRequest();
                Future.delayed(const Duration(seconds: 2), (){
                  Navigator.of(context).pop();
                });

              },
              child: const Icon(Icons.delete, size: 25,color: Colors.black87,)
          ) :
          GestureDetector(
              onTap: _isLoadingsaved ? null : (){
                makePostRequest();
              },
              child: Icon(Icons.save, size: 25,color: isSaving ? Colors.grey : Colors.black87,)
          ),
           Text(
            prompt,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87
            ),
          ),
          const SizedBox(width: 10,)
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
          child:  Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 70),
            color: Colors.grey.shade100,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network('${widget.data['urlToImage']}', height: 300, width: w, fit: BoxFit.cover,),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${widget.data['title']}',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                '${widget.data['content']}',
                // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
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
  }
}
