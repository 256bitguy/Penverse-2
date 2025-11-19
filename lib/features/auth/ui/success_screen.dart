// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import '../../../../core/utils/responsive_utils.dart';
// import '../../../../core/widgets/custom_button.dart';
// import '../../../core/store/app_state.dart';
// import '../../home/presentation/screens/home_screen.dart';
//  import '../ui/viewmodel/register_viewmodel.dart';

// class SuccessScreen extends StatelessWidget {
//   final String? email;
//   final String? password;

//   const SuccessScreen({
//     super.key,
//     this.email,
//     this.password,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, RegisterViewModel>(
//       converter: (store) => RegisterViewModel.fromStore(store, context),
//       builder: (context, vm) {
//         return Scaffold(
//           backgroundColor: Theme.of(context).colorScheme.surface,
//           body: SafeArea(
//             child: Center(
//               child: SingleChildScrollView(
//                 padding: ResponsiveUtils.getScreenPadding(context),
//                 child: Container(
//                   width: ResponsiveUtils.getFormWidth(context),
//                   constraints: const BoxConstraints(maxWidth: 600),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/images/success.png',
//                         height: ResponsiveUtils.isMobile(context) ? 200 : 250,
//                         width: ResponsiveUtils.isMobile(context) ? 200 : 250,
//                       ),
//                       const SizedBox(height: 32),
//                       Text(
//                         'Successfully verified',
//                         style: Theme.of(context).textTheme.displayLarge,
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Start a journey of writing, events, competitions and explore a role of event team member',
//                         style: Theme.of(context).textTheme.bodyLarge,
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 48),

//                       /// 🔽 Use RegisterViewModel instead of Provider
//                       vm.isLoading
//                           ? const CircularProgressIndicator()
//                           : CustomButton(
//                               text: 'Start',
//                               onPressed: () {
//                                 if (email != null && password != null) {
//                                   vm.onRegister(email!, password!);
//                                 }

//                                 /// ✅ Navigate if already registered/logged in
//                                 if (vm.isLoggedIn) {
//                                   Navigator.of(context).pushAndRemoveUntil(
//                                     MaterialPageRoute(
//                                       builder: (context) => const HomePage(),
//                                     ),
//                                     (route) => false,
//                                   );
//                                 }
//                               },
//                             ),

//                       if (vm.errorMessage != null)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 16),
//                           child: Text(
//                             vm.errorMessage!,
//                             style: const TextStyle(color: Colors.red),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
