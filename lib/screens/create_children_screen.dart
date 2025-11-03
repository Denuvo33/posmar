import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posmar/controller/parent_controller.dart';

class CreateChildrenScreen extends StatefulWidget {
  final String keyDb;
  const CreateChildrenScreen({super.key, required this.keyDb});

  @override
  State<CreateChildrenScreen> createState() => _CreateChildrenScreenState();
}

class _CreateChildrenScreenState extends State<CreateChildrenScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateBornController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  var controller = Get.find<ParentController>();

  @override
  void initState() {
    super.initState();
    _dateBornController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateBornController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateBornController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Balita')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
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
                  decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                  controller: _dateBornController,
                  readOnly: true,
                  onTap: _selectDate,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var key = DateTime.fromMillisecondsSinceEpoch(
                            DateTime.now().millisecondsSinceEpoch,
                          )
                          .toString()
                          .replaceAll('-', '')
                          .replaceAll(':', '')
                          .replaceAll('.', '');
                      await controller.createChildren({
                        'name': _nameController.text,
                        'dateBorn': _selectedDate.toString(),
                        'key': key,
                      }, widget.keyDb);
                    }
                    controller.fetchChildren(widget.keyDb);
                    Get.back();
                  },
                  child: Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
