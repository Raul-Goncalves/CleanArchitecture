import 'package:flutter/material.dart';
import 'package:hyrule/controllers/dao_controller.dart';
import 'package:hyrule/domain/models/entry.dart';
import 'package:hyrule/screens/details.dart';

class EntryCard extends StatelessWidget {
  EntryCard({Key? key, required this.entry, required this.isSaved})
      : super(key: key);

  final Entry entry;
  final bool isSaved;

  final DaoController daoController = DaoController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Dismissible(
        key: ValueKey<int>(entry.id),
        direction: isSaved ? DismissDirection.endToStart : DismissDirection.none,
        onDismissed: (direction) {
          daoController.deleteEntry(entry: entry);
        },
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Details(entry: entry)),
                );
              },
              child: Ink(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                entry.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                entry.description,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8), // Arredonda a imagem
                        child: Image.network(
                          entry.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: entry
                        .commonLocationsConverter()
                        .map((e) => Chip(
                      label: Text(e),
                    ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
