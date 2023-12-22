#include <iostream>
#include <vector>
#include <string>
#include <omp.h>

int main() {
    std::cout << "Welcome to the hotel!\n";
    std::cout << "Please enter guest details. Type 'exit' to stop.\n";

    std::vector<std::string> guest_names;
    std::vector<std::string> guest_genders;
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

        guest_names.push_back(guest_name);
        guest_genders.push_back(guest_gender);
    }

#pragma omp parallel for
    for (int i = 0; i < guest_names.size(); ++i) {
        std::string guest_name = guest_names[i];
        std::string guest_gender = guest_genders[i];

#pragma omp critical
        {
            if (guest_gender == "female") {
                std::cout << guest_name << " (female) has been assigned a room.\n";
            } else if (guest_gender == "male") {
                std::cout << guest_name << " (male) has been assigned a room.\n";
            } else {
                std::cout << "Invalid gender for guest " << guest_name << ". Skipping.\n";
            }
        }
    }

    return 0;
}