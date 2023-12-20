#include <iostream>
#include <pthread.h>
#include <queue>
#include <unistd.h>
#include <cstdlib>

std::queue<int> numQueue;
int numKey = 1;
pthread_mutex_t queueMutex, writeMutex, outputMutex;

void *writeNumbers(void *args) {
    int threadNum = *((int *) args);
    pthread_mutex_lock(&writeMutex), numQueue.push(numKey), std::cout << "Число " << numKey++ << " было записано в массив потока " << threadNum << "\n",
    pthread_mutex_unlock(&writeMutex);
    return nullptr;
}

struct SumPackage {
    SumPackage(int _num1, int _num2) : num1(_num1), num2(_num2) {}
    int num1;
    int num2;
};

void *sumTwoNumbers(void *args) {
    pthread_mutex_lock(&outputMutex);
    auto package = (SumPackage *) args;
    std::cout << "Число " << (*package).num2 << " и " << (*package).num1 << " были просуммированы\n";
    numQueue.push((*package).num1 + (*package).num2);
    pthread_mutex_unlock(&outputMutex);
    return nullptr;
}

void *checkIsPair(void *args) {
    sleep(1);
    while (true) {
        pthread_mutex_lock(&queueMutex);
        if (numQueue.size() >= 2) {
            pthread_t sumThread;
            int num1 = numQueue.front();
            numQueue.pop();
            int num2 = numQueue.front();
            numQueue.pop(), pthread_mutex_unlock(&queueMutex);
            auto package = new SumPackage(num1, num2);
            pthread_create(&sumThread, nullptr, sumTwoNumbers, (void *) package), pthread_join(sumThread, nullptr);
        } else {
            pthread_mutex_unlock(&queueMutex);
            break;
        }
    }
    return nullptr;
}

int main() {
    numQueue = std::queue<int>();
    pthread_mutex_init(&queueMutex, nullptr);
    pthread_mutex_init(&writeMutex, nullptr);
    pthread_mutex_init(&outputMutex, nullptr);

    pthread_t writeThreads[20], checkerThread;
    int threadNums[20];

    for (int i = 0; i < 20; ++i) threadNums[i] = i + 1, pthread_create(&writeThreads[i], nullptr, writeNumbers, (void *) (threadNums + i));
    pthread_create(&checkerThread, nullptr, checkIsPair, nullptr);
    for (int i = 0; i < 20; ++i) pthread_join(writeThreads[i], nullptr);
    pthread_join(checkerThread, nullptr);

    pthread_mutex_destroy(&queueMutex);
    pthread_mutex_destroy(&writeMutex);
    pthread_mutex_destroy(&outputMutex);

    sleep(2);

    std::cout << "Итоговая сумма " << numQueue.front();

    return 0;
}
