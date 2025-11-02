import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posmar/screens/create_activity_children.dart';

class ChildrenDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> child;
  final String keyParent;
  const ChildrenDetailsScreen({
    super.key,
    required this.child,
    required this.keyParent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Balita')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('child is ${child.toString()}');
          Get.to(
            () => CreateActivityChildren(child: child, keyParent: keyParent),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ListTile(title: Text(child['name'])),
                      ListTile(
                        title: Text(
                          DateFormat(
                            'dd/MM/yyyy',
                          ).format(DateTime.parse(child['dateBorn'])),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Aktivitas',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
