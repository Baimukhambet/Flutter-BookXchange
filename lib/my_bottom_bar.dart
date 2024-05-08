import 'package:cubit_test/features/home/home_screen.dart';
import 'package:cubit_test/features/profile/profile_screen.dart';
import 'package:cubit_test/repositories/providers/tab_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyBottomBar extends StatelessWidget {
  MyBottomBar({super.key});

  final List<Widget> _screens = [HomeScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManagerProvider>(
      builder: (context, tabs, child) => Scaffold(
          extendBody: true,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: CircleBorder(),
            onPressed: () {
              context.push('/order');
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            elevation: 4,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            notchMargin: 10,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.menu_book_sharp,
                    color:
                        (tabs.currentIndex == 0) ? Colors.black : Colors.grey,
                  ),
                  onPressed: () {
                    tabs.changeTab(0);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color:
                        (tabs.currentIndex == 1) ? Colors.black : Colors.grey,
                  ),
                  onPressed: () {
                    tabs.changeTab(1);
                  },
                ),
              ],
            ),
          ),
          body: _screens[tabs.currentIndex]),
    );
  }
}
