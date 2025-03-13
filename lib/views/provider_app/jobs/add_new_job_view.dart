import 'package:b2b_partenership/controller/provider/jobs/add_new_job_controller.dart';
import 'package:b2b_partenership/core/enums/job_gender_enum.dart';
import 'package:b2b_partenership/core/enums/jobs_contract_type_enum.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/models/city_model.dart';
import 'package:b2b_partenership/models/country_model.dart';
import 'package:b2b_partenership/models/specialize_model.dart';
import 'package:b2b_partenership/models/sub_specialize_model.dart';
import 'package:b2b_partenership/widgets/select_city_widget.dart';
import 'package:b2b_partenership/widgets/select_country_widget.dart';
import 'package:b2b_partenership/widgets/select_specialization_widget.dart';
import 'package:b2b_partenership/widgets/select_sup_specialization_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddNewJobView extends StatelessWidget {
  const AddNewJobView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewJobController>(
      init: AddNewJobController(),
      builder: (AddNewJobController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            iconTheme: IconThemeData(color: whiteColor),
            title: Text(
              controller.model != null ? 'Edit Job'.tr : 'Add New Job'.tr,
              style: TextStyle(
                color: whiteColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 10.h,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  // Job Title
                  _buildTextField(
                    controller.titleController,
                    "Job Title".tr,
                    "Enter job title".tr,
                  ),

                  // Description
                  _buildTextField(
                    controller.descriptionController,
                    "Description".tr,
                    "Enter job description".tr,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                  ),

                  // Skills
                  _buildTextField(
                    controller.skillsController,
                    "Required Skills".tr,
                    "Enter required skills (comma separated)".tr,
                  ),

                  // Experience
                  _buildTextField(
                    controller.experienceController,
                    "Experience (years)".tr,
                    "Enter years of experience".tr,
                    keyboardType: TextInputType.number,
                  ),

                  // Contract Type
                  _buildDropdownContractType(controller),

                  // Expiry Date
                  _buildDatePicker(controller),

                  // Gender Selection
                  _buildDropdownGender(controller),

                  // Salary (Optional)
                  _buildTextField(
                    controller.salaryController,
                    "Salary (Optional)".tr,
                    "Enter salary".tr,
                    keyboardType: TextInputType.number,
                    isOptional: true,
                  ),
                  Gap(12.h),
                  Row(
                    children: [
                      Expanded(
                        child: Skeletonizer(
                          enabled: controller.statusRequestCountry ==
                              StatusRequest.loading,
                          child: SelectCountryWidget(
                            enabled: false,
                            value: controller.selectedCountry ?? CountryModel(),
                            models: controller.countries,
                            onChanged: (val) {
                              controller.onCountryChanged(val);
                            },
                          ),
                        ),
                      ),
                      Gap(8.w),
                      Expanded(
                        child: Skeletonizer(
                          enabled: controller.statusRequestCity ==
                              StatusRequest.loading,
                          child: SelectCityWidget(
                            value: controller.selectedCity ?? CityModel(),
                            models: controller.cities,
                            onChanged: (val) {
                              controller.onCityChanged(val);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(12.h),
                  Skeletonizer(
                    enabled: controller.statusRequestSpecialization ==
                        StatusRequest.loading,
                    child: SelectSpecializationWidget(
                      value: controller.selectedSpecialization ??
                          SpecializeModel(),
                      models: controller.specializations,
                      onChanged: (val) {
                        controller.onSpecializeChanged(val);
                      },
                    ),
                  ),
                  Gap(12.h),

                  Skeletonizer(
                    enabled: controller.statusRequestSupSpecialization ==
                        StatusRequest.loading,
                    child: SelectSupSpecializationWidget(
                      value: controller.selectedSubSpecialization ??
                          SubSpecializeModel(),
                      models: controller.subSpecializations,
                      onChanged: (val) {
                        controller.onSubSpecializeChanged(val);
                      },
                    ),
                  ),
                  Gap(30),

                  SizedBox(height: 20),

                  // Submit Button
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            height: 0.09.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLoadingButton(
                  onPressed: () {
                    if (controller.model != null) {
                      return controller.editJob();
                    }
                    return controller.addNewJob();
                  },
                  text: controller.model != null ? "Save".tr : "Add".tr,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Text Field Widget
  Widget _buildTextField(
      TextEditingController controller, String label, String hint,
      {TextInputType keyboardType = TextInputType.text,
      int maxLines = 1,
      bool isOptional = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (!isOptional && (value == null || value.isEmpty)) {
            return "This field is required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  // Dropdown for Contract Type
  Widget _buildDropdownContractType(AddNewJobController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<JobsContractTypeEnum>(
        decoration: InputDecoration(
          labelText: "Contract Type",
          border: OutlineInputBorder(),
        ),
        value: controller.selectedContractType,
        items: JobsContractTypeEnum.values.map((type) {
          return DropdownMenuItem(
            value: type,
            child: Text(type.text),
          );
        }).toList(),
        onChanged: (value) {
          controller.selectedContractType = value;
        },
        validator: (value) =>
            value == null ? "Please select a contract type" : null,
      ),
    );
  }

  // Date Picker for Expiry Date
  Widget _buildDatePicker(AddNewJobController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: TextFormField(
        controller: controller.expiryDateController,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: Get.context!,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            controller.expiryDateController.text =
                DateFormat("yyyy-MM-dd").format(pickedDate);
          }
        },
        validator: (value) => value == null || value.isEmpty
            ? "Please select an expiry date"
            : null,
        decoration: InputDecoration(
          labelText: "Expiry Date",
          hintText: "Select expiry date",
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
      ),
    );
  }

  // Dropdown for Gender Selection
  Widget _buildDropdownGender(AddNewJobController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<JobGenderEnum>(
        decoration: InputDecoration(
          labelText: "Preferred Gender",
          border: OutlineInputBorder(),
        ),
        value: controller.selectedGender,
        items: JobGenderEnum.values.map((gender) {
          return DropdownMenuItem(
            value: gender,
            child: Text(
              gender.text,
            ),
          );
        }).toList(),
        onChanged: (value) {
          controller.selectedGender = value;
        },
        validator: (value) => value == null ? "Please select a gender" : null,
      ),
    );
  }
}
