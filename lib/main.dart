import 'package:flutter/material.dart';
import 'package:news_app/LoginPage.dart';
import 'package:news_app/SignUpPage.dart';
import 'package:news_app/Testing.dart';
import 'package:news_app/app_router/scaffold_with_navbar.dart';
import 'package:news_app/get_notification_screen.dart';
import 'package:news_app/home_screen.dart';
import 'package:news_app/more.dart';
import 'package:news_app/reading_screen.dart';
import 'package:news_app/saved_article_screen.dart';
import 'package:news_app/section_news.dart';
import 'package:news_app/settings_screen.dart';
import 'package:news_app/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      // home: SplashScreen(),
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
      initialLocation: '/splashscreen',
      routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomePage(),
                routes: <RouteBase>[
                  // The details screen to display stacked on navigator of the
                  // first tab. This will cover screen A but not the application
                  // shell (bottom navigation bar).
                  // GoRoute(
                  //   path: 'reading',
                  //   builder: (BuildContext context, GoRouterState state) =>
                  //       const ReadingScreen(),
                  // ),
                  GoRoute(
                    path: 'reading',
                    builder: (BuildContext context, GoRouterState state)  {
                             Map data = state.extra as Map;
                             return ReadingScreen(data : data['data'], isFromSA: data['isFromSA'], del: data['del'],);
                           }
                  ),
                  GoRoute(
                    path: 'more',
                    builder: (context, state) {
                      Map data = state.extra as Map;
                      return More(data: data['data'],sectionName: data['sectionName']);
                    },
                  ),
                  GoRoute(
                    path: 'section',
                    builder: (context, state) {
                      String data = state.extra as String;
                      return SectionNews(section: data,);
                    },
                  ),
                ],
                // builder: (context, state) =>  MyHorizontalListView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/savedArticle',
                builder: (context, state) => const SavedArticle(),

                // builder: (context, state) =>  MyHorizontalListView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/settings',
                builder: (context, state) => const Settings(),
                // builder: (context, state) =>  MyHorizontalListView(),
              ),
            ],
          ),
        ]),
    // GoRoute(
    //   path: '/home',
    //   builder: (context, state) => const HomePage(),
    //   // builder: (context, state) =>  MyHorizontalListView(),
    // ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/splashscreen',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/get-notification',
      builder: (context, state) => const GetNotification(),
    ),
    GoRoute(
      path: '/log-in',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const SignUpPage(),

    ),
  ]);
}
