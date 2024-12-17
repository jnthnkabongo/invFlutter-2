import 'package:bboxxlog/pages/accueil_page.dart';
import 'package:bboxxlog/pages/rapport_page.dart';
import 'package:flutter/material.dart';

class ReturnPage extends StatefulWidget {
  final String title;
  const ReturnPage({super.key, required this.title});

  @override
  State<ReturnPage> createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnPage> {
  final pages = [
    const MyTablePage(title:''),
    const AccueilPage(),
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
          NavigationDestination(icon: Icon(Icons.equalizer), label: "Rapport"),
        ],
      ),
    );
  }
}
