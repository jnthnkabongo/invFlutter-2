import 'package:bboxxlog/pages/accueil_page.dart';
import 'package:bboxxlog/pages/parametres_page.dart';
import 'package:bboxxlog/pages/rapport_page.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  final String title;
  const MenuPage({super.key, required this.title});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final pages = [
    const AccueilPage(),
    const ParametresPage(title: ''),
    const MyTablePage(title: ''),
  ];

  int pagesIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pagesIndex],
       bottomNavigationBar: NavigationBar(
        selectedIndex: pagesIndex,
        onDestinationSelected: (int index){
          setState(() {
            pagesIndex = index;
            
          });
        },
        backgroundColor: Colors.white,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Accueil"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Paramètres"),
        ],
      ),
    );
  }
}
