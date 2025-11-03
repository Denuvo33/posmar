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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        title: const Text(
          'Detail Orang Tua',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => CreateChildrenScreen(keyDb: widget.parent.key));
        },
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Balita'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Parent Info
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[700]!, Colors.green[500]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.parent.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          icon: Icons.location_on,
                          text: widget.parent.addres,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: Icons.phone,
                          text: widget.parent.phone,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Children Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.child_care,
                          color: Colors.green[700],
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Daftar Balita',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              CircularProgressIndicator(
                                color: Colors.green[700],
                              ),
                              const SizedBox(height: 16),
                              const Text('Memuat data balita...'),
                            ],
                          ),
                        ),
                      );
                    }

                    if (controller.childrenList.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              Icon(
                                Icons.inbox_outlined,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Belum ada data balita',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tambahkan balita untuk memulai',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Get.to(
                                    () => CreateChildrenScreen(
                                      keyDb: widget.parent.key,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[700],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(Icons.add),
                                label: const Text('Tambah Balita'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.childrenList.length,
                      itemBuilder: (context, index) {
                        final child = controller.childrenList[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: InkWell(
                            onTap:
                                () => Get.to(
                                  () => ChildrenDetailsScreen(
                                    child: {
                                      'name': child.name,
                                      'dateBorn': child.dateBorn,
                                      'key': child.key,
                                    },
                                    keyParent: widget.parent.key,
                                  ),
                                ),
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.green[100],
                                    radius: 25,
                                    child: Icon(
                                      Icons.child_care,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          child.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.cake,
                                              size: 16,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              child.dateBorn,
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.grey[600],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    itemBuilder:
                                        (context) => [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.green[700],
                                                  size: 20,
                                                ),
                                                const SizedBox(width: 12),
                                                const Text('Edit'),
                                              ],
                                            ),
                                            onTap: () {
                                              Future.delayed(
                                                Duration.zero,
                                                () => Get.to(
                                                  () => CreateChildrenScreen(
                                                    keyDb: widget.parent.key,
                                                    child: {
                                                      'name': child.name,
                                                      'dateBorn':
                                                          child.dateBorn,
                                                      'key': child.key,
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 12),
                                                Text('Hapus'),
                                              ],
                                            ),
                                            onTap: () {
                                              Future.delayed(
                                                Duration.zero,
                                                () => Get.defaultDialog(
                                                  title: 'Hapus Balita?',
                                                  titleStyle: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  middleText:
                                                      'Apakah Anda yakin ingin menghapus balita ini?',
                                                  radius: 12,
                                                  confirm: ElevatedButton(
                                                    onPressed: () async {
                                                      await controller
                                                          .deleteChildren(
                                                            widget.parent.key,
                                                            child.key,
                                                          );
                                                      controller.fetchChildren(
                                                        widget.parent.key,
                                                      );
                                                      Get.back();
                                                      Get.snackbar(
                                                        'Berhasil',
                                                        'Balita berhasil dihapus',
                                                        backgroundColor:
                                                            Colors.green,
                                                        colorText: Colors.white,
                                                      );
                                                    },
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                          foregroundColor:
                                                              Colors.white,
                                                        ),
                                                    child: const Text('Hapus'),
                                                  ),
                                                  cancel: TextButton(
                                                    onPressed: () => Get.back(),
                                                    child: const Text('Batal'),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
