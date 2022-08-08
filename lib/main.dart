import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_recipe_final/core/app_theme.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/firebase_options.dart';
import 'package:food_recipe_final/src/data/bookmark_interface.dart';
import 'package:food_recipe_final/src/providers/bookmark_manager.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:food_recipe_final/src/providers/shopping_manager.dart';
import 'package:food_recipe_final/src/navigation/app_router.dart';
import 'package:food_recipe_final/src/providers/user_image_provider.dart';
import 'package:food_recipe_final/src/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  GoogleFonts.config.allowRuntimeFetching = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    // SystemChrome.setSystemUIOverlayStyle(
    // const SystemUiOverlayStyle(
    //   systemNavigationBarColor: kBlackColor2,
    // ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appStateManager = AppStateManager();
  final _shoppingManager = ShoppingManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      shoppingManager: _shoppingManager,
    );
  }

  ThemeData theme = AppTheme.dark();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          lazy: false,
          create: (context) => UserProvider(),
        ),
        Provider<UserImageProvider>(
          lazy: false,
          create: (context) => UserImageProvider(),
        ),
        Provider<BookmarkInterface>(
          lazy: false,
          create: (context) => BookmarkManager(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => _shoppingManager,
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => _appStateManager,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: Router(
          routerDelegate: _appRouter,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
