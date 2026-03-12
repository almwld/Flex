import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'الكل';

  final List<String> _filters = [
    'الكل',
    'الشحن',
    'التحويل',
    'السحب',
    'الشراء',
  ];

  final List<Map<String, dynamic>> _transactions = [
    {
      'name': 'تحويل إلى أحمد محمد',
      'amount': -500,
      'date': 'اليوم، 10:30 ص',
      'icon': Icons.send,
      'currency': 'ر.ي',
      'type': 'التحويل',
      'status': 'مكتمل',
    },
    {
      'name': 'إيداع نقدي',
      'amount': 5000,
      'date': 'أمس، 2:45 م',
      'icon': Icons.add,
      'currency': 'ر.ي',
      'type': 'الشحن',
      'status': 'مكتمل',
    },
    {
      'name': 'شراء من متجر الإلكترونيات',
      'amount': -1200,
      'date': 'أمس، 11:20 ص',
      'icon': Icons.shopping_cart,
      'currency': 'ر.س',
      'type': 'الشراء',
      'status': 'مكتمل',
    },
    {
      'name': 'استلام تحويل من خالد',
      'amount': 10000,
      'date': '22/03/2024، 4:15 م',
      'icon': Icons.arrow_downward,
      'currency': 'ر.ي',
      'type': 'التحويل',
      'status': 'مكتمل',
    },
    {
      'name': 'دفع فاتورة الكهرباء',
      'amount': -3500,
      'date': '20/03/2024، 9:00 ص',
      'icon': Icons.receipt,
      'currency': 'ر.ي',
      'type': 'الشراء',
      'status': 'مكتمل',
    },
    {
      'name': 'سحب نقدي',
      'amount': -2000,
      'date': '18/03/2024، 3:30 م',
      'icon': Icons.atm,
      'currency': 'ر.ي',
      'type': 'السحب',
      'status': 'مكتمل',
    },
    {
      'name': 'شحن من بنك الكريمي',
      'amount': 15000,
      'date': '15/03/2024، 11:00 ص',
      'icon': Icons.account_balance,
      'currency': 'ر.ي',
      'type': 'الشحن',
      'status': 'مكتمل',
    },
    {
      'name': 'تحويل إلى فاطمة',
      'amount': -2500,
      'date': '14/03/2024، 5:45 م',
      'icon': Icons.send,
      'currency': 'ر.ي',
      'type': 'التحويل',
      'status': 'مكتمل',
    },
  ];

  List<Map<String, dynamic>> get _filteredTransactions {
    if (_selectedFilter == 'الكل') return _transactions;
    return _transactions.where((t) => t['type'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل العمليات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // فلاتر
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.goldColor
                          : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.goldColor
                            : (isDark ? Colors.grey[800]! : Colors.grey[300]!),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.black
                              : (isDark ? Colors.white : Colors.black87),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // ملخص
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem('الإجمالي', '21,500', Colors.green),
                Container(width: 1, height: 40, color: Colors.grey[700]),
                _buildSummaryItem('الصادر', '9,700', Colors.red),
                Container(width: 1, height: 40, color: Colors.grey[700]),
                _buildSummaryItem('الوارد', '31,200', Colors.green),
              ],
            ),
          ),
          // قائمة العمليات
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredTransactions.length,
              itemBuilder: (context, index) {
                final tx = _filteredTransactions[index];
                return _buildTransactionItem(tx);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> tx) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPositive = tx['amount'] > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isPositive
                  ? Colors.green.withValues(alpha: 0.2)
                  : Colors.red.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              tx['icon'],
              color: isPositive ? Colors.green : Colors.red,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${tx['date']} • ${tx['type']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isPositive ? '+' : ''}${tx['amount'].toStringAsFixed(0)} ${tx['currency']}',
                style: TextStyle(
                  color: isPositive ? Colors.green : (isDark ? Colors.white : Colors.black87),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tx['status'],
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
