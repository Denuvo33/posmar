import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:posmar/controller/auth_controller.dart';
import 'package:posmar/controller/parent_controller.dart';
import 'package:posmar/screens/about_screen.dart';
import 'package:posmar/screens/create_parent_screen.dart';
import 'package:posmar/screens/login_screens.dart';
import 'package:posmar/screens/parent_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(ParentController());
  final auth = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getData();
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
          'Posmar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.getData(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green[700]),
              accountName: Text(''),
              accountEmail: Text(
                FirebaseAuth.instance.currentUser!.email!.toString(),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  FirebaseAuth.instance.currentUser!.email![0].toUpperCase(),
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ),
            ),
            ListTile(
              title: Text('Tentang'),
              leading: Icon(Icons.info),
              onTap: () {
                Get.back();
                Get.to(() => const AboutScreen());
              },
            ),
            ListTile(
              title: Text('Keluar'),
              leading: Icon(Icons.logout),
              onTap: () {
                Get.offAll(() => LoginScreens());
                auth.logout();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateParentScreen()),
          );
        },
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.green[700]),
                const SizedBox(height: 16),
                const Text('Memuat data...'),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Header Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[700]!, Colors.green[500]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data Orang Tua',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Total: ${controller.parentList.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (value) => controller.setSearch(value),
                decoration: InputDecoration(
                  hintText: 'Cari orang tua...',
                  prefixIcon: Icon(Icons.search, color: Colors.green[700]),

                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.green[700]!, width: 2),
                  ),
                ),
              ),
            ),

            // List Content
            Expanded(
              child:
                  controller.parentList.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.folder_open,
                              size: 100,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Tidak ada data',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tambahkan data orang tua pertama Anda',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateParentScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              icon: const Icon(Icons.add),
                              label: const Text('Tambah Data'),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: controller.filteredList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final parent = controller.filteredList[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () => ParentDetailsScreen(parent: parent),
                                );
                                controller.filteredList.value =
                                    controller.parentList;
                              },

                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green[100],
                                          radius: 25,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.green[700],
                                            size: 28,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                parent.name,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                parent.phone,
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 14,
                                                ),
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
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          itemBuilder:
                                              (context) => [
                                                PopupMenuItem(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.edit,
                                                        color:
                                                            Colors.green[700],
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
                                                        () =>
                                                            CreateParentScreen(
                                                              parent: parent,
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
                                                        title: 'Hapus Data',
                                                        titleStyle:
                                                            const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                        middleText:
                                                            'Apakah Anda yakin ingin menghapus data ini?',
                                                        radius: 12,
                                                        confirm: ElevatedButton(
                                                          onPressed: () async {
                                                            if (controller
                                                                        .filteredList[index]
                                                                        .name ==
                                                                    null ||
                                                                controller
                                                                        .filteredList[index]
                                                                        .name ==
                                                                    '') {
                                                              Get.back();
                                                              Get.snackbar(
                                                                'Gagal',
                                                                'Data tidak valid untuk dihapus,Hubungi admin',
                                                                backgroundColor:
                                                                    Colors.red,
                                                                colorText:
                                                                    Colors
                                                                        .white,
                                                              );
                                                              return;
                                                            }
                                                            await controller
                                                                .deleteData(
                                                                  parent.key,
                                                                );
                                                            controller
                                                                .getData();
                                                            Get.back();
                                                            Get.snackbar(
                                                              'Berhasil',
                                                              'Data berhasil dihapus',
                                                              backgroundColor:
                                                                  Colors.green,
                                                              colorText:
                                                                  Colors.white,
                                                            );
                                                          },
                                                          style:
                                                              ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                foregroundColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                          child: const Text(
                                                            'Hapus',
                                                          ),
                                                        ),
                                                        cancel: TextButton(
                                                          onPressed:
                                                              () => Get.back(),
                                                          child: const Text(
                                                            'Batal',
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        );
      }),
    );
  }
}
