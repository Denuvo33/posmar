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
  bool isSortNewest = true; // true = terbaru, false = terlama

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchActivity(widget.keyParent, widget.child['key']);
    });
  }

  List<dynamic> getSortedActivities() {
    final activities = List.from(controller.activityList);
    activities.sort((a, b) {
      final dateA = DateTime.parse(a.createdAt);
      final dateB = DateTime.parse(b.createdAt);
      return isSortNewest ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
    });
    return activities;
  }

  String getMonthYear(String dateString) {
    final date = DateTime.parse(dateString);
    final monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${monthNames[date.month - 1]} ${date.year}';
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
          'Detail Balita',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(
            () => CreateActivityChildren(
              child: widget.child,
              keyParent: widget.keyParent,
            ),
          );
        },
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Aktivitas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Child Info
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
                      Icons.child_care,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.child['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.cake, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat(
                            'dd MMMM yyyy',
                          ).format(DateTime.parse(widget.child['dateBorn'])),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Activity Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Icons.assessment,
                              color: Colors.green[700],
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Riwayat Aktivitas',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      // Sort Button
                      Obx(() {
                        if (controller.activityList.isNotEmpty) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.green[200]!,
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  setState(() {
                                    isSortNewest = !isSortNewest;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        isSortNewest
                                            ? Icons.arrow_downward
                                            : Icons.arrow_upward,
                                        size: 18,
                                        color: Colors.green[700],
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        isSortNewest ? 'Terbaru' : 'Terlama',
                                        style: TextStyle(
                                          color: Colors.green[700],
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }),
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
                              const Text('Memuat data aktivitas...'),
                            ],
                          ),
                        ),
                      );
                    }

                    if (controller.activityList.isEmpty) {
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
                                'Belum ada aktivitas',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tambahkan aktivitas untuk memulai',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Get.to(
                                    () => CreateActivityChildren(
                                      child: widget.child,
                                      keyParent: widget.keyParent,
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
                                label: const Text('Tambah Aktivitas'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final sortedActivities = getSortedActivities();
                    String? currentMonthYear;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sortedActivities.length,
                      itemBuilder: (BuildContext context, int index) {
                        final activity = sortedActivities[index];
                        final activityMonthYear = getMonthYear(
                          activity.createdAt,
                        );

                        // Check if we need to show month divider
                        bool showMonthDivider = false;
                        if (currentMonthYear != activityMonthYear) {
                          showMonthDivider = true;
                          currentMonthYear = activityMonthYear;
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Month Divider
                            if (showMonthDivider) ...[
                              if (index > 0) const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green[600]!,
                                      Colors.green[400]!,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.withValues(
                                        alpha: 0.2,
                                      ),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      activityMonthYear,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            // Activity Card
                            Card(
                              elevation: 2,
                              margin: const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header with date and actions
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 16,
                                              color: Colors.green[700],
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              DateFormat(
                                                'dd MMM yyyy, HH:mm',
                                              ).format(
                                                DateTime.parse(
                                                  activity.createdAt,
                                                ),
                                              ),
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
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
                                                    debugPrint(
                                                      'Activity to edit: ${activity.key}',
                                                    );
                                                    Future.delayed(
                                                      Duration.zero,
                                                      () => Get.to(
                                                        () =>
                                                            CreateActivityChildren(
                                                              child:
                                                                  widget.child,
                                                              keyParent:
                                                                  widget
                                                                      .keyParent,
                                                              activity:
                                                                  activity,
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
                                                        title:
                                                            'Hapus Aktivitas?',
                                                        titleStyle:
                                                            const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                        middleText:
                                                            'Apakah Anda yakin ingin menghapus aktivitas ini?',
                                                        radius: 12,
                                                        confirm: ElevatedButton(
                                                          onPressed: () async {
                                                            await controller
                                                                .deleteActivity(
                                                                  widget
                                                                      .keyParent,
                                                                  widget
                                                                      .child['key'],
                                                                  activity.key,
                                                                );
                                                            await controller
                                                                .fetchActivity(
                                                                  widget
                                                                      .keyParent,
                                                                  widget
                                                                      .child['key'],
                                                                );
                                                            Get.back();
                                                            Get.snackbar(
                                                              'Berhasil',
                                                              'Aktivitas berhasil dihapus',
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
                                    const Divider(),
                                    const SizedBox(height: 8),

                                    // Measurements Grid
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildMeasurementCard(
                                            icon: Icons.accessibility_new,
                                            label: 'Berat Badan',
                                            value: '${activity.beratBadan} kg',
                                            color: Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: _buildMeasurementCard(
                                            icon: Icons.height,
                                            label: 'Tinggi Badan',
                                            value: '${activity.tinggiBadan} cm',
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildMeasurementCard(
                                            icon: Icons.face,
                                            label: 'Lingkar Kepala',
                                            value:
                                                '${activity.lingkarKepala} cm',
                                            color: Colors.purple,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: _buildMeasurementCard(
                                            icon: Icons.back_hand,
                                            label: 'Lingkar Lengan',
                                            value:
                                                '${activity.lingkarLengan} cm',
                                            color: Colors.teal,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Keterangan
                                    if (activity.keterangan.isNotEmpty) ...[
                                      const SizedBox(height: 12),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.note,
                                                  size: 16,
                                                  color: Colors.grey[700],
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  'Keterangan:',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey[700],
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              activity.keterangan,
                                              style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
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

  Widget _buildMeasurementCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
