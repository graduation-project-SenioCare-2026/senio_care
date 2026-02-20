import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/home/views/screens/service_provider_home_tap.dart';
import 'package:senio_care/features/service_provider/presentation/service_provider_home/taps/profile/views/screens/service_provider_profile_tab.dart';

import '../../../../core/common_widgets/bg_gradient.dart';
import '../../../../core/theme/app_colors.dart';

class ServiceProviderMainLayout extends StatefulWidget {
  const ServiceProviderMainLayout({super.key});

  @override
  State<ServiceProviderMainLayout> createState() => _ServiceProviderMainLayoutState();
}

class _ServiceProviderMainLayoutState extends State<ServiceProviderMainLayout> {
  int currentIndex = 0;
  List<Widget> taps = [
    ServiceProviderHomeTap(),
    ServiceProviderProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(midGradientColor: AppColors.white, midGradientAlpha: 100),
        Scaffold(
          body: taps[currentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BottomNavigationBar(
                  currentIndex: currentIndex,
                  type: BottomNavigationBarType.fixed,
                  elevation: 10,
                  backgroundColor: AppColors.white,
                  selectedItemColor: AppColors.gradientEnd,
                  unselectedItemColor: AppColors.black.withAlpha(150),
                  selectedIconTheme: IconThemeData(size: 30),
                  unselectedIconTheme: IconThemeData(size: 25),
                   showUnselectedLabels: true,
                  showSelectedLabels: true,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: "home".tr()),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: "profile".tr()),
                  ],
                )
            ),
          ),
        ),
      ],
    );
  }
}



















// class ServiceProviderHome extends StatelessWidget {
//   const ServiceProviderHome({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final serviceProvider = ProfileManager().serviceProvider;
//     final user = UserManager().user;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Service Provider Home"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20),
//
//             // Avatar
//             CircleAvatar(
//               radius: 55,
//               backgroundImage: (user?.avatar != null &&
//                   user!.avatar!.isNotEmpty)
//                   ? NetworkImage(user.avatar!)
//                   : null,
//               child: (user?.avatar == null ||
//                   user!.avatar!.isEmpty)
//                   ? const Icon(Icons.person, size: 50)
//                   : null,
//             ),
//
//             const SizedBox(height: 16),
//
//             // Name
//             Text(
//               user?.name ?? "Unknown User",
//               style: Theme.of(context)
//                   .textTheme
//                   .titleLarge
//                   ?.copyWith(fontWeight: FontWeight.bold),
//             ),
//
//             const SizedBox(height: 4),
//
//             // Role
//             Text(
//               user?.role?.name ?? "Role",
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyMedium
//                   ?.copyWith(color: Colors.grey),
//             ),
//
//             const SizedBox(height: 24),
//
//             // Info Card
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _infoRow(
//                       icon: Icons.phone,
//                       label: "Phone",
//                       value: serviceProvider?.phoneNumber ?? "Not provided",
//                     ),
//                     const Divider(),
//                     _infoRow(
//                       icon: Icons.work,
//                       label: "Specialization",
//                       value: serviceProvider?.specialization ?? "Not provided",
//                     ),
//                     const Divider(),
//                     _infoRow(
//                       icon: Icons.email,
//                       label: "Email",
//                       value: user?.email ?? "Not provided",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _infoRow({
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     return Row(
//       children: [
//         Icon(icon, size: 20, color: Colors.grey),
//         const SizedBox(width: 8),
//         Text(
//           "$label:",
//           style: const TextStyle(fontWeight: FontWeight.w600),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Text(
//             value,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }