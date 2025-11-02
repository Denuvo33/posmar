import 'package:get/get.dart';
import 'package:posmar/model/parent_model.dart';
import 'package:posmar/service/firebase_fetch.dart';

class ParentController extends GetxController {
  var parentList = <ParentModel>[].obs;
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

  void createData(ParentModel parent) {
    service.addParent(parent);
  }
}
