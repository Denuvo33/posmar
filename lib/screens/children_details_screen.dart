import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posmar/controller/parent_controller.dart';
import 'package:posmar/screens/create_activity_children.dart';

class ChildrenDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> child;
  final String keyParent;
  const ChildrenDetailsScreen({
    super.key,
    required this.child,
    required this.keyParent,
  });

  @override
  State<ChildrenDetailsScreen> createState() => _ChildrenDetailsScreenState();
}

class _ChildrenDetailsScreenState extends State<ChildrenDetailsScreen> {
  final controller = Get.put(ParentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchActivity(widget.keyParent, widget.child['key']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Balita')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('child is ${widget.child.toString()}');
          Get.to(
            () => CreateActivityChildren(
              child: widget.child,
              keyParent: widget.keyParent,
            ),
          );
        },
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    ListTile(title: Text(widget.child['name'])),
                    ListTile(
                      title: Text(
                        DateFormat(
                          'dd/MMMM/yyyy',
                        ).format(DateTime.parse(widget.child['dateBorn'])),
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

            Obx(
              () =>
                  controller.activityList.isEmpty
                      ? Center(child: Text('Belum ada aktivitas'))
                      : Expanded(
                        child: ListView.builder(
                          itemCount: controller.activityList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Column(
                                children: [
                                  Text(controller.activityList[index].name),
                                  Text(
                                    DateFormat('dd/MMMM/yyyy HH:mm').format(
                                      DateTime.parse(
                                        controller
                                            .activityList[index]
                                            .createdAt,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    controller
                                        .activityList[index]
                                        .lingkarKepala,
                                  ),
                                  Text(
                                    controller.activityList[index].beratBadan,
                                  ),
                                  Text(
                                    controller.activityList[index].tinggiBadan,
                                  ),
                                  Text(
                                    controller
                                        .activityList[index]
                                        .lingkarLengan,
                                  ),
                                  Text(
                                    controller.activityList[index].keterangan ==
                                            ''
                                        ? '-'
                                        : controller
                                            .activityList[index]
                                            .keterangan,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
