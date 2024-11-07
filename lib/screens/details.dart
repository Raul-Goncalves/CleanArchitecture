import 'package:flutter/material.dart';
import 'package:hyrule/controllers/dao_controller.dart';

import '../domain/models/entry.dart';

class Details extends StatelessWidget {
  Details({super.key, required this.entry});

  final Entry entry;
  final DaoController daoController = DaoController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalhes'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            daoController.saveEntry(entry: entry);
          },
          child: Icon(Icons.favorite),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: <Widget>[
              SizedBox(height: 75),
              Text(
                entry.name,
                style: TextStyle(fontSize: 35),
              ),
              SizedBox(height: 50),
              Container(
                child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(entry.image)),
                ),
              ),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: entry
                    .commonLocationsConverter()
                    .map((e) => Chip(
                          label: Text(e),
                        ))
                    .toList(),
              ),
              SizedBox(height: 50),
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
    );
  }
}
