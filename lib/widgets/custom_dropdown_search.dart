import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class Dropdown extends StatelessWidget {
  Dropdown(
      {super.key,
      required this.text,
      required this.list,
      required this.onChanged,
      this.selectedItem,
      this.showSearchBox,
      this.validator,
      this.globalKey,
      required this.isSize,
      required this.enabled,
      this.image,
      this.icon,
      this.height,
      this.boxDecoration});

  final RxString text;
  final RxString? image;
  final Widget? icon;
  final RxString? selectedItem;
  final void Function(String?)? onChanged;
  final FormFieldValidator<String>? validator;
  final List<String> list;
  final bool? showSearchBox;
  final GlobalKey<FormState>? globalKey;
  final bool isSize;
  final RxBool enabled;
  final RxDouble? height;
  BoxDecoration? boxDecoration;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        // height: isSize ? AppSize.size(context).height * 0.07 : null,
        alignment: Alignment.center,
        decoration: boxDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1),
              color: Colors.white,
            ),
        child: Form(
          key: globalKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                if (icon != null)
                  icon!
                else if (image != null)
                  Image(
                    image: AssetImage(image!.value),
                    height: height == null ? 0 : height!.value,
                  )
                else
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedDeliveryTruck01,
                    color: Color(0xff232F34),
                    size: 25,
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownSearch<String>(
                      enabled: enabled.value,
                      selectedItem: selectedItem?.value,
                      popupProps:
                          PopupProps.menu(showSearchBox: showSearchBox ?? true),
                      items: list,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: text.value,
                        ),
                      ),
                      onChanged: onChanged,
                      validator: validator,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
