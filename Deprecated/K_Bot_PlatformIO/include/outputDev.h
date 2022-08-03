#ifndef OUTPUT_DEV_H
#define OUTPUT_DEV_H

#include <Arduino.h>
#define INVALID_PIN 255

class OutputDev
{
  private:
    uint8_t pin1;
    uint8_t pin2;
    void ConfigurePin(uint8_t pin);

  public:
    OutputDev(uint8_t pin1,uint8_t pin2 = INVALID_PIN);
    void Write(bool pinState);
    void Write(bool pin1State,bool pin2State);
};

#endif