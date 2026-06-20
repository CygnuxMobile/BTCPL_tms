import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../widgets/custom_dropdown_search.dart';
import '../../widgets/tms_button.dart';
import 'drs_generate_controller.dart';

class DRSGenerateScreen extends GetView<DRSGenerateController> {
  const DRSGenerateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate DRS', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff232F34),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                "Manual DRS No.",
                controller.manualDrsNoController,
                icon: HugeIcons.strokeRoundedNote01,
              ),
              const SizedBox(height: 16),
              _buildTextField("DRS Date", controller.drsDateController, readOnly: true, icon: HugeIcons.strokeRoundedCalendar03),
              const SizedBox(height: 16),
              Obx(() => Dropdown(
                text: "Vendor Type".obs,
                list: controller.vendorTypeList.map((e) => e.vendorType).toList(),
                enabled: true.obs,
                isSize: false,
                onChanged: (val) {
                  var selected = controller.vendorTypeList.firstWhere((e) => e.vendorType == val);
                  controller.selectedVendorType.value = selected;
                  if (selected.vendorType_Code != "XX") {
                    controller.fetchVendors(selected.vendorType_Code);
                    controller.manualVendorNameController.clear();
                    controller.manualVehicleNoController.clear();
                  } else {
                    controller.selectedVendor.value = null;
                    controller.selectedVehicle.value = null;
                    controller.vendorList.clear();
                    controller.vehicleList.clear();
                  }
                },
                selectedItem: controller.selectedVendorType.value?.vendorType.obs,
              )),
              const SizedBox(height: 16),
              Obx(() {
                if (controller.selectedVendorType.value?.vendorType_Code == "XX") {
                  return Column(
                    children: [
                      _buildTextField("Manual Vendor Name", controller.manualVendorNameController, icon: HugeIcons.strokeRoundedUser),
                      const SizedBox(height: 16),
                      _buildTextField(
                        "Manual Vehicle No.",
                        controller.manualVehicleNoController,
                        maxLength: 10,
                        icon: HugeIcons.strokeRoundedDeliveryTruck01,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter vehicle number';
                          }
                          RegExp regExp = RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z]{0,2}[0-9]{4}$');
                          if (!regExp.hasMatch(value.replaceAll(' ', '').toUpperCase())) {
                            return 'Enter valid vehicle number (e.g. GJ01AA1234)';
                          }
                          return null;
                        },
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Dropdown(
                        text: "Vendor Code/Name".obs,
                        list: controller.vendorList.map((e) => e.vendor_Name).toList(),
                        enabled: (controller.vendorList.isNotEmpty).obs,
                        isSize: false,
                        onChanged: (val) {
                          var selected = controller.vendorList.firstWhere((e) => e.vendor_Name == val);
                          controller.selectedVendor.value = selected;
                          controller.fetchVehicles(selected.vendor_Code, controller.selectedVendorType.value?.vendorType_Code ?? "");
                        },
                        selectedItem: controller.selectedVendor.value?.vendor_Name.obs,
                      ),
                      const SizedBox(height: 16),
                      Dropdown(
                        text: "Vehicle No.".obs,
                        list: controller.vehicleList.map((e) => e.dispVehicle).toList(),
                        enabled: (controller.vehicleList.isNotEmpty).obs,
                        isSize: false,
                        onChanged: (val) {
                          var selected = controller.vehicleList.firstWhere((e) => e.dispVehicle == val);
                          controller.selectedVehicle.value = selected;
                          controller.fetchVehicleDetails(selected.vehno);
                        },
                        selectedItem: controller.selectedVehicle.value?.dispVehicle.obs,
                      ),
                    ],
                  );
                }
              }),
              const SizedBox(height: 16),
              _buildTextField("Driver Name", controller.driverNameController, icon: HugeIcons.strokeRoundedUser),
              const SizedBox(height: 16),
              _buildTextField(
                "Mobile No.",
                controller.mobileNoController,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                icon: HugeIcons.strokeRoundedSmartPhone01,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  if (value.length != 10) {
                    return 'Mobile number must be 10 digits';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Enter a valid mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(() => Dropdown(
                text: "Delivery Agent".obs,
                list: controller.deliveryAgentList.map((e) => e.name).toList(),
                enabled: true.obs,
                isSize: false,
                onChanged: (val) {
                  controller.selectedDeliveryAgent.value = controller.deliveryAgentList.firstWhere((e) => e.name == val);
                },
                selectedItem: controller.selectedDeliveryAgent.value?.name.obs,
              )),
              const SizedBox(height: 16),
              Obx(() => Dropdown(
                text: "Crossing Agent".obs,
                list: controller.crossingAgentList.map((e) => e.vendorname).toList(),
                enabled: true.obs,
                isSize: false,
                onChanged: (val) {
                  controller.selectedCrossingAgent.value = controller.crossingAgentList.firstWhere((e) => e.vendorname == val);
                },
                selectedItem: controller.selectedCrossingAgent.value?.vendorname.obs,
              )),
              const SizedBox(height: 16),
              _buildTextField("Loading Supervisor", controller.loadingSupervisorController, icon: HugeIcons.strokeRoundedUser),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      "Cnote No",
                      controller.cnoteNoController,
                      icon: HugeIcons.strokeRoundedNote01,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(() => InkWell(
                    onTap: controller.isLoadingAddCnote.value ? null : () => controller.addCnoteManual(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff232F34),
                      ),
                      child: controller.isLoadingAddCnote.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Icon(Icons.add, color: Colors.white, size: 24),
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  color: Colors.white,
                ),
                child: Obx(() {
                  if (controller.selectedDockets.isEmpty) {
                    return const Center(
                      child: Text("No Cnotes added yet", style: TextStyle(color: Colors.grey)),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.selectedDockets.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      var docket = controller.selectedDockets[index];
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Docket No: ${docket.dockno}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text("Origin: ${docket.orgncd} | Pkgs: ${docket.pkgsno}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () => controller.toggleDocketSelection(docket),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 32),
              Obx(() => TmsButton(
                text: "GENERATE DRS",
                size: const Size(double.infinity, 55),
                isLoading: controller.isLoadingSubmit.value,
                onPressed: () => controller.submitDRS(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool readOnly = false, String? Function(String?)? validator, int? maxLength, TextInputType? keyboardType, List<List<dynamic>> icon = HugeIcons.strokeRoundedDeliveryTruck01}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          HugeIcon(
            icon: icon,
            color: const Color(0xff232F34),
            size: 25,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: controller,
                readOnly: readOnly,
                validator: validator,
                maxLength: maxLength,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                  border: InputBorder.none,
                  counterText: "",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDocketSelection(BuildContext context) {
    controller.fetchAvailableDockets();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Select Dockets", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.availableDockets.length,
                itemBuilder: (context, index) {
                  var docket = controller.availableDockets[index];
                  return Obx(() {
                    bool isSelected = controller.selectedDockets.contains(docket);
                    return CheckboxListTile(
                      title: Text("Docket No: ${docket.dockno}"),
                      subtitle: Text("Bkg Date: ${docket.bkg_Date} | Pkgs: ${docket.pkgsno}"),
                      value: isSelected,
                      onChanged: (val) => controller.toggleDocketSelection(docket),
                    );
                  });
                },
              )),
            ),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text("Done"),
            )
          ],
        ),
      ),
    );
  }
}
