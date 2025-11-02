import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:posmar/controller/parent_controller.dart';
import 'package:posmar/screens/create_parent_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ParentController());
    return Scaffold(
      appBar: AppBar(),
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
            children: [
              SearchBar(),
              controller.isLoading.value
                  ? CircularProgressIndicator()
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
                          onTap: Get.offAll(() => CreateParentScreen()),

                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(7),
                              child: Text(controller.parentList[index].name),
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
