import 'package:flutter/material.dart';
import 'package:ppfo_math_app/services/math_engine.dart';

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

  void _analyzeNumber() {
    if (_numberController.text.isEmpty) return;
    
    setState(() {
      _isCalculating = true;
      _result = 'جاري التحليل...';
    });

    // محاكاة عملية حسابية (ستستبدل بالمحرك الحقيقي)
    Future.delayed(const Duration(milliseconds: 500), () {
      final number = int.tryParse(_numberController.text) ?? 0;
      final factors = mathEngine.factorize(number);
      final isPrime = mathEngine.isPrime(number);
      
      setState(() {
        _isCalculating = false;
        _result = '''
🔢 العدد: $number
${isPrime ? '✅ أولي' : '🔸 مركب'}

📊 العوامل الأولية: $factors

🧮 التحليل: ${mathEngine.getFactorizationString(factors)}

تم الحساب بواسطة PPFO v25.0
        ''';
      });
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
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, '/about'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // شعار التطبيق
            Card(
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
            
            // حقل الإدخال
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'أدخل العدد المراد تحليله',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _numberController.clear(),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // زر التحليل
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isCalculating ? null : _analyzeNumber,
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
                    : const Text(
                        '🔍 تحليل العدد',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // عرض النتائج
            Expanded(
              child: Card(
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
}
