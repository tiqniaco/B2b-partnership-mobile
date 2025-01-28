import 'package:b2b_partenership/controller/auth/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientSignupView extends StatelessWidget {
  const ClientSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GetBuilder<SignupController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Setup Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: controller.previousStep,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                      'Step ${controller.currentStep + 1} of ${controller.providerSteps.length}  '),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (controller.currentStep + 1) /
                          controller.providerSteps.length,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: controller.providerSteps[controller.currentStep],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: controller.nextStep,
                child: Text(controller.currentStep ==
                        controller.providerSteps.length - 1
                    ? 'Finish'
                    : 'Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

// class StepOne extends StatelessWidget {
//   const StepOne({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Upload Your Photo',
//         style: Theme.of(context).textTheme.headlineSmall,
//       ),
//     );
//   }
// }

// class StepTwo extends StatelessWidget {
//   const StepTwo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Enter Your Details',
//         style: Theme.of(context).textTheme.headlineSmall,
//       ),
//     );
//   }
//}

// class StepThree extends StatelessWidget {
//   const StepThree({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Review & Submit',
//         style: Theme.of(context).textTheme.headlineSmall,
//       ),
//     );
//   }
// }
