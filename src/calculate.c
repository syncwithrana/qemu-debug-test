int add(int a, int b) { return a + b; }

int subtract(int a, int b) { return a - b; }

int multiply(int a, int b) { return a * b; }

int calculate(int a, int b) {
  int result = add(a, b);
  result = multiply(result, 2);
  return result;
}