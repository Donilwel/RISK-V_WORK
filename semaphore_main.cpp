#include <iostream>
#include <thread>
#include <semaphore>

std::semaphore single_rooms_semaphore;
std::semaphore double_rooms_semaphore;
int available_single_rooms = 10;
int available_double_rooms = 15;

void guestArrives(const std::string& guest_name, bool is_female) {
    if (is_female) {
        if (available_single_rooms > 0) {
            single_rooms_semaphore.wait();
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
            double_rooms_semaphore.wait();
            std::cout << guest_name << " (male) has been assigned a double room.\n";
            available_double_rooms--;
        }
        else {
            std::cout << guest_name << " (male) couldn't find a suitable room and left.\n";
            return;
        }
    }
}

void guestDeparts(const std::string& guest_name, bool is_female) {
    if (is_female) {
        available_single_rooms++;
        std::cout << guest_name << " (female) has departed and the single room is available.\n";
        single_rooms_semaphore.signal();
    }
    else {
        available_double_rooms++;
        std::cout << guest_name << " (male) has departed and the double room is available.\n";
        double_rooms_semaphore.signal();
    }
}

void hotelAdministrator() {
    std::cout << "Hotel administrator thread started.\n";

    while (true) {
        if (available_single_rooms == 0)
            std::cout << "No single rooms available. Waiting for departures...\n";
        else if (available_double_rooms == 0)
            std::cout << "No double rooms available. Waiting for departures...\n";
        else
            break;
    }
}

int main() {
    single_rooms_semaphore = std::semaphore(available_single_rooms);
    double_rooms_semaphore = std::semaphore(available_double_rooms);

    std::thread administrator_thread(hotelAdministrator);

    std::cout << "Welcome to the hotel!\n";
    std::cout << "Please enter the guest details. Type 'exit' to stop.\n";

    std::string guest_name;
    std::string guest_gender;

    while (true) {
        std::cout << "Guest name: ";
        std::getline(std::cin, guest_name);

        if (guest_name == "exit") {
            break;
        }

        std::cout << "Guest gender (male/female): ";
        std::getline(std::cin, guest_gender);

        bool is_female = (guest_gender == "female");

        std::thread guest_thread(guestArrives, guest_name, is_female);
        guest_thread.detach();
    }

    administrator_thread.join();

    return 0;
}
