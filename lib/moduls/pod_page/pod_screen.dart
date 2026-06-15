import 'package:btcpl/moduls/pod_page/pod_controller.dart';
import 'package:btcpl/moduls/pod_page/widget/image_bottom_sheet.dart';
import 'package:btcpl/moduls/pod_page/widget/pod_upload_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';
import '../../utils/connection_handler.dart';

class PodUploadScreen extends StatefulWidget {
  PodUploadScreen({Key? key}) : super(key: key);

  @override
  State<PodUploadScreen> createState() => _PodUploadScreenState();
}

class _PodUploadScreenState extends State<PodUploadScreen> {
  PodUploadController podUploadController = Get.put(PodUploadController());

  @override
  void initState() {
    // TODO: implement initState
    final allDockets = podDb.getAllDocket();

    if (allDockets.isNotEmpty) {
      print("================ All Docket Records ================");
      for (int i = 0; i < allDockets.length; i++) {
        print("-----------------------------------------------------------------------------");
        print("\n${allDockets[i].dockNo}");
        print("\n${allDockets[i].dockDt}");
        print("\n${allDockets[i].buttonName}");
        print("\n${allDockets[i].status}");
        if (allDockets[i].podImagePaths.isNotEmpty) {
          for (var data in allDockets[i].podImagePaths) {
            print("\n$data");
          }
        }
      }
    }

    bool isOnline = ConnectionService().hasConnection;
    if (isOnline) {
      podUploadController.isOnline.value = true;
      podUploadController.podListApi();
      print("🟢 11111111 Online - Ready to sync");
      podUploadController.uploadPendingPODs();
    } else {
      podUploadController.isOnline.value = false;
      podUploadController.podListApiStatus.value = ApiStatus.success;
      podUploadController.podList.value = podDb.getAllDocket();

      ///-------------------------------------------------------

      print("🔴 1111111 Offline - Will store data locally");
    }

    ConnectionService().connectionChange.listen((isOnline) {
      if (isOnline) {
        podUploadController.isOnline.value = true;
        print(" 2222222🟢 Online - Try to sync now");
        podUploadController.uploadPendingPODs();
      } else {
        podUploadController.isOnline.value = false;
        podUploadController.podListApiStatus.value = ApiStatus.success;
        podUploadController.podList.value = podDb.getAllDocket();

        ///-------------------------------------------------------
        print(" 2222222 🔴 Offline - Save data locally");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text(
          "Pod Upload",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff232F34),
        surfaceTintColor: Color(0xff232F34),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          Obx(() {
            if (podUploadController.isOnline.isTrue) {
              return InkWell(
                onTap: () => podUploadBottomSheet(context, podUploadController),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.filter_alt_rounded,
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          })
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          final status = podUploadController.podListApiStatus.value;

          if (status == ApiStatus.loading) {
            return Center(child: CircularProgressIndicator(color: Color(0xff232F34)));
          } else if (status == ApiStatus.error) {
            return const Center(child: Text("No data found"));
          }

          return Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by Docket No',
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                  onChanged: (value) {
                    podUploadController.searchQuery.value = value.trim();
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: _buildPodList()),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPodList() {
    final selectedTab = podUploadController.selectedTab.value;
    final isOnlineTab = selectedTab == 0;

    final filteredList = podUploadController.podList.where((item) {
      final matchesTab = isOnlineTab ? item.apiStatusIndex != 1 : item.apiStatusIndex == 1;
      final matchesSearch =
          item.dockNo.toLowerCase().contains(podUploadController.searchQuery.value.toLowerCase());
      return matchesTab && matchesSearch;
    }).toList();

    if (filteredList.isEmpty) {
      return const Center(child: Text("No PODs available"));
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final pod = filteredList[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xffE2E4E9), width: 1),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  if (pod.apiStatusIndex == 1)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xffFFFFFF),
                        border: Border.all(color: const Color(0xffE2E4E9), width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.cloud_off_rounded, color: Colors.orange),
                            const SizedBox(width: 10),
                            Text(
                              "Offline pod upload.",
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            pod.loading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(Colors.orange),
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Docket No : ",
                        style: TextStyle(color: const Color(0xff667085)),
                      ),
                      Text(pod.dockNo, style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Status : ", style: TextStyle(color: const Color(0xff667085))),
                      Expanded(
                        child: Text(
                          pod.status,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: pod.apiStatusIndex == 0 ? 10 : 0),
                  if (pod.apiStatusIndex == 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                builder: (context) => podImagePicker(
                                  index: index,
                                  context: context,
                                  podUploadController: podUploadController,
                                  docket: pod.dockNo,
                                  pickImage: pod.podImagePaths.obs,
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Color(0xff232F34), width: 1.2),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            child: Text(
                              pod.buttonName,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff232F34),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: pod.loading
                                ? null
                                : () async {
                                    await Permission.storage.request();
                                    await Permission.manageExternalStorage.request();
                                    final isOnline = ConnectionService().hasConnection;

                                    if (pod.buttonName == "Edit Pod") {
                                      if (pod.podImagePaths.length < 1) {
                                        Get.snackbar(
                                          'Incomplete Images',
                                          'Please make sure both Front and Back images are added before submitting.',
                                          backgroundColor: Colors.redAccent,
                                          colorText: Colors.white,
                                        );
                                        return;
                                      }

                                      podUploadController.submitHandel(
                                        isOnline: isOnline,
                                        docketNo: pod.dockNo,
                                        podImage: pod.podImagePaths.isNotEmpty
                                            ? pod.podImagePaths[0]
                                            : "",
                                        podImageBack: pod.podImagePaths.length > 1
                                            ? pod.podImagePaths[1]
                                            : "",
                                      );
                                    } else {
                                      Get.snackbar(
                                        'Limit reached',
                                        'You will have to pick 2 images from here.',
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white,
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff232F34),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            child: pod.loading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
