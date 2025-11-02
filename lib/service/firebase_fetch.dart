import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:posmar/model/parent_model.dart';

class FirebaseFetch {
  Future<List<ParentModel>> fetchParent() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('parents');
    DataSnapshot snapshot =
        await ref.child(FirebaseAuth.instance.currentUser!.uid).get();
    List<ParentModel> parentList = [];
    if (snapshot.exists) {
      Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;

      data.forEach((key, value) {
        if (value is Map) {
          parentList.add(
            ParentModel.fromJson(Map<String, dynamic>.from(value)),
          );
        }
      });
      ;
    }
    return parentList;
  }

  Future<void> addParent(ParentModel parent) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/${DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch).toString().replaceAll('-', '').replaceAll(':', '').replaceAll('.', '')}',
      );
      await ref.update(parent.toJson());
      debugPrint('Data added successfully');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
