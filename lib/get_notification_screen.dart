import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GetNotification extends StatelessWidget {
  const GetNotification({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_off,
                      size: 50,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                            children: [
                          TextSpan(text: 'Receive '),
                          TextSpan(
                              text: 'silent ',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          TextSpan(text: 'notifications')
                        ])),
                    const Text(
                      'written by our editors',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            content: const Text(
                                'You can change this later in the settings'),
                            action: SnackBarAction(
                              backgroundColor: Colors.white,
                              label: 'Settings',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text(
                          'Maybe later',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          GoRouter.of(context).go('/sign-up');
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.black87,
                            maximumSize: Size.fromWidth(w - 50)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Sounds good',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
