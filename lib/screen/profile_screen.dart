import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Profile',
                    style: AppTextStyles.headlineLarge,
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Profile Header
              _buildProfileHeader(),

              const SizedBox(height: 40),

              // Stats
              _buildStats(),

              const SizedBox(height: 40),

              // Settings
              Expanded(
                child: _buildSettingsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: AppGradients.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'John Doe',
          style: AppTextStyles.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Beginner Meditator',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('12', 'Sessions'),
          _buildStatItem('4h 30m', 'Time'),
          _buildStatItem('7', 'Streak'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsList() {
    final settingsItems = [
      {'icon': Icons.palette_rounded, 'title': 'Theme', 'subtitle': 'Dark'},
      {'icon': Icons.notifications_rounded, 'title': 'Notifications', 'subtitle': 'On'},
      {'icon': Icons.volume_up_rounded, 'title': 'Sounds', 'subtitle': 'Default'},
      {'icon': Icons.timer_rounded, 'title': 'Reminders', 'subtitle': 'Set Daily'},
      {'icon': Icons.help_rounded, 'title': 'Help & Support', 'subtitle': ''},
      {'icon': Icons.info_rounded, 'title': 'About', 'subtitle': 'Version 1.0.0'},
    ];

    return ListView.builder(
      itemCount: settingsItems.length,
      itemBuilder: (context, index) {
        final item = settingsItems[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(item['icon'] as IconData, color: AppColors.primary),
            title: Text(
              item['title'] as String,
              style: AppTextStyles.bodyLarge,
            ),
            subtitle: item['subtitle'].toString().isNotEmpty
                ? Text(
              item['subtitle'] as String,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            )
                : null,
            trailing: const Icon(Icons.arrow_forward_ios_rounded,
                color: AppColors.textSecondary, size: 16),
            onTap: () {},
          ),
        );
      },
    );
  }
}