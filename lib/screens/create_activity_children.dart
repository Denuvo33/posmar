import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posmar/controller/parent_controller.dart';
import 'package:posmar/model/children_model.dart';

class CreateActivityChildren extends StatefulWidget {
  final Map<String, dynamic> child;
  final String keyParent;
  final ChildrenModel? activity;
  const CreateActivityChildren({
    super.key,
    this.activity,
    required this.child,
    required this.keyParent,
  });

  @override
  State<CreateActivityChildren> createState() => _CreateActivityChildrenState();
}

class _CreateActivityChildrenState extends State<CreateActivityChildren> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _lingkarKepala = TextEditingController();
  final TextEditingController _beratBadan = TextEditingController();
  final TextEditingController _tinggiBadan = TextEditingController();
  final TextEditingController _lingkarLengan = TextEditingController();
  final TextEditingController _keterangan = TextEditingController();
  final TextEditingController _dateAActivityController =
      TextEditingController();

  var selectedDate = DateTime.now();

  var controller = Get.find<ParentController>();
  bool _isLoading = false;

  @override
  void dispose() {
    _lingkarKepala.dispose();
    _beratBadan.dispose();
    _tinggiBadan.dispose();
    _lingkarLengan.dispose();
    _keterangan.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dateAActivityController.text = DateFormat(
      'dd-MMMM-yyyy',
    ).format(selectedDate);
    if (widget.activity != null) {
      _lingkarKepala.text = widget.activity!.lingkarKepala.toString();
      _beratBadan.text = widget.activity!.beratBadan.toString();
      _tinggiBadan.text = widget.activity!.tinggiBadan.toString();
      _lingkarLengan.text = widget.activity!.lingkarLengan.toString();
      _keterangan.text = widget.activity!.keterangan.toString();
      selectedDate = DateTime.parse(widget.activity!.createdAt);
      _dateAActivityController.text = DateFormat(
        'dd-MMMM-yyyy',
      ).format(selectedDate);
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green[700]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateAActivityController.text = DateFormat(
          'dd-MMMM-yyyy',
        ).format(picked);
      });
      debugPrint('date activity: ${selectedDate.toString()}');
    }
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      if (widget.activity != null) {
        await controller.updateActivity(
          ChildrenModel(
            name: widget.child['name'],
            dateBorn: widget.child['dateBorn'],
            lingkarKepala: _lingkarKepala.text,
            beratBadan: _beratBadan.text,
            tinggiBadan: _tinggiBadan.text,
            lingkarLengan: _lingkarLengan.text,
            keterangan: _keterangan.text,
            createdAt:
                widget.activity!.createdAt != selectedDate.toString()
                    ? selectedDate.toString()
                    : widget.activity!.createdAt,
            key: widget.activity!.key,
          ),
          widget.keyParent,
          widget.child['key'],
          widget.activity!.key,
        );
      } else {
        var key = DateTime.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch,
            )
            .toString()
            .replaceAll('.', '')
            .replaceAll(':', '')
            .replaceAll('-', '');
        await controller.createActivity(
          ChildrenModel(
            name: widget.child['name'],
            dateBorn: widget.child['dateBorn'],
            lingkarKepala: _lingkarKepala.text,
            beratBadan: _beratBadan.text,
            tinggiBadan: _tinggiBadan.text,
            lingkarLengan: _lingkarLengan.text,
            keterangan: _keterangan.text,
            createdAt: selectedDate.toString(),
            key: key,
          ),
          widget.keyParent,
          widget.child['key'],
          key,
        );
        debugPrint('create activity date: $selectedDate');
      }

      await controller.fetchActivity(widget.keyParent, widget.child['key']);
      Get.back();
      Get.snackbar(
        'Berhasil',
        widget.activity == null
            ? 'Aktivitas berhasil ditambahkan'
            : 'Aktivitas berhasil diupdate',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.activity != null;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        title: Text(
          isEdit ? 'Edit Aktivitas Balita' : 'Tambah Aktivitas Balita',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Design
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
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    child: Icon(
                      isEdit ? Icons.edit : Icons.assessment,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.child['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isEdit
                        ? 'Ubah Data Aktivitas'
                        : 'Tambahkan Data Aktivitas Baru',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _dateAActivityController,
                      readOnly: true,
                      onTap: _selectDate,
                      decoration: InputDecoration(
                        labelText: 'Tanggal Aktivitas',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    // Berat Badan
                    _buildTextField(
                      controller: _beratBadan,
                      label: 'Berat Badan',
                      hint: 'Masukkan berat badan (kg)',
                      icon: Icons.accessibility_new,
                      suffixText: 'kg',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Berat badan tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Tinggi Badan
                    _buildTextField(
                      controller: _tinggiBadan,
                      label: 'Tinggi Badan',
                      hint: 'Masukkan tinggi badan (cm)',
                      icon: Icons.height,
                      suffixText: 'cm',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tinggi badan tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Lingkar Kepala
                    _buildTextField(
                      controller: _lingkarKepala,
                      label: 'Lingkar Kepala',
                      hint: 'Masukkan lingkar kepala (cm)',
                      icon: Icons.face,
                      suffixText: 'cm',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lingkar kepala tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Lingkar Lengan
                    _buildTextField(
                      controller: _lingkarLengan,
                      label: 'Lingkar Lengan',
                      hint: 'Masukkan lingkar lengan (cm)',
                      icon: Icons.back_hand,
                      suffixText: 'cm',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lingkar lengan tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Keterangan
                    _buildTextField(
                      controller: _keterangan,
                      label: 'Keterangan (Opsional)',
                      hint: 'Masukkan keterangan tambahan',
                      icon: Icons.note,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 30),

                    // Save Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _saveData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child:
                          _isLoading
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.save),
                                  const SizedBox(width: 8),
                                  Text(
                                    isEdit ? 'Update Data' : 'Simpan Data',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                    ),

                    const SizedBox(height: 10),

                    // Cancel Button
                    TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Batal',
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? suffixText,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType:
              maxLines == 1 ? TextInputType.number : TextInputType.text,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.green[700]),
            suffixText: suffixText,
            suffixStyle: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green[700]!, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
