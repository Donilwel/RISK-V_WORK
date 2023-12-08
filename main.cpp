#include <iostream>
#include <ctime>
#include <iomanip>
#include <pthread.h>
#include "algorithm"

struct Package {
  double *A;
  double *B;
  int thread_num;
  double res;
};

void *foo(void *par) {
  auto package = static_cast<Package *>(par);
  for (int_fast64_t i = (*package).thread_num; i < 800000000; i += 1000) (*package).res += (*package).A[i] * (*package).B[i];
  return nullptr;
}

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
  pthread_t threads[1000];
  Package data[1000];

  for (int_fast64_t i = 0; i < 1000; ++i) {
      data[i].A = arr1, data[i].B = arr2, data[i].thread_num = i, data[i].res = 0;
      pthread_create(&threads[i], nullptr, foo, static_cast<void *>(&data[i]));
  }
  for (int_fast64_t i = 0; i < 1000; ++i) pthread_join(threads[i], nullptr), asyncc += data[i].res;
  clock_t end_async = clock();
  std::cout << "Номера элементов " << 800000000 << '\n';
  std::cout << "Скалярное произведение (single) = " << std::setprecision(20) << std::scientific << singlee << '\n';
  std::cout << "Время выполнения программы (single) = " << std::defaultfloat << static_cast<double>(end - start_single) / ((clock_t)1000000) << " секунд" << '\n';
  std::cout << "Номер потока " << 1000 << "\n";
  std::cout << "Скалярное произведение (async) = " << std::setprecision(20) << std::scientific << asyncc << '\n';
  std::cout << "Время существования программы (async) = " << std::defaultfloat << static_cast<double>(end_async - start_async) / ((clock_t)1000000) << " секунд";
  delete[] arr1, delete[] arr2;
  return 0;
}