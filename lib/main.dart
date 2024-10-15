import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/data/models/product_model.dart';
import 'package:go_router_demo/pages/home_page.dart';
import 'package:go_router_demo/pages/login_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router_demo/presentation/pages/product_list_page.dart';
import 'package:go_router_demo/presentation/pages/products_page.dart';

void usePathUrlStrategy() {
  setUrlStrategy(PathUrlStrategy());
}

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
        // primaryColor: Colors.deepPurple,
      ),
      // home: const LoginPage(),
    );
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/login",
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        final useSideNavRail = MediaQuery.sizeOf(context).width >= 600;
        return Scaffold(
          primary: true,
          body: Row(
            children: [
              if (useSideNavRail) const Text("side Navigation"),
              Expanded(child: SafeArea(child: navigationShell)),
            ],
          ),
          bottomNavigationBar: useSideNavRail
              ? null
              : BottomNavigationBar(
                  currentIndex: navigationShell.currentIndex,
                  onTap: (int index) => navigationShell.goBranch(index),
                  items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: "Home",
                          backgroundColor: Colors.deepPurple),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_bag),
                          label: "Products",
                          backgroundColor: Colors.blue),
                    ]),
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                name: "/login",
                path: "/login",
                builder: (context, state) => const LoginPage(),
              ),
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: '/',
                builder: (BuildContext context, GoRouterState state) =>
                    const HomePage(),
                // const HomePage(label: 'A', detailsPath: '/a/details'),
                routes: <RouteBase>[
                  // The details screen to display stacked on navigator of the
                  // first tab. This will cover screen A but not the application
                  // shell (bottom navigation bar).
                  GoRoute(
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) =>
                        const HomePage(),
                    //  const HomePage(label: 'A'),
                  ),
                ],
              ),
            ]),
        StatefulShellBranch(
          // It's not necessary to provide a navigatorKey if it isn't also
          // needed elsewhere. If not provided, a default key will be used.
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the second tab of the
              // bottom navigation bar.
              path: '/products',
              builder: (BuildContext context, GoRouterState state) =>
                  const ProductListPage(),
              routes: <RouteBase>[
                GoRoute(
                  path: '/:handle',
                  builder: (BuildContext context, GoRouterState state) {
                    // final product = state.extra as ProductModel;
                    return ProductsPage(
                      handle: state.pathParameters["handle"],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    )
  ],
);

final GoRouter _router2 = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/login",
  redirect: (context, state) {
    // use this to check auth etc
    return null;
  },
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      routes: <RouteBase>[
        GoRoute(
          name: "/home",
          path: "/home",
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: "/login",
          path: "/login",
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          name: "/products",
          path: "/products/:handle",
          builder: (context, state) {
            final productHandle = state.pathParameters["handle"]!;
            return ProductsPage(
              handle: productHandle,
            );
          },
        )
      ],
      builder: (context, state, child) => Scaffold(
        appBar: AppBar(
          title: Text('App Shell'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(child: child),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.deepPurple),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Products",
              backgroundColor: Colors.blue),
        ]),
      ),
    )
  ],
);
