import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/app_pages.dart';
import 'package:food_recipe_final/src/models/app_state_manager.dart';
import 'package:food_recipe_final/src/screens/discover_screen.dart';
import 'package:food_recipe_final/src/screens/search_recipe_screen.dart';
import 'package:food_recipe_final/src/screens/shopping_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: AppPages.home,
      key: ValueKey(AppPages.home),
      child: HomeScreen(
        currentTabIndex: currentTab,
      ),
    );
  }

  const HomeScreen({Key? key, required this.currentTabIndex}) : super(key: key);
  final int currentTabIndex;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<Widget> pages = [
    DiscoverScreen(),
    SearchRecipeScreen(),
    Container(),
    ShoppingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(builder: (context, manager, child) {
      return Scaffold(
        body: IndexedStack(
          index: widget.currentTabIndex,
          children: pages,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              manager.gotToTab(index);
            },
            currentIndex: widget.currentTabIndex,
            type: BottomNavigationBarType.fixed,
            iconSize: 28,
            items: const [
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.house,
                  size: 24,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 24,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.plus,
                  size: 24,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.clipboardList,
                  size: 24,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.solidUser,
                  size: 23,
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
    });
  }
}