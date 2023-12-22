#include <iostream>
#include <ctime>
#include <iomanip>
#include <mpi.h>

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

int main(int argc, char *argv[]) {
  int size, rank;
  double asyncc = 0;
  double singlee = 0;
  double *arr1, *arr2;
  double *local_arr1, *local_arr2;
  int local_size;

  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  if (rank == 0) {
    arr1 = init_arr1(800000000);
    arr2 = init_arr2(800000000);
  }

  local_size = 800000000 / size;
  local_arr1 = new double[local_size];
  local_arr2 = new double[local_size];

  MPI_Scatter(arr1, local_size, MPI_DOUBLE, local_arr1, local_size, MPI_DOUBLE, 0, MPI_COMM_WORLD);
  MPI_Scatter(arr2, local_size, MPI_DOUBLE, local_arr2, local_size, MPI_DOUBLE, 0, MPI_COMM_WORLD);

  clock_t start_single = clock();
  for (auto i = 0; i < local_size; ++i) singlee += local_arr1[i] * local_arr2[i];
  clock_t end = clock();

  clock_t start_async = clock();
  double local_result = 0;
  for (auto i = 0; i < local_size; ++i) local_result += local_arr1[i] * local_arr2[i];

  double global_result;
  MPI_Reduce(&local_result, &global_result, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
  clock_t end_async = clock();

  if (rank == 0) {
    std::cout << "Номера элементов " << 800000000 << '\n';
    std::cout << "Скалярное произведение (single) = " << std::setprecision(20) << std::scientific << singlee << '\n';
    std::cout << "Время выполнения программы (single) = " << std::defaultfloat << static_cast<double>(end - start_single) / ((clock_t)1000000) << " секунд" << '\n';
    std::cout << "Скалярное произведение (async) = " << std::setprecision(20) << std::scientific << global_result << '\n';
    std::cout << "Время выполнения программы (async) = " << std::defaultfloat << static_cast<double>(end_async - start_async) / ((clock_t)1000000) << " секунд";
  }

  delete[] local_arr1;
  delete[] local_arr2;
  if (rank == 0) {
    delete[] arr1;
    delete[] arr2;
  }

  MPI_Finalize();
  return 0;
}
