import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سياسة الخصوصية'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان
            const Center(
              child: Text(
                'سياسة الخصوصية',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.goldColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'آخر تحديث: 15 يناير 2024',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // المقدمة
            _buildSection(
              title: '1. مقدمة',
              content:
                  'نحن في فلكس يمن نحرص على حماية خصوصيتك وأمن بياناتك الشخصية. توضح هذه السياسة كيفية جمعنا واستخدامنا وحمايتنا لمعلوماتك الشخصية عند استخدامك لتطبيقنا.',
              isDark: isDark,
            ),

            // البيانات التي نجمعها
            _buildSection(
              title: '2. البيانات التي نجمعها',
              content:
                  'نقوم بجمع المعلومات التالية:\n\n• المعلومات الشخصية: الاسم، البريد الإلكتروني، رقم الهاتف، العنوان\n• معلومات الجهاز: نوع الجهاز، نظام التشغيل، معرف الجهاز\n• معلومات الاستخدام: كيفية تفاعلك مع التطبيق\n• معلومات الموقع: المدينة والموقع الجغرافي',
              isDark: isDark,
            ),

            // كيف نستخدم بياناتك
            _buildSection(
              title: '3. كيف نستخدم بياناتك',
              content:
                  'نستخدم بياناتك للأغراض التالية:\n\n• تقديم خدماتنا وتحسينها\n• التواصل معك بخصوص حسابك وإعلاناتك\n• معالجة المدفوعات والتحويلات\n• ضمان الأمان ومنع الاحتيال\n• إرسال إشعارات مهمة وتحديثات',
              isDark: isDark,
            ),

            // حماية البيانات
            _buildSection(
              title: '4. حماية البيانات',
              content:
                  'نحن نتخذ إجراءات أمنية صارمة لحماية بياناتك:\n\n• تشفير جميع البيانات الحساسة\n• استخدام بروتوكولات أمان معتمدة\n• تقييد الوصول للبيانات للموظفين المصرح لهم\n• مراقبة مستمرة للأنظمة للكشف عن أي اختراق',
              isDark: isDark,
            ),

            // مشاركة البيانات
            _buildSection(
              title: '5. مشاركة البيانات',
              content:
                  'لا نقوم ببيع أو تأجير بياناتك الشخصية لأطراف ثالثة. قد نشارك بياناتك فقط في الحالات التالية:\n\n• بموافقتك الصريحة\n• للامتثال للقانون أو طلبات السلطات\n• لحماية حقوقنا أو ممتلكاتنا\n• مع مزودي الخدمات الذين يساعدوننا في تشغيل التطبيق',
              isDark: isDark,
            ),

            // حقوقك
            _buildSection(
              title: '6. حقوقك',
              content:
                  'لديك الحقوق التالية بخصوص بياناتك:\n\n• الوصول إلى بياناتك الشخصية\n• تصحيح أي بيانات غير دقيقة\n• حذف بياناتك (حسب القيود القانونية)\n• الاعتراض على معالجة بياناتك\n• سحب موافقتك في أي وقت',
              isDark: isDark,
            ),

            // ملفات تعريف الارتباط
            _buildSection(
              title: '7. ملفات تعريف الارتباط',
              content:
                  'نستخدم ملفات تعريف الارتباط و التقنيات المماثلة لتحسين تجربتك، وفهم كيفية استخدامك للتطبيق، وتخصيص المحتوى والإعلانات.',
              isDark: isDark,
            ),

            // تغييرات على السياسة
            _buildSection(
              title: '8. تغييرات على السياسة',
              content:
                  'قد نقوم بتحديث هذه السياسة من وقت لآخر. سنو Notifyك بأي تغييرات جوهرية عبر الإشعارات أو البريد الإلكتروني.',
              isDark: isDark,
            ),

            // التواصل معنا
            _buildSection(
              title: '9. التواصل معنا',
              content:
                  'إذا كان لديك أي استفسارات حول سياسة الخصوصية، يمكنك التواصل معنا على:\n\n• البريد الإلكتروني: privacy@flexyemen.com\n• الهاتف: 777-123-456\n• العنوان: صنعاء، اليمن',
              isDark: isDark,
            ),

            const SizedBox(height: 32),

            // موافقة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.goldColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'باستخدامك لتطبيق فلكس يمن، فإنك توافق على سياسة الخصوصية هذه.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.goldColor,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('أوافق'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.goldColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
