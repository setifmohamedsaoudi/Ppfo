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
  String _result = 'النتيجة ستظهر هنا...';
  bool _isCalculating = false;
  String _selectedOperation = 'factorize';

  void _performCalculation() {
    if (_numberController.text.isEmpty) return;
    
    setState(() {
      _isCalculating = true;
      _result = 'جاري الحساب...';
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      try {
        final input = _numberController.text;
        String result = '';
        
        switch (_selectedOperation) {
          case 'factorize':
            final number = int.tryParse(input) ?? 0;
            final factors = mathEngine.factorize(number);
            final isPrime = mathEngine.isPrime(number);
            result = '''
🔢 العدد: $number
${isPrime ? '✅ أولي' : '🔸 مركب'}

📊 العوامل الأولية: $factors

🧮 التحليل: ${mathEngine.getFactorizationString(factors)}
''';
            break;
            
          case 'taylor_exp':
            final x = double.tryParse(input) ?? 0;
            final value = mathEngine.taylorExp(x);
            result = '''
📈 متسلسلة تايلور لـ e^$x
القيمة التقريبية: ${value.toStringAsFixed(6)}
القيمة الحقيقية: ${mathEngine.taylorExp(x, terms: 20).toStringAsFixed(6)}
''';
            break;
            
          case 'taylor_sin':
            final x = double.tryParse(input) ?? 0;
            final value = mathEngine.taylorSin(x);
            result = '''
📈 متسلسلة تايلور لـ sin($x)
القيمة التقريبية: ${value.toStringAsFixed(6)}
''';
            break;
            
          case 'fibonacci':
            final n = int.tryParse(input) ?? 0;
            final value = mathEngine.fibonacci(n);
            result = '''
🧮 متتالية فيبوناتشي
F($n) = $value
''';
            break;
            
          case 'zeta':
            final s = double.tryParse(input) ?? 2;
            final value = mathEngine.zeta(s);
            result = '''
🎯 دالة زيتا لريمان
ζ($s) ≈ ${value.toStringAsFixed(6)}
''';
            break;
        }
        
        result += '\nتم الحساب بواسطة PPFO v25.0 - د. سعودي محمد';
        
        setState(() {
          _isCalculating = false;
          _result = result;
        });
      } catch (e) {
        setState(() {
          _isCalculating = false;
          _result = '❌ خطأ في الحساب: $e';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPFO v25.0 - نظام رياضي متكامل'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // التنقل بين الشاشات
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'about',
                child: Text('عن التطبيق'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // شعار التطبيق
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.calculate, size: 64, color: Colors.blue),
                    const SizedBox(height: 8),
                    const Text(
                      'PPFO v25.0',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'نظام رياضي متكامل - د. سعودي محمد',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // اختيار العملية
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'اختر العملية:',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                          value: 'taylor_sin',
                          child: Text('📈 متسلسلة تايلور لـ sin(x)'),
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
                  onPressed: () => _numberController.clear(),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // زر الحساب
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isCalculating ? null : _performCalculation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                        style: const TextStyle(fontSize: 18),
                      ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // عرض النتائج
            Expanded(
              child: Card(
                elevation: 4,
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
        return 'أدخل عدد صحيح';
      case 'taylor_exp':
      case 'taylor_sin':
        return 'أدخل قيمة x';
      case 'zeta':
        return 'أدخل قيمة s';
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
      case 'taylor_sin':
        return '📈 حساب sin(x)';
      case 'fibonacci':
        return '🧮 حساب فيبوناتشي';
      case 'zeta':
        return '🎯 حساب دالة زيتا';
      default:
        return 'إجراء الحساب';
    }
  }
}
