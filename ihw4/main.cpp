#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <chrono>
#include <random>

std::mutex mtx;
std::condition_variable cv;
int available_single_rooms = 10;
int available_double_rooms = 15;

void guestArrives(const std::string& guest_name, bool is_female) {
    std::unique_lock<std::mutex> lock(mtx);

    if (is_female) {
        if (available_single_rooms > 0) {
            std::cout << guest_name << " (female) has been assigned a single room.\n";
            available_single_rooms--;
        }
        else {
            std::cout << guest_name << " (female) couldn't find a suitable room and left.\n";
            return;
        }
    }
    else {
        if (available_double_rooms > 0) {
            std::cout << guest_name << " (male) has been assigned a double room.\n";
            available_double_rooms--;
        }
        else {
            std::cout << guest_name << " (male) couldn't find a suitable room and left.\n";
            return;
        }
    }

    cv.notify_all();
}

void guestDeparts(const std::string& guest_name, bool is_female) {
    std::unique_lock<std::mutex> lock(mtx);

    if (is_female) {
        available_single_rooms++;
        std::cout << guest_name << " (female) has departed and the single room is available.\n";
    }
    else {
        available_double_rooms++;
        std::cout << guest_name << " (male) has departed and the double room is available.\n";
    }

    cv.notify_all();
}

void simulateGuest() {
    std::random_device rd;
    std::mt19937 generator(rd());
    std::uniform_int_distribution<int> arrival_delay(1000, 5000);
    std::uniform_int_distribution<int> stay_duration(2000, 8000);

    while (true) {
        std::this_thread::sleep_for(std::chrono::milliseconds(arrival_delay(generator)));

        std::unique_lock<std::mutex> lock(mtx);
        std::string guest_name = "Guest" + std::to_string(std::chrono::steady_clock::now().time_since_epoch().count());
        bool is_female = (generator() % 2 == 0);

        guestArrives(guest_name, is_female);

        std::this_thread::sleep_for(std::chrono::milliseconds(stay_duration(generator)));

        guestDeparts(guest_name, is_female);
    }
}

void hotelAdministrator() {
    std::unique_lock<std::mutex> lock(mtx);

    cv.wait(lock, [] { return (available_single_rooms > 0 || available_double_rooms > 0); });

    std::cout << "Hotel administrator thread started.\n";

    while (true) {
        cv.wait(lock, [] { return (available_single_rooms == 0 || available_double_rooms == 0); });

        if (available_single_rooms == 0)
            std::cout << "No single rooms available. Waiting for departures...\n";
        else if (available_double_rooms == 0)
            std::cout << "No double rooms available. Waiting for departures...\n";

        cv.wait(lock, [] { return (available_single_rooms > 0 || available_double_rooms > 0); });
    }
}

int main() {
    std::thread administrator_thread(hotelAdministrator);
    std::thread guest_simulation_thread(simulateGuest);

    std::cout << "Welcome to the hotel!\n";
    std::cout << "Please enter 'exit' to stop the simulation.\n";

    std::string input;
    while (true) {
        std::getline(std::cin, input);
        if (input == "exit")
            break;
    }

    administrator_thread.join();
    guest_simulation_thread.detach();

    return 0;
}
