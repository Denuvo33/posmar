import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posmar/controller/parent_controller.dart';
import 'package:posmar/model/parent_model.dart';
import 'package:posmar/screens/children_details_screen.dart';
import 'package:posmar/screens/create_children_screen.dart';

class ParentDetailsScreen extends StatefulWidget {
  final ParentModel parent;
  const ParentDetailsScreen({super.key, required this.parent});

  @override
  State<ParentDetailsScreen> createState() => _ParentDetailsScreenState();
}

class _ParentDetailsScreenState extends State<ParentDetailsScreen> {
  var controller = Get.find<ParentController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchChildren(widget.parent.key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Orang Tua')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateChildrenScreen(keyDb: widget.parent.key));
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          // width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Card(
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(widget.parent.name),
                        leading: Icon(Icons.person),
                      ),
                      ListTile(
                        title: Text(widget.parent.addres),
                        leading: Icon(Icons.location_city),
                      ),
                      ListTile(
                        title: Text(widget.parent.phone),
                        leading: Icon(Icons.phone),
                      ),
                    ],
                  ),
                ),
              ),

              Text(
                'Balita',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Divider(),
              Obx(
                () =>
                    controller.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : controller.childrenList.isEmpty
                        ? Center(
                          child: Column(
                            spacing: 10,
                            children: [
                              Text('Tidak ada data'),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                    () => CreateChildrenScreen(
                                      keyDb: widget.parent.key,
                                    ),
                                  );
                                },
                                child: Text('Tambah Balita'),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.childrenList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap:
                                  () => Get.to(
                                    () => ChildrenDetailsScreen(
                                      child: {
                                        'name':
                                            controller.childrenList[index].name,
                                        'dateBorn':
                                            controller
                                                .childrenList[index]
                                                .dateBorn,
                                        'key':
                                            controller.childrenList[index].key,
                                      },
                                      keyParent: widget.parent.key,
                                    ),
                                  ),
                              child: Card(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Get.to(
                                              () => CreateChildrenScreen(
                                                keyDb: widget.parent.key,
                                                child: {
                                                  'name':
                                                      controller
                                                          .childrenList[index]
                                                          .name,
                                                  'dateBorn':
                                                      controller
                                                          .childrenList[index]
                                                          .dateBorn,
                                                  'key':
                                                      controller
                                                          .childrenList[index]
                                                          .key,
                                                },
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                              title: 'Hapus Balita?',
                                              middleText:
                                                  'Apakah anda yakin ingin menghapus balita ini?',
                                              onConfirm: () async {
                                                controller.deleteChildren(
                                                  widget.parent.key,
                                                  controller
                                                      .childrenList[index]
                                                      .key,
                                                );
                                                controller.fetchChildren(
                                                  widget.parent.key,
                                                );
                                                Get.back();
                                                Get.snackbar(
                                                  'Success',
                                                  'Balita berhasil dihapus',
                                                );
                                              },
                                              onCancel: () {},
                                            );
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.child_care),
                                        SizedBox(width: 8),
                                        Text(
                                          '${controller.childrenList[index].name}',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
