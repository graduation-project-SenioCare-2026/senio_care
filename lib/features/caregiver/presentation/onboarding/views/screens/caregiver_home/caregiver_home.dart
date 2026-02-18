import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senio_care/config/di/di.dart';
import 'package:senio_care/core/user/profile_manager.dart';
import 'package:senio_care/core/user/user_manager.dart';
import 'package:senio_care/features/auth/presentation/view_model/login_view_model/auth_bloc.dart';
import 'package:senio_care/features/auth/presentation/view_model/login_view_model/auth_state.dart';

class CaregiverHome extends StatelessWidget {
  const CaregiverHome({super.key});

  @override
  Widget build(BuildContext context) {
    final caregiver = ProfileManager().caregiver;
    final user = UserManager().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Caregiver Home"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => getIt<AuthBloc>(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  /// Avatar
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: (user?.avatar != null &&
                        user!.avatar!.isNotEmpty)
                        ? NetworkImage(user.avatar!)
                        : null,
                    child: (user?.avatar == null ||
                        user!.avatar!.isEmpty)
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),

                  const SizedBox(height: 16),

                  /// Name
                  Text(
                    user?.name ?? "Unknown User",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 4),

                  /// Role
                  Text(
                    user?.role?.name ?? "Role",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(height: 24),

                  /// Info Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow(
                            icon: Icons.phone,
                            label: "Phone",
                            value:
                            caregiver?.phoneNumber ?? "Not provided",
                          ),
                          const Divider(),
                          _infoRow(
                            icon: Icons.family_restroom,
                            label: "Relationship",
                            value:
                            caregiver?.relationship ?? "Not provided",
                          ),
                          const Divider(),
                          _infoRow(
                            icon: Icons.elderly,
                            label: "Elder ID",
                            value: "caregiver!.elders!.length"
                          ),
                          const Divider(),
                          _infoRow(
                            icon: Icons.email,
                            label: "Email",
                            value: user?.email ?? "Not provided",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          "$label:",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}