#ifndef OUTPUT_DEV_H
#define OUTPUT_DEV_H

/**
 * @brief Header file for output devices driven by L298N Module.
 * These devices include:
 * 1. Water pump
 * 2. 3 DC gear motors
 */

#include <Arduino.h>

#define PWM_TIMER_RES  8
#define PWM_FREQ_HZ    2000
#define INVALID_PIN    255

class OutputDev
{
  private:
    uint8_t channel;
    uint8_t pwmPin;
    uint8_t pin1;
    uint8_t pin2;
    void ConfigurePin(uint8_t pin);
    
  public:
    OutputDev(uint8_t channel,
              uint8_t pwmPin,
              uint8_t pin1 = INVALID_PIN,
              uint8_t pin2 = INVALID_PIN);
    void EnablePWM(uint8_t percentDutyCycle);
    void DisablePWM(void);
    void WritePin(bool state);
    void WritePins(bool state1,bool state2);
};

#endif