import 'package:get/get.dart';
import 'package:posmar/model/children_model.dart';
import 'package:posmar/model/parent_model.dart';
import 'package:posmar/service/firebase_fetch.dart';

class ParentController extends GetxController {
  var parentList = <ParentModel>[].obs;
  var childrenList = <ChildrenModel>[].obs;
  var activityList = <ChildrenModel>[].obs;
  var isLoading = true.obs;
  final service = FirebaseFetch();
  var searchQuery = ''.obs;
  var filteredList = <ParentModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() {
    isLoading(true);
    service.fetchParent().then((value) {
      parentList.value = value;
      filteredList.value = value;
      isLoading(false);
    });
  }

  void setSearch(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredList.value = parentList;
    } else {
      filteredList.value =
          parentList
              .where(
                (parent) =>
                    parent.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
  }

  void fetchChildren(String key) {
    isLoading(true);
    service.fetchChildren(key).then((value) {
      childrenList.value = value;
      isLoading(false);
    });
  }

  Future<void> createChildren(Map<String, dynamic> children, String key) async {
    await service.addChildren(children, key, children['key']);
  }

  Future<void> updateChildren(Map<String, dynamic> children, String key) async {
    await service.updateChildren(children, key);
  }

  Future<void> deleteChildren(String key, String keyChild) async {
    await service.deleteChildren(key, keyChild);
  }

  Future<void> createActivity(
    ChildrenModel children,
    String key,
    String keyChild,
    String keyActivity,
  ) async {
    return await service.createActivity(children, keyChild, key, keyActivity);
  }

  Future<void> fetchActivity(String key, String keyChild) async {
    isLoading(true);
    await service.fetchActivity(key, keyChild).then((value) {
      activityList.value = value;
      isLoading(false);
    });
  }

  Future<void> updateActivity(
    ChildrenModel children,
    String key,
    String keyChild,
    String keyActivity,
  ) async {
    await service.updateActivity(children, key, keyChild, keyActivity);
  }

  Future<void> deleteActivity(
    String key,
    String keyChild,
    String keyActivity,
  ) async {
    await service.deleteActivity(key, keyChild, keyActivity);
  }

  //Create Parent
  Future<void> createData(ParentModel parent, String key) async {
    await service.addParent(parent, key);
  }

  //Delete Parent
  Future<void> deleteData(String key) async {
    await service.deleteParent(key);
  }

  //Update Parent
  Future<void> updateData(ParentModel parent, String key) async {
    await service.updateParent(parent, key);
  }
}
