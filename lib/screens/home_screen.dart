import 'package:flutter/material.dart';
import '../services/math_engine.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MathEngine mathEngine = MathEngine();
  final TextEditingController _numberController = TextEditingController();
  String _result = 'مرحباً في PPFO v25.0! 🔢\n\nاختر عملية وأدخل عدداً لبدء التحليل الرياضي.';
  bool _isCalculating = false;
  String _selectedOperation = 'factorize';

  void _performCalculation() {
    if (_numberController.text.isEmpty) return;
    
    setState(() {
      _isCalculating = true;
      _result = 'جاري الحساب... ⏳';
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      try {
        final input = _numberController.text;
        String result = '';
        
        switch (_selectedOperation) {
          case 'factorize':
            final number = int.tryParse(input) ?? 0;
            if (number < 2) {
              result = '❌ الرجاء إدخال عدد أكبر من 1';
            } else {
              final factors = mathEngine.factorize(number);
              final isPrime = mathEngine.isPrime(number);
              result = '''
🔢 **العدد:** $number
${isPrime ? '✅ **عدد أولي**' : '🔸 **عدد مركب**'}

📊 **العوامل الأولية:** $factors

🧮 **التحليل:** ${mathEngine.getFactorizationString(factors)}
''';
            }
            break;
            
          case 'taylor_exp':
            final x = double.tryParse(input) ?? 0;
            final value = mathEngine.taylorExp(x);
            result = '''
📈 **متسلسلة تايلور لـ e^$x**

**القيمة التقريبية:** ${value.toStringAsFixed(6)}
**الدقة (10 حدود):** ${mathEngine.taylorExp(x, terms: 10).toStringAsFixed(6)}
**الدقة (20 حدود):** ${mathEngine.taylorExp(x, terms: 20).toStringAsFixed(6)}
''';
            break;
            
          case 'fibonacci':
            final n = int.tryParse(input) ?? 0;
            if (n < 0) {
              result = '❌ الرجاء إدخال عدد غير سالب';
            } else {
              final value = mathEngine.fibonacci(n);
              result = '''
🧮 **متتالية فيبوناتشي**

**F($n) =** $value
''';
            }
            break;
            
          case 'zeta':
            final s = double.tryParse(input) ?? 2;
            if (s <= 1) {
              result = '❌ دالة زيتا غير معرفة لـ s ≤ 1';
            } else {
              final value = mathEngine.zeta(s);
              result = '''
🎯 **دالة زيتا لريمان**

**ζ($s) ≈** ${value.toStringAsFixed(6)}
**الدقة (100 حد):** ${mathEngine.zeta(s, terms: 100).toStringAsFixed(6)}
''';
            }
            break;
        }
        
        if (!result.contains('❌')) {
          result += '\n\n---\n*تم الحساب بواسطة PPFO v25.0 - د. سعودي محمد*';
        }
        
        setState(() {
          _isCalculating = false;
          _result = result;
        });
      } catch (e) {
        setState(() {
          _isCalculating = false;
          _result = '❌ **خطأ في الحساب:** $e\n\nالرجاء التحقق من المدخلات والمحاولة مرة أخرى.';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPFO v25.0 - نظام رياضي متكامل'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // شعار التطبيق
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.calculate, size: 40, color: Colors.blue),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PPFO v25.0',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            'نظام رياضي متكامل - د. سعودي محمد',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // اختيار العملية
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'اختر العملية الرياضية:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: _selectedOperation,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          value: 'factorize',
                          child: Text('🔢 تحليل العدد إلى عوامل أولية'),
                        ),
                        DropdownMenuItem(
                          value: 'taylor_exp',
                          child: Text('📈 متسلسلة تايلور لـ e^x'),
                        ),
                        DropdownMenuItem(
                          value: 'fibonacci',
                          child: Text('🧮 متتالية فيبوناتشي'),
                        ),
                        DropdownMenuItem(
                          value: 'zeta',
                          child: Text('🎯 دالة زيتا لريمان'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedOperation = value!;
                          _numberController.clear();
                          _result = 'اختر عملية وأدخل عدداً لبدء التحليل الرياضي.';
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // حقل الإدخال
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: _getInputLabel(),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _numberController.clear();
                    setState(() {
                      _result = 'اختر عملية وأدخل عدداً لبدء التحليل الرياضي.';
                    });
                  },
                ),
                prefixIcon: const Icon(Icons.numbers),
              ),
              onSubmitted: (_) => _performCalculation(),
            ),
            
            const SizedBox(height: 16),
            
            // زر الحساب
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isCalculating ? null : _performCalculation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isCalculating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        _getButtonText(),
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // عرض النتائج
            Expanded(
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      _result,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _getInputLabel() {
    switch (_selectedOperation) {
      case 'factorize':
      case 'fibonacci':
        return 'أدخل عدد صحيح موجب';
      case 'taylor_exp':
        return 'أدخل قيمة x (حقيقية)';
      case 'zeta':
        return 'أدخل قيمة s (حقيقية, >1)';
      default:
        return 'أدخل القيمة';
    }
  }
  
  String _getButtonText() {
    switch (_selectedOperation) {
      case 'factorize':
        return '🔍 تحليل العدد';
      case 'taylor_exp':
        return '📈 حساب e^x';
      case 'fibonacci':
        return '🧮 حساب فيبوناتشي';
      case 'zeta':
        return '🎯 حساب دالة زيتا';
      default:
        return 'إجراء الحساب';
    }
  }
}
