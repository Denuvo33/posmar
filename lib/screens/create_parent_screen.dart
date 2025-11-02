import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:posmar/controller/parent_controller.dart';
import 'package:posmar/model/parent_model.dart';

class CreateParentScreen extends StatefulWidget {
  const CreateParentScreen({super.key});

  @override
  State<CreateParentScreen> createState() => _CreateParentScreenState();
}

class _CreateParentScreenState extends State<CreateParentScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addessController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ParentController());

  @override
  void dispose() {
    _nameController.dispose();
    _addessController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Orang Tua')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _addessController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor Telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.createData(
                      ParentModel(
                        name: _nameController.text,
                        addres: _addessController.text,
                        phone: _phoneController.text,
                      ),
                    );
                    Get.find<ParentController>().getData();
                    Get.back();
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
