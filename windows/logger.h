#ifndef LOGGER_H
#define LOGGER_H

#include <iostream>
#include <sstream>

namespace logger {
    template<typename... Args>
    void log(Args&&... args) {
        std::ostringstream oss;
        (oss << ... << std::forward<Args>(args));
        std::cout << oss.str() << std::endl;
    }

    void print_time_elapsed(clock_t elapsedDuration, std::string message);
}


#endif  // LOGGER_H
