import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _chatNotifications = true;
  bool _adNotifications = true;
  bool _promoNotifications = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات الإشعارات'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الإشعارات العامة
            _buildSectionTitle('الإشعارات العامة'),
            _buildSettingsCard([
              _buildSwitchItem(
                icon: Icons.notifications_active,
                iconColor: Colors.blue,
                title: 'الإشعارات الفورية',
                subtitle: 'استلام الإشعارات على الجهاز',
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
              ),
              const Divider(height: 1),
              _buildSwitchItem(
                icon: Icons.email_outlined,
                iconColor: Colors.green,
                title: 'البريد الإلكتروني',
                subtitle: 'استلام الإشعارات عبر البريد',
                value: _emailNotifications,
                onChanged: (value) {
                  setState(() {
                    _emailNotifications = value;
                  });
                },
              ),
              const Divider(height: 1),
              _buildSwitchItem(
                icon: Icons.sms_outlined,
                iconColor: Colors.orange,
                title: 'الرسائل النصية',
                subtitle: 'استلام الإشعارات عبر SMS',
                value: _smsNotifications,
                onChanged: (value) {
                  setState(() {
                    _smsNotifications = value;
                  });
                },
              ),
            ]),
            const SizedBox(height: 16),

            // إشعارات التطبيق
            _buildSectionTitle('إشعارات التطبيق'),
            _buildSettingsCard([
              _buildSwitchItem(
                icon: Icons.chat_bubble_outline,
                iconColor: Colors.purple,
                title: 'الرسائل',
                subtitle: 'إشعارات الرسائل الجديدة',
                value: _chatNotifications,
                onChanged: (value) {
                  setState(() {
                    _chatNotifications = value;
                  });
                },
              ),
              const Divider(height: 1),
              _buildSwitchItem(
                icon: Icons.campaign_outlined,
                iconColor: Colors.teal,
                title: 'الإعلانات',
                subtitle: 'إشعارات الإعلانات والردود',
                value: _adNotifications,
                onChanged: (value) {
                  setState(() {
                    _adNotifications = value;
                  });
                },
              ),
              const Divider(height: 1),
              _buildSwitchItem(
                icon: Icons.local_offer_outlined,
                iconColor: Colors.pink,
                title: 'العروض والتخفيضات',
                subtitle: 'إشعارات العروض الخاصة',
                value: _promoNotifications,
                onChanged: (value) {
                  setState(() {
                    _promoNotifications = value;
                  });
                },
              ),
            ]),
            const SizedBox(height: 24),

            // معلومات
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'يمكنك تخصيص الإشعارات حسب تفضيلاتك. سيتم حفظ إعداداتك تلقائياً.',
                      style: TextStyle(
                        color: isDark ? Colors.blue[200] : Colors.blue[800],
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[500],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.goldColor,
      ),
    );
  }
}
