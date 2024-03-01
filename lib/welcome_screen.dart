import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50), child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Container(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome to RioTech News.', style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w800),),
                  const SizedBox(height: 20,),
                  const Text('Thank you for joining the community of RT readers.', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),),
                  const SizedBox(height: 20,),
                  const Text('Thoughtful and focused, RT articles is marked by our award-winning journalism, allowing you to read less and understand more', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),),
                  const SizedBox(height: 5,),
                  Container(height: 5, width: 30, color: Colors.black87,),
                  const SizedBox(height: 20,),
                  const Text('Osita Joshua', style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                  Text('Editor of the Financial Times', style: TextStyle(color: Colors.grey.shade800, fontSize: 14, fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('For more information about how we manage you data, please look at our Privacy policy', style: TextStyle(color: Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.w500),),
                  const SizedBox(height: 20,),
                  TextButton(onPressed: (){
                    GoRouter.of(context).go('/get-notification');
                  }, style: TextButton.styleFrom(
                    backgroundColor: Colors.black87, maximumSize: Size.fromWidth(w - 50)
                  ), child: const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text('Continue', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
                  ))
                ],
              )

          ],
        )),
      ),
    );
  }
}
