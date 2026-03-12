import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final _searchController = TextEditingController();
  String? _expandedFaq;

  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'كيف يمكنني إنشاء حساب جديد؟',
      'answer': 'يمكنك إنشاء حساب جديد بالنقر على "سجل الآن" في شاشة تسجيل الدخول، ثم إدخال بياناتك المطلوبة والتحقق من رقم هاتفك.',
    },
    {
      'question': 'كيف أضيف إعلاناً جديداً؟',
      'answer': 'انقر على زر "+" في أسفل الشاشة، ثم املأ تفاصيل الإعلان وأضف الصور، واختر الفئة والمدينة المناسبة.',
    },
    {
      'question': 'كيف يمكنني شحن رصيد محفظتي؟',
      'answer': 'انتقل إلى قسم "المحفظة"، اختر "الشحن"، ثم اختر طريقة الدفع المناسبة وأدخل المبلغ المطلوب.',
    },
    {
      'question': 'هل يمكنني التسجيل كضيف؟',
      'answer': 'نعم، يمكنك استعراض التطبيق كضيف، لكن لن تتمكن من إضافة إعلانات أو استخدام المحفظة الإلكترونية.',
    },
    {
      'question': 'كيف أتواصل مع البائع؟',
      'answer': 'يمكنك التواصل مع البائع عبر خاصية المحادثة المدمجة في التطبيق، أو الاتصال المباشر إذا كان البائع قد فعّل هذه الخاصية.',
    },
    {
      'question': 'ما هي طرق الدفع المتاحة؟',
      'answer': 'نحن ندعم عدة طرق دفع: بنك الكريمي، بنك التضامن، كريمي موبايل، جيبي، والدفع النقدي عبر الوكلاء المعتمدين.',
    },
    {
      'question': 'كيف أبلغ عن إعلان مخالف؟',
      'answer': 'يمكنك الإبلاغ عن أي إعلان مخالف بالنقر على زر "الإبلاغ" في صفحة الإعلان، وسنقوم بمراجعة البلاغ في أقرب وقت.',
    },
    {
      'question': 'هل يمكنني تعديل إعلاني بعد نشره؟',
      'answer': 'نعم، يمكنك تعديل إعلانك من خلال الذهاب إلى "إعلاناتي" في صفحة حسابك، ثم اختيار الإعلان والنقر على "تعديل".',
    },
  ];

  final List<Map<String, dynamic>> _contactMethods = [
    {
      'icon': Icons.phone,
      'title': 'الهاتف',
      'value': '777-123-456',
      'color': Colors.green,
    },
    {
      'icon': Icons.email,
      'title': 'البريد الإلكتروني',
      'value': 'support@flexyemen.com',
      'color': Colors.blue,
    },
    {
      'icon': Icons.chat,
      'title': 'المحادثة المباشرة',
      'value': 'متاح 24/7',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('المساعدة والدعم'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // حقل البحث
            TextField(
              controller: _searchController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'ابحث في الأسئلة الشائعة...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              ),
            ),
            const SizedBox(height: 24),

            // طرق التواصل
            Text(
              'تواصل معنا',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: _contactMethods.map((method) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: method['color'].withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              method['icon'],
                              color: method['color'],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            method['title'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            method['value'],
                            style: TextStyle(
                              fontSize: 10,
                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // الأسئلة الشائعة
            Text(
              'الأسئلة الشائعة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ..._faqs.map((faq) => _buildFaqItem(faq)),
            const SizedBox(height: 24),

            // نموذج التواصل
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'أرسل لنا رسالة',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'الاسم',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'البريد الإلكتروني',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    textAlign: TextAlign.right,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'رسالتك...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم إرسال رسالتك بنجاح!'),
                            backgroundColor: AppTheme.success,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.goldColor,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('إرسال'),
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

  Widget _buildFaqItem(Map<String, dynamic> faq) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isExpanded = _expandedFaq == faq['question'];

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isExpanded) {
            _expandedFaq = null;
          } else {
            _expandedFaq = faq['question'];
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    faq['question'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppTheme.goldColor,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                faq['answer'],
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
