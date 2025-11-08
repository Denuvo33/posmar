import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
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
    }
    return parentList;
  }

  Future<void> addParent(ParentModel parent, String key) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$key',
      );
      await ref.update(parent.toJson());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateParent(ParentModel parent, String key) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$key',
      );
      await ref.update(parent.toJson());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteParent(key) async {
    try {
      DatabaseReference db = FirebaseDatabase.instance.ref(
        'parents/${FirebaseAuth.instance.currentUser!.uid}',
      );
      await db.child(key).remove();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  //Activity

  Future<void> createActivity(
    ChildrenModel children,
    String keyChild,
    String key,
    String keyActivity,
  ) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$key/children/$keyChild/activity/$keyActivity',
      );
      await ref.update(children.toJson());
    } catch (e) {
      Get.snackbar('Error', e.toString());
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
      Get.snackbar('Error', e.toString());
      return [];
    }
  }

  Future<void> updateActivity(
    ChildrenModel children,
    String keyParent,
    String keyChildren,
    String key,
  ) async {
    try {
      DatabaseReference db = FirebaseDatabase.instance.ref(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$keyParent/children/$keyChildren/activity/$key',
      );
      await db.update(children.toJson());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteActivity(keyParent, keyChildren, key) async {
    try {
      DatabaseReference db = FirebaseDatabase.instance.ref(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$keyParent/children/$keyChildren/activity/$key',
      );
      await db.remove();
    } catch (e) {
      Get.snackbar('Error', e.toString());
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
          }
        });
      } else {
        Get.snackbar('Error', 'Tidak ada data.');
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
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
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateChildren(Map<String, dynamic> children, String key) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$key/children/${children['key']}',
      );
      await ref.update(children);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteChildren(key, keyChild) async {
    try {
      DatabaseReference db = FirebaseDatabase.instance.ref(
        'parents/${FirebaseAuth.instance.currentUser!.uid}/$key/children/$keyChild',
      );
      await db.remove();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
