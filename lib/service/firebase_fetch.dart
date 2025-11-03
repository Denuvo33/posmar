import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:posmar/model/children_model.dart';
import 'package:posmar/model/parent_model.dart';

class FirebaseFetch {
  //Parent
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

  Future<void> addParent(ParentModel parent, String key) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$key',
      );
      await ref.update(parent.toJson());
      debugPrint('Data added successfully');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> updateParent(ParentModel parent, String key) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$key',
      );
      await ref.update(parent.toJson());
      debugPrint('Data updated successfully');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> deleteParent(key) async {
    try {
      DatabaseReference db = FirebaseDatabase.instance.ref(
        'parents/${FirebaseAuth.instance.currentUser!.uid}',
      );
      await db.child(key).remove();
    } catch (e) {
      debugPrint('Error $e');
    }
  }

  //Activity

  Future<void> createActivity(
    ChildrenModel children,
    String keyChild,
    String key,
  ) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$key/children/$keyChild/activity/${DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch).toString().replaceAll('.', '').replaceAll(':', '').replaceAll('-', '')}',
      );
      await ref.update(children.toJson());
      debugPrint('Data added successfully');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<List<ChildrenModel>> fetchActivity(
    String keyParent,
    String keyChildren,
  ) async {
    try {
      DatabaseReference db = FirebaseDatabase.instance.ref(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$keyParent/children/$keyChildren/activity',
      );
      DataSnapshot snapshot = await db.get();
      List<ChildrenModel> activityList = [];
      if (snapshot.exists) {
        Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
        data.forEach((key, value) {
          if (value is Map) {
            activityList.add(
              ChildrenModel.fromJson(Map<String, dynamic>.from(value)),
            );
          }
        });
      }
      return activityList;
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  //Children

  Future<List<ChildrenModel>> fetchChildren(key) async {
    DatabaseReference database = FirebaseDatabase.instance.ref();
    List<ChildrenModel> childrenList = [];
    try {
      DataSnapshot snapshot =
          await database
              .child(
                'parents/${FirebaseAuth.instance.currentUser!.uid}/$key/children',
              )
              .get();
      if (snapshot.exists) {
        Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
        data.forEach((key, value) {
          if (value is Map) {
            childrenList.add(
              ChildrenModel.fromJson(Map<String, dynamic>.from(value)),
            );
            debugPrint('Children data: ${value.toString()}');
          }
        });
      } else {
        debugPrint('No data available.');
      }
    } catch (error) {
      debugPrint('Error fetching children data: $error');
      return [];
    }
    return childrenList;
  }

  Future<void> addChildren(
    Map<String, dynamic> children,
    String key,
    String childKey,
  ) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$key/children/$childKey',
      );
      await ref.update(children);
      debugPrint('Data added successfully');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> updateChildren(Map<String, dynamic> children, String key) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$key/children/${children['key']}',
      );
      await ref.update(children);
      debugPrint('Data updated successfully');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> deleteChildren(key, keyChild) async {
    try {
      DatabaseReference db = FirebaseDatabase.instance.ref(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$key/children/$keyChild',
      );
      await db.remove();
    } catch (e) {
      debugPrint('Error $e');
    }
  }
}
