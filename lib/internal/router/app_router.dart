import 'package:auto_route/auto_route.dart';
import 'package:secur/ui/home/home_page.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
  ],
)
// extend the generated private router
class $AppRouter {}
