import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_dropdown_search.dart';
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
              _buildTextField("Manual DRS No.", controller.manualDrsNoController),
              const SizedBox(height: 16),
              _buildTextField("DRS Date", controller.drsDateController, readOnly: true),
              const SizedBox(height: 16),
              Obx(() => Dropdown(
                text: "Vendor Type".obs,
                list: controller.vendorTypeList.map((e) => e.vendorType).toList(),
                enabled: true.obs,
                isSize: false,
                onChanged: (val) {
                  var selected = controller.vendorTypeList.firstWhere((e) => e.vendorType == val);
                  controller.selectedVendorType.value = selected;
                  controller.fetchVendors(selected.vendorType_Code);
                },
                selectedItem: controller.selectedVendorType.value?.vendorType.obs,
              )),
              const SizedBox(height: 16),
              Obx(() => Dropdown(
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
              )),
              const SizedBox(height: 16),
              Obx(() => Dropdown(
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
              )),
              const SizedBox(height: 16),
              _buildTextField("Driver Name", controller.driverNameController),
              const SizedBox(height: 16),
              _buildTextField("Mobile No.", controller.mobileNoController),
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
              _buildTextField("Loading Supervisor", controller.loadingSupervisorController),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _showDocketSelection(context),
                child: const Text("Select CNotes (Add CNote)"),
              ),
              const SizedBox(height: 16),
              Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.selectedDockets.length,
                itemBuilder: (context, index) {
                  var docket = controller.selectedDockets[index];
                  return ListTile(
                    title: Text("Docket No: ${docket.dockno}"),
                    subtitle: Text("Origin: ${docket.orgncd} | Pkgs: ${docket.pkgsno}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => controller.toggleDocketSelection(docket),
                    ),
                  );
                },
              )),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff232F34),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => controller.submitDRS(),
                  child: const Text("GENERATE DRS", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool readOnly = false}) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
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
