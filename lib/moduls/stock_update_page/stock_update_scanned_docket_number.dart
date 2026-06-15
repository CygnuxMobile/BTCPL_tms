import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:btcpl/moduls/stock_update_page/stock_update_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/stock_update/stock_update_list/stock_update_list_response.dart';
import '../../widgets/app_size.dart';
import '../../widgets/tms_button.dart';
import '../../widgets/tms_normaltext.dart';

class StockUpdateScannedDocketNumberScreen extends StatefulWidget {
  const StockUpdateScannedDocketNumberScreen({
    required this.onTap,
    required this.title,
    required this.bcNumber,
    required this.index,
    required this.cancelOnTap,
    required this.onTapText,
    required this.docketBcSerialList,
    required this.isPreview,
    super.key,
  });

  final String title;
  final String bcNumber;
  final int index;
  final String onTapText;
  final Function() onTap;
  final Function() cancelOnTap;
  final bool isPreview;
  final DocketBcSerialList docketBcSerialList;

  @override
  State<StockUpdateScannedDocketNumberScreen> createState() =>
      _StockUpdateScannedDocketNumberScreenState();
}

class _StockUpdateScannedDocketNumberScreenState
    extends State<StockUpdateScannedDocketNumberScreen> {
  StockUpdateController stockUpdateController =
      Get.find<StockUpdateController>();

  List<File> damageSelectedImages = [];
  List<File> pillFillSelectedImages = [];

  Future<void> damageImagesFromGallery() async {
    final List<XFile> selectedFiles = await ImagePicker().pickMultiImage();
    List<File> tempImages = [];
    for (XFile file in selectedFiles) {
      tempImages.add(File(file.path));
    }
    setState(() {
      damageSelectedImages.addAll(tempImages);
      widget.docketBcSerialList.damageImages = damageSelectedImages
          .map((file) => base64Encode(file.readAsBytesSync()))
          .toList();
    });
  }

  Future<void> damageImageFromCamera() async {
    final XFile? capturedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (capturedFile != null) {
      setState(() {
        damageSelectedImages.add(File(capturedFile.path));
        widget.docketBcSerialList.damageImages = damageSelectedImages
            .map((file) => base64Encode(file.readAsBytesSync()))
            .toList();
      });
    }
  }

  Future<void> pillFillImagesFromGallery() async {
    final List<XFile> selectedFiles = await ImagePicker().pickMultiImage();
    List<File> tempImages = [];
    for (XFile file in selectedFiles) {
      tempImages.add(File(file.path));
    }
    setState(() {
      pillFillSelectedImages.addAll(tempImages);
      widget.docketBcSerialList.pillFillImages = pillFillSelectedImages
          .map((file) => base64Encode(file.readAsBytesSync()))
          .toList();
    });
  }

  Future<void> pillFillImageFromCamera() async {
    final XFile? capturedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (capturedFile != null) {
      setState(() {
        pillFillSelectedImages.add(File(capturedFile.path));
        widget.docketBcSerialList.pillFillImages = pillFillSelectedImages
            .map((file) => base64Encode(file.readAsBytesSync()))
            .toList();
      });
    }
  }

  Widget damageImage() {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 1,
      crossAxisSpacing: 25,
      mainAxisSpacing: 25,
      children: List.generate(
        widget.docketBcSerialList.damageImages!.length,
        (index) {
          Uint8List bytes =
              base64Decode(widget.docketBcSerialList.damageImages![index]);
          return Obx(
            () => Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  height: AppSize.size(context).height * 0.15,
                  width: AppSize.size(context).width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 3,
                    ),
                  ),
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.fill,
                  ),
                ),
                stockUpdateEnum.value == StockUpdateEnum.view
                    ? IconButton(
                        iconSize: 20,
                        onPressed: () {
                          setState(() {
                            widget.docketBcSerialList.damageImages!
                                .removeAt(index);
                          });
                        },
                        icon: const Icon(CupertinoIcons.xmark_circle_fill,
                            color: Colors.red))
                    : SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget pillFillImage() {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 1,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: List.generate(
        widget.docketBcSerialList.pillFillImages!.length,
        (index) {
          Uint8List bytes =
              base64Decode(widget.docketBcSerialList.pillFillImages![index]);
          return Obx(
            () => Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 3,
                      ),
                    ),
                    child: Image.memory(
                      bytes,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                stockUpdateEnum.value == StockUpdateEnum.view
                    ? Positioned(
                        left: 12,
                        bottom: 12,
                        child: IconButton(
                            iconSize: 20,
                            onPressed: () {
                              setState(() {
                                widget.docketBcSerialList.pillFillImages!
                                    .removeAt(index);
                              });
                            },
                            icon: const Icon(CupertinoIcons.xmark_circle_fill,
                                color: Colors.red)))
                    : SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selectedImages = widget.selectedImages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff232F34),
        title: TmsText(
          color: Colors.white,
          text: 'Stock Update',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TmsText(
                  text: "Scanned Docket Number",
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TmsText(
                          text: stockUpdateController.BSNumberController.text,
                          fontSize: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: TmsText(
                            text: 'Select one if applicable : ',
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        BoxDesign(
                          context,
                          color: Colors.red,
                          text: 'Damage',
                          value: widget.docketBcSerialList.isDamage.value,
                          onChanged: (value) {
                            setState(() {
                              widget.docketBcSerialList.isPillFill.value =
                                  false;
                              if (stockUpdateEnum.value ==
                                  StockUpdateEnum.view) {
                                widget.docketBcSerialList.isDamage.value =
                                    !widget.docketBcSerialList.isDamage.value;
                              } else {
                                widget.docketBcSerialList.isDamage.value =
                                    widget.docketBcSerialList.isDamage.value;
                              }
                              // widget.docketBcSerialList.pillFillImages!.clear();
                            });
                          },
                        ),
                        BoxDesign(
                          context,
                          color: Color(0xff0500E3),
                          text: 'Pill Fill    ',
                          value: widget.docketBcSerialList.isPillFill.value,
                          onChanged: (value) {
                            setState(() {
                              widget.docketBcSerialList.isDamage.value = false;
                              if (stockUpdateEnum.value ==
                                  StockUpdateEnum.view) {
                                widget.docketBcSerialList.isPillFill.value =
                                    !widget.docketBcSerialList.isPillFill.value;
                              } else {
                                widget.docketBcSerialList.isPillFill.value =
                                    widget.docketBcSerialList.isPillFill.value;
                              }
                              // widget.docketBcSerialList.damageImages!.clear();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.docketBcSerialList.isDamage.value ||
                    widget.docketBcSerialList.isPillFill.value) ...{
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TmsText(
                      text: "Select image",
                      color: Color(0xff646D72),
                      fontSize: 16,
                    ),
                  ),
                },
                Expanded(
                  child: Container(
                      child: ListView(
                    children: DAPSEnum.values.map(
                      (e) {
                        if (e.index == 0) {
                          if (widget.docketBcSerialList.isDamage.value) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  stockUpdateEnum.value == StockUpdateEnum.view
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 10),
                                          child: SizedBox(
                                            height:
                                                AppSize.size(context).height *
                                                    0.05,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: damageImageFromCamera,
                                                  child: const Image(
                                                    image: AssetImage(
                                                      'assets/images/dashboardimages/uploadCamera.png',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: InkWell(
                                                    onTap:
                                                        damageImagesFromGallery,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          'assets/images/dashboardimages/uploadGallery.png'),
                                                      height: 30,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  if (widget.docketBcSerialList.damageImages !=
                                      null)
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SizedBox(
                                        height:
                                            AppSize.size(context).height * 0.06,
                                        child: damageImage(),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        } else {
                          if (widget.docketBcSerialList.isPillFill.value) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  stockUpdateEnum.value == StockUpdateEnum.view
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 10),
                                          child: SizedBox(
                                            height:
                                                AppSize.size(context).height *
                                                    0.05,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap:
                                                      pillFillImageFromCamera,
                                                  child: const Image(
                                                    image: AssetImage(
                                                      'assets/images/dashboardimages/uploadCamera.png',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: InkWell(
                                                    onTap:
                                                        pillFillImagesFromGallery,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          'assets/images/dashboardimages/uploadGallery.png'),
                                                      height: 30,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  if (widget
                                          .docketBcSerialList.pillFillImages !=
                                      null)
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SizedBox(
                                        height:
                                            AppSize.size(context).height * 0.06,
                                        child: pillFillImage(),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        }
                      },
                    ).toList(),
                  )),
                ),
                TmsButton(
                  size: Size(double.infinity, AppSize.size(context).height * 0.06),
                    text: "Done",
                    onPressed: () {
                      Get.back();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDesign(BuildContext context,
      {required Color color,
      required String text,
      required bool value,
      required Function(bool? selected) onChanged}) {
    return Row(
      children: [
        Container(
          height: AppSize.size(context).height * 0.009,
          width: AppSize.size(context).width * 0.12,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(3)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: TmsText(
            text: text,
            color: Colors.black,
            fontSize: 10,
          ),
        ),
        Container(
          height: 28,
          child: Transform.scale(
            scale: 0.9,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: stockUpdateEnum.value == StockUpdateEnum.view
                  ? const Color(0xff03045E)
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
