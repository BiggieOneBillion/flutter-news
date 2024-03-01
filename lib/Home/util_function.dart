import 'package:http/http.dart' as http;
import 'dart:convert';



void loadNews(setState, trendingNewsData) async {
    String apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=35f81e68fa854e4b8f36ed72f667f642';
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

// _showDetailedScreen(context, Map info, Function updateState) {
//   showGeneralDialog(
//       context: context,
//       barrierDismissible:
//       true, // should dialog be dismissed when tapped outside
//       barrierLabel: "Modal", // label for barrier
//       transitionDuration: const Duration(milliseconds: 500),
//       pageBuilder: (context, __, ___) {
//         return Scaffold(
//           appBar: AppBar(
//             leading: GestureDetector(
//                 onTap: () {
//                   //  GoRouter.of(context).go('/home');
//                   Navigator.of(context).pop();
//                 },
//                 child: const Icon(
//                   Icons.arrow_back,
//                   size: 24,
//                   color: Colors.black45,
//                 )),
//             actions: [
//               GestureDetector(
//                   onTap: _isLoadingsaved ? null : (){
//                     // makePostRequest('http://localhost:5050',info );
//                     updateState();
//                     // print('clicked twice');
//                   },
//                   child: Icon(Icons.save, size: 25,color: isSaving ? Colors.grey : Colors.black87,)
//               ),
//               _isLoadingsaved ?
//               const Text(
//                 'Loading...',
//                 style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black26
//                 ),
//               )
//                   :
//               const SizedBox(width: 0,),
//               const SizedBox(width: 10,)
//             ],
//             backgroundColor: Colors.white,
//             elevation: 0,
//           ),
//           body: SafeArea(
//               child: SingleChildScrollView(
//                 child: Container(
//                   height: MediaQuery.of(context).size.height,
//                   padding: const EdgeInsets.fromLTRB(20, 50, 20, 70),
//                   color: Colors.grey.shade100,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.network(
//                         info['urlToImage'],
//                         height: 300,
//                         width: MediaQuery.of(context).size.width,
//                         fit: BoxFit.cover,
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         info['title'],
//                         style: const TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black87),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       Text(
//                         // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
//                         info['description'] != null && info['content'] != null
//                             ? '${info['description']} ${info['content']}'
//                             : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
//                         style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black54),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//         );
//       });
// }

// Future <void> makePostRequest(String uri, Map info) async {
//
//   Map<String, dynamic> news = {
//     "author": info['author'],
//     "title": info['title'],
//     "description": info['description'],
//     "url": info['url'],
//     "urlToImage": info['urlToImage'],
//     "publishedAt": info['publishedAt'],
//     "content": info['content'],
//   };
//
//   setState(() {
//    _isLoadingsaved = true;
//   });
//
//   print(_isLoadingsaved);
//
//   final url = Uri.parse('https://flutternewsdb.onrender.com');
//   final headers = {'Content-Type': 'application/json'};
//   final body = jsonEncode(news);
//
//   // final response = await http.post(url, headers: headers, body: body);
//
//   // if (response.statusCode == 201) {
//   //   setState(() {
//   //     isSaving = true;
//   //   });
//   //   // Request successful, print response body
//   //   print('Response body: ${response.body}');
//   //
//   // } else {
//   //   // Request failed with an error status code, print error message
//   //   print('Request failed with status: ${response.statusCode}');
//   // }
// }