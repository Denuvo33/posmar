import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:posmar/controller/parent_controller.dart';
import 'package:posmar/model/children_model.dart';

class CreateActivityChildren extends StatefulWidget {
  final Map<String, dynamic> child;
  final String keyParent;
  const CreateActivityChildren({
    super.key,
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

  var controller = Get.find<ParentController>();

  @override
  void dispose() {
    super.dispose();
    _lingkarKepala.dispose();
    _beratBadan.dispose();
    _tinggiBadan.dispose();
    _lingkarLengan.dispose();
    _keterangan.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Aktivitas Balita')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 10,
              children: [
                ListTile(
                  title: Text(widget.child['name']),
                  leading: Icon(Icons.person),
                ),
                TextFormField(
                  controller: _lingkarKepala,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lingkar kepala tidak boleh kosong';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Lingkar Kepala'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Berat badan tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: _beratBadan,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Berat Badan'),
                ),
                TextFormField(
                  controller: _tinggiBadan,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tinggi badan tidak boleh kosong';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Tinggi Badan'),
                ),
                TextFormField(
                  controller: _lingkarLengan,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Lingkar Lengan'),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lingkar lengan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _keterangan,
                  decoration: InputDecoration(
                    labelText: 'Keterangan (Opsional)',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await controller.createActivity(
                        ChildrenModel(
                          name: widget.child['name'],
                          dateBorn: widget.child['dateBorn'],
                          lingkarKepala: _lingkarKepala.text,
                          beratBadan: _beratBadan.text,
                          tinggiBadan: _tinggiBadan.text,
                          lingkarLengan: _lingkarLengan.text,
                          keterangan: _keterangan.text,
                          createdAt: DateTime.now().toString(),
                          key:
                              DateTime.fromMillisecondsSinceEpoch(
                                DateTime.now().millisecondsSinceEpoch,
                              ).toString(),
                        ),
                        widget.keyParent,
                        widget.child['key'],
                      );
                      await controller.fetchActivity(
                        widget.keyParent,
                        widget.child['key'],
                      );
                      Get.back();
                    }
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
