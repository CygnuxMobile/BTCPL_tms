import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:btcpl/widgets/tms_button.dart';
import 'package:btcpl/widgets/tms_normaltext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import '../model/stock_update/stock_update_list/stock_update_list_response.dart';
import '../moduls/stock_update_page/stock_update_controller.dart';
import '../utils/tms_color.dart';
import 'DAPS_selection.dart';
import 'app_size.dart';

ScannedStockUpdateAlertDialog({
  required BuildContext context,
  required String title,
  required String bcNumber,
  required int index,
  required String onTapText,
  required Function() onTap,
  required Function() cancelOnTap,
  required DocketBcSerialList docketBcSerialList,
  required bool isPreview,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (
      BuildContext context,
    ) {
      return StockUpdateDailog(
        onTap: onTap,
        title: title,
        onTapText: onTapText,
        bcNumber: bcNumber,
        cancelOnTap: cancelOnTap,
        index: index,
        docketBcSerialList: docketBcSerialList,
        isPreview: isPreview,
      );
    },
  );
}

class StockUpdateDailog extends StatefulWidget {
  const StockUpdateDailog({
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
  State<StockUpdateDailog> createState() => _StockUpdateDailogState();
}

class _StockUpdateDailogState extends State<StockUpdateDailog> {
  StockUpdateController stockUpdateController =
      Get.put(StockUpdateController());

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

  Future<void> pillfillImagesFromGallery() async {
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

  Future<void> pillfillImageFromCamera() async {
    final XFile? capturedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (capturedFile != null) {
      setState(() {
        pillFillSelectedImages.add(
          File(capturedFile.path),
        );
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
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: List.generate(widget.docketBcSerialList.damageImages!.length,
          (index) {
        Uint8List bytes =
            base64Decode(widget.docketBcSerialList.damageImages![index]);
        return Obx(
          () => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  height: 70,
                  width: 70,
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
                          iconSize: 15,
                          onPressed: () {
                            setState(() {
                              widget.docketBcSerialList.damageImages!
                                  .removeAt(index);
                            });
                          },
                          icon: const Icon(CupertinoIcons.xmark_circle_fill,
                              color: Colors.red)))
                  : SizedBox(),
            ],
          ),
        );
      }),
    );
  }

  Widget pillFillImage() {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 1,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: List.generate(widget.docketBcSerialList.pillFillImages!.length,
          (index) {
        Uint8List bytes =
            base64Decode(widget.docketBcSerialList.pillFillImages![index]);
        return Obx(
          () => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  height: 70,
                  width: 70,
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
                          iconSize: 15,
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
      }),
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
    return AlertDialog(
      // insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Center(
          child: Text(widget.title),
        ),
      ),

      content: Container(
        width: AppSize.size(context).width * 0.45,
        height: AppSize.size(context).height * 0.45,
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 2,
                width: double.infinity,
                color: const Color(0xff03045E),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: TmsText(
                      text: widget.bcNumber,
                      color: AppColor.bloodRed,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Container(
                    child: ListView(
                  padding: EdgeInsets.all(16),
                  children: DAPSEnum.values.map(
                    (e) {
                      if (e.index == 0) {
                        if (widget.docketBcSerialList.isDamage.value) {
                          return ExpansionTile(
                            onExpansionChanged: (expanded) {
                              setState(() {});
                            },
                            initiallyExpanded: true,
                            tilePadding: EdgeInsets.only(left: 0, right: 12),
                            title: CheckboxSelectionScreen(
                                onChange: (value) {
                                  setState(() {
                                    widget.docketBcSerialList.isPillFill.value =
                                        false;
                                    if (stockUpdateEnum.value ==
                                        StockUpdateEnum.view) {
                                      widget.docketBcSerialList.isDamage.value =
                                          !widget.docketBcSerialList.isDamage
                                              .value;
                                    } else {
                                      widget.docketBcSerialList.isDamage.value =
                                          widget.docketBcSerialList.isDamage
                                              .value;
                                    }
                                  });
                                },
                                selectedValue:
                                    widget.docketBcSerialList.isDamage.value,
                                color: Colors.red,
                                boxType: DAPSEnum.damage,
                                typeName: DAPSEnum.damage.name,
                               isPreview: widget.isPreview,
                            ),
                            children: [
                              if (widget.docketBcSerialList.damageImages !=
                                  null)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SizedBox(
                                    height: AppSize.size(context).height * 0.06,
                                    child: damageImage(),
                                  ),
                                ),
                              stockUpdateEnum.value == StockUpdateEnum.view
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 10),
                                      child: SizedBox(
                                        height:
                                            AppSize.size(context).height * 0.05,
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            InkWell(
                                              onTap: damageImageFromCamera,
                                              child: const HugeIcon(
                                                icon: HugeIcons.strokeRoundedCamera01,
                                                color: Color(0xff232F34),
                                                size: 30,
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: damageImagesFromGallery,
                                              child: const HugeIcon(
                                                icon: HugeIcons.strokeRoundedImageAdd01,
                                                color: Color(0xff232F34),
                                                size: 30,
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          );
                        } else {
                          return CheckboxSelectionScreen(
                              onChange: (value) {
                                setState(() {
                                  widget.docketBcSerialList.isPillFill.value =
                                      false;
                                  if (stockUpdateEnum.value ==
                                      StockUpdateEnum.view) {
                                    widget.docketBcSerialList.isDamage.value =
                                        !widget
                                            .docketBcSerialList.isDamage.value;
                                  } else {
                                    widget.docketBcSerialList.isDamage.value =
                                        widget
                                            .docketBcSerialList.isDamage.value;
                                  }
                                });
                              },
                              selectedValue:
                                  widget.docketBcSerialList.isDamage.value,
                              color: Colors.red,
                              boxType: DAPSEnum.damage,
                              isPreview: widget.isPreview,
                              typeName: DAPSEnum.damage.name);
                        }
                      } else {
                        if (widget.docketBcSerialList.isPillFill.value) {
                          return ExpansionTile(
                            onExpansionChanged: (expanded) {
                              setState(() {});
                            },
                            initiallyExpanded: true,
                            tilePadding: EdgeInsets.only(left: 0, right: 12),
                            title: CheckboxSelectionScreen(
                                onChange: (value) {
                                  setState(() {
                                    widget.docketBcSerialList.isDamage.value =
                                        false;
                                    if (stockUpdateEnum.value ==
                                        StockUpdateEnum.view) {
                                      widget.docketBcSerialList.isPillFill
                                              .value =
                                          !widget.docketBcSerialList.isPillFill
                                              .value;
                                    } else {
                                      widget.docketBcSerialList.isPillFill
                                              .value =
                                          widget.docketBcSerialList.isPillFill
                                              .value;
                                    }
                                  });
                                },
                                selectedValue:
                                    widget.docketBcSerialList.isPillFill.value,
                                color: Color(0xff0500E3),
                                boxType: DAPSEnum.pillFill,
                                typeName: DAPSEnum.pillFill.name, isPreview: widget.isPreview, ),
                            children: [
                              if (widget.docketBcSerialList.pillFillImages !=
                                  null)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SizedBox(
                                    height: AppSize.size(context).height * 0.06,
                                    child: pillFillImage(),
                                  ),
                                ),
                              stockUpdateEnum.value == StockUpdateEnum.view
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 10),
                                      child: SizedBox(
                                        height:
                                            AppSize.size(context).height * 0.05,
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            InkWell(
                                              onTap: pillfillImageFromCamera,
                                              child: const HugeIcon(
                                                icon: HugeIcons.strokeRoundedCamera01,
                                                color: Color(0xff232F34),
                                                size: 30,
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: pillfillImagesFromGallery,
                                              child: const HugeIcon(
                                                icon: HugeIcons.strokeRoundedImageAdd01,
                                                color: Color(0xff232F34),
                                                size: 30,
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          );
                        } else {
                          return CheckboxSelectionScreen(
                              onChange: (value) {
                                setState(() {
                                  widget.docketBcSerialList.isDamage.value =
                                      false;
                                  if (stockUpdateEnum.value ==
                                      StockUpdateEnum.view) {
                                    widget.docketBcSerialList.isPillFill.value =
                                        !widget.docketBcSerialList.isPillFill
                                            .value;
                                  } else {
                                    widget.docketBcSerialList.isPillFill.value =
                                        widget.docketBcSerialList.isPillFill
                                            .value;
                                  }
                                });
                              },
                              selectedValue:
                                  widget.docketBcSerialList.isPillFill.value,
                              color: Color(0xff0500E3),
                              isPreview: widget.isPreview,
                              boxType: DAPSEnum.pillFill,
                              typeName: DAPSEnum.pillFill.name);
                        }
                      }
                    },
                  ).toList(),
                )),
              ),
              SizedBox(
                height: AppSize.size(context).height * 0.02,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TmsButton(
                      text: 'Cancel',
                      onPressed: widget.cancelOnTap,
                      color: Colors.white24,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TmsButton(
                      text: widget.onTapText,
                      onPressed: widget.onTap,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
