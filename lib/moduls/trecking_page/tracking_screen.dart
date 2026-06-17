import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:btcpl/moduls/trecking_page/tracking_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:photo_view/photo_view.dart';
import '../../utils/tms_color.dart';
import '../../widgets/app_size.dart';
import '../../widgets/tms_normaltext.dart';
import '../../widgets/tms_richtext.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

TrackingController trackingController = Get.put(TrackingController());

class _TrackingScreenState extends State<TrackingScreen> {
  final stepperData = List.generate(
    trackingController.getTrackingData.length,
    (index) => StepperData(
        widget: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 100,
            width: 250,
            child: CustomPaint(
              painter: PriceTagPaint(Color(
                int.parse('0xff${trackingController.getTrackingData[index].color}'),
              )),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TmsText(text: trackingController.getTrackingData[index].activity, fontSize: 12),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TmsText(
                            text: trackingController.getTrackingData[index].asdtDate,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          TmsText(
                            text: trackingController.getTrackingData[index].asdtTime,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        textWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 3),
              color: Color(
                int.parse('0xff${trackingController.getTrackingData[index].color}'),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: Center(child: Text((index + 1).toString())),
        )),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tracking',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff232F34),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (trackingController.docketNumber!.isNotEmpty) ...{
                              TmsText(
                                text: trackingController.docketNumber ?? '',
                              ),
                            },
                            if (trackingController.noOfPkgs!.isNotEmpty) ...{
                              Spacer(),
                              TmsTrackingListView(
                                  text: trackingController.noOfPkgs ?? '',
                                  icon: HugeIcons.strokeRoundedPackage,
                                  height: 25),
                            },
                          ],
                        ),
                        if (trackingController.docketDate!.isNotEmpty) ...{
                          TmsTrackingListView(
                              text: trackingController.docketDate ?? '',
                              icon: HugeIcons.strokeRoundedCalendar03,
                              height: 25),
                        },
                        if (trackingController.billingParty!.isNotEmpty) ...{
                          Row(
                            children: [
                              const HugeIcon(
                                icon: HugeIcons.strokeRoundedUserGroup,
                                color: Color(0xff232F34),
                                size: 25,
                              ),
                              Container(
                                width: AppSize.size(context).width / 1.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    trackingController.billingParty ?? '',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff646D72),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        },
                        SizedBox(
                          height: 05,
                        ),
                        if (trackingController.consignee!.isNotEmpty) ...{
                          Row(
                            children: [
                              const HugeIcon(
                                icon: HugeIcons.strokeRoundedUser,
                                color: Color(0xff232F34),
                                size: 25,
                              ),
                              Container(
                                width: AppSize.size(context).width / 1.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    trackingController.consignee ?? '',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff646D72),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        },
                        if (trackingController.status != null) ...{
                          Row(
                            children: [
                              const HugeIcon(
                                icon: HugeIcons.strokeRoundedGlobal,
                                color: Color(0xff232F34),
                                size: 25,
                              ),
                              Container(
                                width: AppSize.size(context).width / 1.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    trackingController.status ?? '',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColor.bloodRed,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                            ],
                          )
                        },
                      ],
                    ),
                  ),
                  if (trackingController.Image!.isNotEmpty) ...{
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 01),
                      child: TmsText(
                        text: "Pod view image",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 02),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColor.blue,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: TmsText(
                              text: 'if you see full image please click on it',
                              fontSize: 10,
                              color: AppColor.bloodRed,
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(FullScreenImage(
                          imageUrl: trackingController.Image,
                          docketNumber: trackingController.docketNumber,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 05, left: 10, bottom: 10),
                        child: Container(
                          height: AppSize.size(context).height * 0.10,
                          width: AppSize.size(context).width * 0.20,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(08),
                            border: Border.all(color: Color(0xff646D72), width: 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: trackingController.Image!,
                              progressIndicatorBuilder: (context, url, downloadProgress) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(value: downloadProgress.progress),
                                ],
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  },
                  if (trackingController.destcd!.isNotEmpty) ...{
                    Container(
                      height: AppSize.size(context).height * 0.11,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Color(0xff646D72),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  trackingController.orgncd ?? '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Text(
                                  'Origin',
                                  style: TextStyle(color: Color(0xffC4CACD), fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const HugeIcon(
                            icon: HugeIcons.strokeRoundedArrowRight01,
                            color: Colors.white,
                            size: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  trackingController.destcd ?? '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Text(
                                  'Destination',
                                  style: TextStyle(color: Color(0xffC4CACD), fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  }
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: AnotherStepper(
                      stepperList: stepperData,
                      stepperDirection: Axis.vertical,
                      iconWidth: 40,
                      iconHeight: 40,
                      activeBarColor: Colors.grey,
                      inActiveBarColor: Colors.grey,
                      inverted: false,
                      verticalGap: 40,
                      activeIndex: 0,
                      barThickness: 4,
                      widgetHeight: 120,
                      widgetWidth: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrackingView extends StatefulWidget {
  const TrackingView(
      {required this.text,
      required this.text1,
      super.key,
      required this.color,
      required this.color1,
      required this.fontSize,
      required this.fontSize1});

  final String text;
  final String text1;
  final Color color;
  final Color color1;
  final double fontSize;
  final double fontSize1;

  @override
  State<TrackingView> createState() => _TrackingView();
}

class _TrackingView extends State<TrackingView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TmsRichText(
            text: widget.text,
            richText: widget.text1,
            fontWeight: FontWeight.bold,
            color: widget.color,
            color1: widget.color1,
            fontSize: widget.fontSize,
            fontSize1: widget.fontSize1,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class PriceTagPaint extends CustomPainter {
  final Color color;

  PriceTagPaint(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Path path = Path();

    path
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.15, size.height)
      ..lineTo(0, size.height / 2)
      ..lineTo(size.width * 0.15, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String docketNumber;

  const FullScreenImage({
    Key? key,
    required this.imageUrl,
    required this.docketNumber,
  }) : super(key: key);

  _saveNetworkImage() async {
    // AppLoader().show();
    // var response = await Dio().get(imageUrl, options: Options(responseType: ResponseType.bytes));
    // AppLoader().hide();
    // try {
    //   final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
    //       quality: 100, name: "$docketNumber");
    //   TmsToast.msg("Image saved");
    // } catch (e) {
    //   TmsToast.msg("Failed to save image");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff646D72),
        title: TmsText(
          text: docketNumber,
          color: AppColor.white,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.download,
        //       color: AppColor.white,
        //     ),
        //     onPressed: _saveNetworkImage,
        //   ),
        // ],
      ),
      body: Center(
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(imageUrl),
          loadingBuilder: (context, event) {
            if (event == null) {
              return const CircularProgressIndicator();
            }
            final progress = event.cumulativeBytesLoaded / event.expectedTotalBytes!;
            return Center(
              child: CircularProgressIndicator(value: progress.toDouble()),
            );
          },
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
          enableRotation: true,
        ),
      ),
    );
  }
}

class TmsTrackingListView extends StatelessWidget {
  final String text;
  final List<List<dynamic>> icon;
  final double height;
  final Color? color;
  final FontWeight? fontWeight;

  const TmsTrackingListView({
    Key? key,
    required this.text,
    required this.icon,
    required this.height,
    this.color,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HugeIcon(
          icon: icon,
          color: const Color(0xff232F34),
          size: height,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: color ?? Color(0xff646D72),
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
            maxLines: 3,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }
}
