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
        factorial *= n;
      }
      result += (x.pow(n)) / factorial;
    }
    
    return result;
  }
  
  /// حساب دالة زيتا (نسخة مبسطة)
  double zeta(double s, {int terms = 1000}) {
    if (s <= 1) return double.infinity;
    
    double result = 0.0;
    for (int n = 1; n <= terms; n++) {
      result += 1.0 / (n.pow(s));
    }
    
    return result;
  }
}

extension IntPower on int {
  int pow(int exponent) {
    int result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= this;
    }
    return result;
  }
}

extension DoublePower on double {
  double pow(int exponent) {
    double result = 1.0;
    for (int i = 0; i < exponent; i++) {
      result *= this;
    }
    return result;
  }
}
