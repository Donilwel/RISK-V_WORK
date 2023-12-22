#include <iostream>
#include <ctime>
#include <iomanip>
#include <omp.h>

double *init_arr1(int n) {
  auto arr = new double[n];
  for (int_fast64_t i = 0; i < n; ++i) arr[i] = i + 1;
  return arr;
}

double *init_arr2(int n) {
  auto arr = new double[n];
  for (int_fast64_t i = 0; i < n; ++i) arr[i] = n - i;
  return arr;
}

int main() {
  double asyncc = 0;
  double singlee = 0;
  double *arr1 = init_arr1(800000000);
  double *arr2 = init_arr2(800000000);

  clock_t start_single = clock();
  for (auto i = 0; i < 800000000; ++i) singlee += arr1[i] * arr2[i];
  clock_t end = clock();

  clock_t start_async = clock();
  #pragma omp parallel for reduction(+:asyncc)
  for (int i = 0; i < 800000000; ++i) asyncc += arr1[i] * arr2[i];
  clock_t end_async = clock();

  std::cout << "Номера элементов " << 800000000 << '\n';
  std::cout << "Скалярное произведение (single) = " << std::setprecision(20) << std::scientific << singlee << '\n';
  std::cout << "Время выполнения программы (single) = " << std::defaultfloat << static_cast<double>(end - start_single) / ((clock_t)1000000) << " секунд" << '\n';
  std::cout << "Скалярное произведение (async) = " << std::setprecision(20) << std::scientific << asyncc << '\n';
  std::cout << "Время выполнения программы (async) = " << std::defaultfloat << static_cast<double>(end_async - start_async) / ((clock_t)1000000) << " секунд";

  delete[] arr1;
  delete[] arr2;
  return 0;
}
