import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../main.dart';
import '../../../utils/pref.dart';
import '../../../widgets/app_size.dart';
import '../../../widgets/tms_button.dart';
import '../pod_controller.dart';

/// Show dialog to open settings if permission is denied
Future<void> _showPermissionDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Permission Required"),
      content: const Text(
        "To pick images, please allow access to photos/camera in settings.",
      ),
      actions: [
        TextButton(
          child: const Text("Open Settings"),
          onPressed: () async {
            Navigator.of(context).pop();
            await openAppSettings();
          },
        ),
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

/// Check if Android version is 13+ (API 33+)
// Future<bool> _isAndroid13OrAbove() async {
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//   debugPrint("Android version ==== ${androidInfo.version.codename}");
//   return androidInfo.version.sdkInt >= 33;
// }

/// Request and check storage permissions based on Android version
// Future<bool> checkStoragePermission(BuildContext context) async {
//   if (Platform.isAndroid && await _isAndroid13OrAbove()) {
//     // Android 13+ requires READ_MEDIA permissions
//     PermissionStatus storagePerm1 = await Permission.manageExternalStorage.status;
//     PermissionStatus camera = await Permission.camera.status;
//
//     debugPrint("Permission storage === ${storagePerm1.isGranted}");
//     debugPrint("Permission storage === ${camera.isGranted}");
//
//     if (storagePerm1.isGranted && camera.isGranted) return true;
//
//     Map<Permission, PermissionStatus> statuses =
//         await [Permission.manageExternalStorage, Permission.camera].request();
//
//     bool granted = statuses[Permission.manageExternalStorage]?.isGranted == true;
//
//     if (!granted) {
//       await _showPermissionDialog(context);
//       return await checkStoragePermission(context); // Re-check after settings
//     }
//
//     return granted;
//   } else {
//     // For Android < 13
//     if (await Permission.storage.isGranted) return true;
//
//     Map<Permission, PermissionStatus> statuses = await [Permission.storage].request();
//
//     bool granted = statuses[Permission.storage]?.isGranted == true;
//
//     if (!granted) {
//       await _showPermissionDialog(context);
//       return await checkStoragePermission(context);
//     }
//
//     return granted;
//   }
// }

/// Pick multiple images from gallery
Future<List<File>?> imagesFromGallery(BuildContext context) async {
  final List<XFile>? selectedFiles = await ImagePicker().pickMultiImage(imageQuality: 10);

  if (selectedFiles != null && selectedFiles.isNotEmpty) {
    return selectedFiles.map((file) => File(file.path)).toList();
  }
  return null;
}

/// Pick single image from camera
Future<File?> imageFromCamera(BuildContext context) async {
  final XFile? capturedFile = await ImagePicker().pickImage(
    source: ImageSource.camera,
    imageQuality: 10,
  );

  if (capturedFile != null) {
    return File(capturedFile.path);
  }
  return null;
}

/// Grid view of selected images with delete option
Widget imageView({
  required RxList<String> pickImage,
  required String dockNo,
  required PodUploadController podUploadController,
}) {
  return Obx(() {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: pickImage.length,
      itemBuilder: (context, index) {
        debugPrint("Image Pathe ====== ${pickImage[index]}");
        return Stack(
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(pickImage[index]),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('Image error'));
                  },
                ),
              ),
            ),
            Positioned(
              top: 2,
              right: 2,
              child: GestureDetector(
                onTap: () {
                  final imagePath = pickImage[index];
                  final file = File(imagePath);

                  podDb.clearImageByPath(path: imagePath, dockNo: dockNo);

                  if (file.existsSync()) {
                    file.deleteSync();
                  }
                  pickImage.removeAt(index);
                  if (pickImage.isEmpty) {
                    podDb.changeButtonName(buttonName: "Upload Pod", dockNo: dockNo);
                    podDb.changePodStatus(status: "No images uploaded", dockNo: dockNo);
                  }
                  podUploadController.podList.value = podDb.getAllDocket();
                },
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(CupertinoIcons.xmark_circle_fill, color: Colors.red, size: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  });
}

/// Main Image Picker Widget
Widget podImagePicker({
  required PodUploadController podUploadController,
  required BuildContext context,
  required RxList<String> pickImage,
  required String docket,
  required int index,
}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: SizedBox(
      width: double.infinity,
      child: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Pick Image", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// CAMERA BUTTON
                Expanded(
                  child: GestureDetector(
                    onTap: pickImage.length >= 1
                        ? () {
                            Get.snackbar(
                              'Limit reached',
                              'You can only select up to 2 images.',
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                          }
                        : () async {
                            File? image = await imageFromCamera(context);
                            if (image == null) return;

                            final Directory cacheDir = await getTemporaryDirectory();
                            final Directory targetDir = Directory('${cacheDir.path}/image');

                            if (!(await targetDir.exists())) {
                              await targetDir.create(recursive: true);
                            }

                            String imageName = "P@${docket}@${Pref().getUserId()}.jpg";
                            String newPath = '${targetDir.path}/$imageName';

                            File newImage = await image.copy(newPath);

                            if (await newImage.exists()) {
                              pickImage.add(newImage.path);
                              pickImage.refresh();
                            }
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xffe5eeff),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, color: Color(0xff232F34)),
                            SizedBox(width: 8),
                            Text(
                              'Camera',
                              style: TextStyle(
                                color: Color(0xff232F34),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// GALLERY BUTTON
                Expanded(
                  child: GestureDetector(
                    onTap: pickImage.length >= 1
                        ? () {
                            Get.snackbar(
                              'Limit reached',
                              'You can only select up to 2 images.',
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                          }
                        : () async {
                            List<File> images = await imagesFromGallery(context) ?? [];

                            int remainingSlots = 2 - pickImage.length;
                            if (remainingSlots <= 0) return;

                            final Directory cacheDir = await getTemporaryDirectory();
                            final Directory targetDir = Directory('${cacheDir.path}/image');

                            if (!(await targetDir.exists())) {
                              await targetDir.create(recursive: true);
                            }

                            for (final img in images.take(remainingSlots)) {
                              String imageName = "P@${docket}@${Pref().getUserId()}@${DateTime.now().microsecondsSinceEpoch}.jpg";

                              String newPath = '${targetDir.path}/$imageName';
                              File savedFile = await img.copy(newPath);

                              if (await savedFile.exists()) {
                                pickImage.add(savedFile.path);
                              }
                            }
                            pickImage.refresh();
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xffe5eeff),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.image, color: Color(0xff232F34)),
                            SizedBox(width: 8),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                color: Color(0xff232F34),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            /// Image View
            Obx(() {
              return pickImage.isNotEmpty
                  ? SizedBox(
                      height: AppSize.size(context).height * 0.12,
                      child: imageView(
                        pickImage: pickImage,
                        dockNo: docket,
                        podUploadController: podUploadController,
                      ),
                    )
                  : const SizedBox();
            }),

            /// Submit Button
            Obx(() {
              return pickImage.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: TmsButton(
                            text: "+ Add",
                            color: const Color(0xff232F34),
                            onPressed: () {
                              if (pickImage.length < 1) {
                                Get.snackbar(
                                  'Add Both Images',
                                  'Please add both Front and Back images before submitting.',
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              podDb.changePodStatus(
                                status: "Images uploaded - Pending submission",
                                dockNo: docket,
                              );
                              podDb.changeButtonName(buttonName: "Edit Pod", dockNo: docket);
                              podDb.imageInsert(dockNo: docket, podImage: pickImage);
                              podUploadController.podList.value = podDb.getAllDocket();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    )
                  : const SizedBox();
            }),
          ],
        );
      }),
    ),
  );
}
