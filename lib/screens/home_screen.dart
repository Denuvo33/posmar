import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:posmar/controller/parent_controller.dart';
import 'package:posmar/screens/create_parent_screen.dart';
import 'package:posmar/screens/parent_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ParentController());
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(title: const Text('Item 1'), onTap: () => {}),
            ListTile(title: const Text('Item 2'), onTap: () => {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateParentScreen()),
          );
        },
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(),
              Text('Total Data Orang Tua: ${controller.parentList.length}'),
              controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : controller.parentList.isEmpty
                  ? Center(
                    child: Column(
                      children: [
                        Text('Tidak ada data'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateParentScreen(),
                              ),
                            );
                          },
                          child: Text('Tambah Data'),
                        ),
                      ],
                    ),
                  )
                  : Expanded(
                    child: ListView.builder(
                      itemCount: controller.parentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap:
                              () => Get.to(
                                () => ParentDetailsScreen(
                                  parent: controller.parentList[index],
                                ),
                              ),

                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.to(
                                            () => CreateParentScreen(
                                              parent:
                                                  controller.parentList[index],
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: 'Hapus Data',
                                            middleText: 'Apakah anda yakin?',
                                            onConfirm: () async {
                                              await controller.deleteData(
                                                controller
                                                    .parentList[index]
                                                    .key,
                                              );
                                              controller.getData();
                                              Get.back();
                                            },
                                            onCancel: () {},
                                          );
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                  Text(controller.parentList[index].name),
                                ],
                              ),
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
