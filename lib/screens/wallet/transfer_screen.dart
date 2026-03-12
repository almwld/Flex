import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String? _selectedCurrency;

  final List<Map<String, dynamic>> _currencies = [
    {'name': 'ريال يمني', 'code': 'YER', 'flag': '🇾🇪'},
    {'name': 'ريال سعودي', 'code': 'SAR', 'flag': '🇸🇦'},
    {'name': 'دولار أمريكي', 'code': 'USD', 'flag': '🇺🇸'},
  ];

  final List<Map<String, dynamic>> _recentRecipients = [
    {'name': 'أحمد محمد', 'phone': '777123456', 'avatar': 'أ'},
    {'name': 'خالد علي', 'phone': '777789012', 'avatar': 'خ'},
    {'name': 'فاطمة أحمد', 'phone': '777345678', 'avatar': 'ف'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تحويل الأموال'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // اختيار العملة
            Text(
              'اختر العملة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _currencies.length,
                itemBuilder: (context, index) {
                  final currency = _currencies[index];
                  final isSelected = _selectedCurrency == currency['code'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCurrency = currency['code'];
                      });
                    },
                    child: Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.goldColor.withValues(alpha: 0.2)
                            : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.goldColor
                              : (isDark ? Colors.grey[800]! : Colors.grey[300]!),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currency['flag'],
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currency['name'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // المستلم
            Text(
              'المستلم',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _recipientController,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'رقم الهاتف أو رقم الحساب',
                prefixIcon: const Icon(Icons.person_outline),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.contacts),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // المستلمين الأخيرين
            Text(
              'المستلمين الأخيرين',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _recentRecipients.length,
                itemBuilder: (context, index) {
                  final recipient = _recentRecipients[index];
                  return GestureDetector(
                    onTap: () {
                      _recipientController.text = recipient['phone'];
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: AppTheme.goldColor.withValues(alpha: 0.2),
                            child: Text(
                              recipient['avatar'],
                              style: const TextStyle(
                                color: AppTheme.goldColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            recipient['name'],
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // المبلغ
            Text(
              'المبلغ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: TextStyle(
                  fontSize: 32,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                ),
                suffixText: _selectedCurrency ?? 'ر.ي',
                suffixStyle: const TextStyle(
                  fontSize: 20,
                  color: AppTheme.goldColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // ملاحظة
            Text(
              'ملاحظة (اختياري)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              textAlign: TextAlign.right,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'أضف ملاحظة للتحويل...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // زر التأكيد
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement transfer
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'تحويل الآن',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
