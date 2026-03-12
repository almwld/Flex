import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountController = TextEditingController();
  String? _selectedMethod;
  String? _selectedCurrency;

  final List<Map<String, dynamic>> _withdrawMethods = [
    {
      'name': 'بنك الكريمي',
      'icon': Icons.account_balance,
      'color': Colors.green,
      'description': 'سحب إلى حساب بنك الكريمي',
    },
    {
      'name': 'بنك التضامن',
      'icon': Icons.account_balance,
      'color': Colors.blue,
      'description': 'سحب إلى حساب بنك التضامن',
    },
    {
      'name': 'كريمي موبايل',
      'icon': Icons.phone_android,
      'color': Colors.orange,
      'description': 'سحب إلى كريمي موبايل',
    },
    {
      'name': 'جيبي',
      'icon': Icons.wallet,
      'color': Colors.purple,
      'description': 'سحب إلى محفظة جيبي',
    },
    {
      'name': 'نقدي',
      'icon': Icons.money,
      'color': Colors.teal,
      'description': 'سحب نقدي من الوكلاء',
    },
  ];

  final List<Map<String, dynamic>> _currencies = [
    {'name': 'ريال يمني', 'code': 'YER', 'flag': '🇾🇪'},
    {'name': 'ريال سعودي', 'code': 'SAR', 'flag': '🇸🇦'},
    {'name': 'دولار أمريكي', 'code': 'USD', 'flag': '🇺🇸'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سحب الأموال'),
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
                            ? AppTheme.goldColor.withOpacity(0.2)
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
            // حقل المبلغ
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
            // اختيار طريقة السحب
            Text(
              'طريقة السحب',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _withdrawMethods.length,
              itemBuilder: (context, index) {
                final method = _withdrawMethods[index];
                final isSelected = _selectedMethod == method['name'];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMethod = method['name'];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? method['color'].withOpacity(0.2)
                          : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? method['color']
                            : (isDark ? Colors.grey[800]! : Colors.grey[300]!),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: method['color'].withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            method['icon'],
                            color: method['color'],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                method['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                method['description'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: AppTheme.goldColor,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            // معلومات إضافية
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.amber.withOpacity(0.1) : Colors.amber.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.amber),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'رسوم السحب: 1% من المبلغ (حد أدنى 100 ر.ي)',
                      style: TextStyle(
                        color: isDark ? Colors.amber[200] : Colors.amber[800],
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // زر التأكيد
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: _selectedMethod != null && _selectedCurrency != null
                    ? () {
                        // TODO: Implement withdraw
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'متابعة السحب',
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
    _amountController.dispose();
    super.dispose();
  }
}
