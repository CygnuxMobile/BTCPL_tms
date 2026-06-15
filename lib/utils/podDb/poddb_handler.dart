import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'objectbox.g.dart';

class PodDb {
  late final Store store;
  late final Box<Docket> docketBox;

  PodDb._create(this.store) {
    docketBox = Box<Docket>(store);
  }

  static Future<PodDb> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final store = openStore(directory: p.join(dir.path, 'objectbox'));
    return PodDb._create(await store);
  }

  void insertDocket(Docket person) {
    docketBox.put(person);
  }

  List<Docket> getAllDocket() {
    return docketBox.getAll();
  }

  Docket? getObjectByDockNo(String dockNo) {
    final query = docketBox.query(Docket_.dockNo.equals(dockNo)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  void imageInsert({required String dockNo, required List<String> podImage}) {
    final query = docketBox.query(Docket_.dockNo.equals(dockNo)).build();
    final docket = query.findFirst();
    query.close();

    if (docket != null) {
      docket.podImagePaths.clear();
      docket.podImagePaths.addAll(podImage.map((path) => path));
      docketBox.put(docket);
    }
  }

  void clearImageByPath({required String path, required String dockNo}) {
    final query = docketBox.query(Docket_.dockNo.equals(dockNo)).build();
    final docket = query.findFirst();
    query.close();

    if (docket != null) {
      docket.podImagePaths.remove(path); // ✅ remove by value instead of index
      docketBox.put(docket);
      print("🗑️ Removed image from DB: $path");
    } else {
      print("❌ Docket not found for dockNo: $dockNo");
    }
  }

  void changePodStatus({required String status, required String dockNo}) {
    final query = docketBox.query(Docket_.dockNo.equals(dockNo)).build();
    final docket = query.findFirst();
    query.close();

    if (docket != null) {
      docket.status = status;
      docketBox.put(docket);
    }
  }

  void changeButtonName({required String buttonName, required String dockNo}) {
    final query = docketBox.query(Docket_.dockNo.equals(dockNo)).build();
    final docket = query.findFirst();
    query.close();

    if (docket != null) {
      docket.buttonName = buttonName;
      docketBox.put(docket);
    }
  }

  void podUploadStatus({required int status, required String dockNo}) {
    final query = docketBox.query(Docket_.dockNo.equals(dockNo)).build();
    final docket = query.findFirst();
    query.close();

    if (docket != null) {
      docket.apiStatusIndex = status;
      docketBox.put(docket);
    }
  }

  void removeDocket({required String dockNo}) {
    final query = docketBox.query(Docket_.dockNo.equals(dockNo)).build();
    final docket = query.findFirst();
    query.close();

    if (docket != null) {
      docketBox.remove(docket.id);
    }
  }

  void deleteDocket(int id) {
    docketBox.remove(id);
  }

  void updateDocket(Docket person) {
    docketBox.put(person);
  }

  void clearAll() {
    docketBox.removeAll();
  }
}

@Entity()
class Docket {
  @Id()
  int id = 0;

  @Unique()
  String dockNo;
  String dockDt;
  String tripSheetNo;
  List<String> podImagePaths;
  String status;
  String buttonName;
  int apiStatusIndex;
  bool loading;

  Docket({
    required this.dockNo,
    required this.dockDt,
    required this.tripSheetNo,
    required this.podImagePaths,
    required this.status,
    required this.buttonName,
    required this.apiStatusIndex,
    required this.loading,
  });
}

@Entity()
class StringEntity {
  @Id()
  int id = 0;

  String value;

  StringEntity({required this.value});
}
