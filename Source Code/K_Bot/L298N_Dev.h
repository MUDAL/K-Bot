#ifndef L298N_DEV_H
#define L298N_DEV_H

#include <Arduino.h>
#define INVALID_PIN 255

class L298N_Dev
{
  private:
    uint8_t pin1;
    uint8_t pin2;
    uint8_t pwmPin;
    void ConfigurePin(uint8_t pin);

  public:
    L298N_Dev(uint8_t pin1,uint8_t pin2 = INVALID_PIN,uint8_t pwmPin = INVALID_PIN);
    void Write(bool pin1State);
    void Write(bool pin1State,bool pin2State);
    void SetSpeed(uint8_t pwmVal);
};

#endif

