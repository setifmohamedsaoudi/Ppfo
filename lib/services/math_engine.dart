class MathEngine {
  /// تحليل العدد إلى عوامل أولية
  List<int> factorize(int n) {
    if (n < 2) return [];
    
    List<int> factors = [];
    int number = n;
    
    // التحقق من العدد 2
    while (number % 2 == 0) {
      factors.add(2);
      number ~/= 2;
    }
    
    // التحقق من الأعداد الفردية
    for (int i = 3; i * i <= number; i += 2) {
      while (number % i == 0) {
        factors.add(i);
        number ~/= i;
      }
    }
    
    // إذا بقي عدد أولي
    if (number > 1) {
      factors.add(number);
    }
    
    return factors;
  }
  
  /// التحقق من العدد الأولي
  bool isPrime(int n) {
    if (n < 2) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;
    
    for (int i = 3; i * i <= n; i += 2) {
      if (n % i == 0) return false;
    }
    
    return true;
  }
  
  /// تحويل القائمة إلى صيغة عوامل
  String getFactorizationString(List<int> factors) {
    if (factors.isEmpty) return "غير قابل للتحليل";
    
    Map<int, int> frequency = {};
    for (int factor in factors) {
      frequency[factor] = (frequency[factor] ?? 0) + 1;
    }
    
    List<String> parts = [];
    frequency.forEach((factor, count) {
      if (count > 1) {
        parts.add('$factor^$count');
      } else {
        parts.add('$factor');
      }
    });
    
    return parts.join(' × ');
  }
  
  /// حساب متسلسلة تايلور لـ e^x
  double taylorExp(double x, {int terms = 10}) {
    double result = 0.0;
    double factorial = 1.0;
    
    for (int n = 0; n < terms; n++) {
      if (n > 0) {
        factorial *= n.toDouble();
      }
      result += (_pow(x, n)) / factorial;
    }
    
    return result;
  }
  
  /// حساب متسلسلة تايلور لـ sin(x)
  double taylorSin(double x, {int terms = 10}) {
    double result = 0.0;
    
    for (int n = 0; n < terms; n++) {
      double term = _pow(-1, n) * _pow(x, 2 * n + 1) / _factorial(2 * n + 1);
      result += term;
    }
    
    return result;
  }
  
  /// حساب متسلسلة تايلور لـ cos(x)
  double taylorCos(double x, {int terms = 10}) {
    double result = 0.0;
    
    for (int n = 0; n < terms; n++) {
      double term = _pow(-1, n) * _pow(x, 2 * n) / _factorial(2 * n);
      result += term;
    }
    
    return result;
  }
  
  /// حساب العاملي (Factorial)
  double _factorial(int n) {
    double result = 1.0;
    for (int i = 2; i <= n; i++) {
      result *= i.toDouble();
    }
    return result;
  }
  
  /// دالة الأس
  double _pow(double base, int exponent) {
    if (exponent == 0) return 1.0;
    if (exponent < 0) return 1.0 / _pow(base, -exponent);
    
    double result = 1.0;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }
  
  /// حساب عدد فيبوناتشي
  int fibonacci(int n) {
    if (n <= 1) return n;
    
    int a = 0, b = 1;
    for (int i = 2; i <= n; i++) {
      int temp = a + b;
      a = b;
      b = temp;
    }
    return b;
  }
  
  /// حساب دالة زيتا (نسخة مبسطة)
  double zeta(double s, {int terms = 100}) {
    double result = 0.0;
    for (int n = 1; n <= terms; n++) {
      result += 1.0 / _pow(n.toDouble(), s.toInt());
    }
    return result;
  }
}
