// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../core/constants/app_color.dart';
// import '../../providers/auth_provider.dart';
// import '../../widgets/common/custom_button.dart';
// import '../../widgets/common/custom_text_field.dart';
// import '../../../routes/app_routes.dart';

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});

//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final auth = context.watch<AuthProvider>();

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 40),

//               // Title
//               const Text(
//                 'Welcome Back 👋',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Login to your account',
//                 style: TextStyle(color: Colors.grey[500]),
//               ),
//               const SizedBox(height: 40),

//               // Fields
//               CustomTextField(
//                 hint: 'Email',
//                 icon: Icons.email_outlined,
//                 controller: _emailCtrl,
//               ),
//               const SizedBox(height: 16),
//               CustomTextField(
//                 hint: 'Password',
//                 icon: Icons.lock_outline,
//                 controller: _passwordCtrl,
//                 isPassword: true,
//               ),
//               const SizedBox(height: 12),

//               // Error message
//               if (auth.errorMessage != null)
//                 Text(
//                   auth.errorMessage!,
//                   style: const TextStyle(color: AppColors.error),
//                 ),

//               const SizedBox(height: 24),

//               // Login Button
//               CustomButton(
//                 label: 'Login',
//                 isLoading: auth.isLoading,
//                 onTap: () async {
//                   final success = await auth.login(
//                     _emailCtrl.text,
//                     _passwordCtrl.text,
//                   );
//                   if (success) {
//                     Navigator.pushReplacementNamed(context, AppRoutes.home);
//                   }
//                 },
//               ),
//               const SizedBox(height: 20),

//               // Go to Register
//               Center(
//                 child: GestureDetector(
//                   onTap: () => Navigator.pushNamed(context, AppRoutes.register),
//                   child: RichText(
//                     text: TextSpan(
//                       text: "Don't have an account? ",
//                       style: TextStyle(color: Colors.grey[500]),
//                       children: const [
//                         TextSpan(
//                           text: 'Register',
//                           style: TextStyle(
//                             color: AppColors.primary,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
