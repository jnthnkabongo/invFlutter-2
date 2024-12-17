import 'package:flutter/material.dart';

class MyTablePage extends StatefulWidget {
  final String title;
  const MyTablePage({super.key, required this.title});

  @override
  State<MyTablePage> createState() => _MyTablePageState();
}

class _MyTablePageState extends State<MyTablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau Exemple'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Nom')),
              DataColumn(label: Text('Âge')),
              DataColumn(label: Text('Ville')),
              DataColumn(label: Text('Actions')),
            ],
            rows: [
              DataRow(cells: [
                const DataCell(Text('Alice')),
                const DataCell(Text('30')),
                const DataCell(Text('Paris')),
                DataCell(
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          value: 1,
                          child: Text('Option 1'),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text('Option 2'),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      // Gérer la sélection ici
                      print('Option sélectionnée: $value');
                    },
                  ),
                ),
              ]),
              DataRow(cells: [
                const DataCell(Text('Bob')),
                const DataCell(Text('24')),
                const DataCell(Text('Londres')),
                DataCell(
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          value: 1,
                          child: Text('Option 1'),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text('Option 2'),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      print('Option sélectionnée: $value');
                    },
                  ),
                ),
              ]),
              DataRow(cells: [
                const DataCell(Text('Charlie')),
                const DataCell(Text('28')),
                const DataCell(Text('Berlin')),
                DataCell(
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          value: 1,
                          child: Text('Option 1'),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text('Option 2'),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      print('Option sélectionnée: $value');
                    },
                  ),
                ),
              ]),
              // Ajoutez d'autres lignes ici si nécessaire
            ],
          ),
        ),
      ),
      
    );
  }
}