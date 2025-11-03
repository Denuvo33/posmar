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
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() {
    isLoading(true);
    service.fetchParent().then((value) {
      parentList.value = value;
      isLoading(false);
    });
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

  Future<void> createActivity(
    ChildrenModel children,
    String key,
    String keyChild,
  ) async {
    return await service.createActivity(children, keyChild, key);
  }

  Future<void> fetchActivity(String key, String keyChild) async {
    isLoading(true);
    await service.fetchActivity(key, keyChild).then((value) {
      activityList.value = value;
      isLoading(false);
    });
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
