#include "outputDev.h"

/**
 * @brief 
 * 
 * @param pin 
 */
void OutputDev::ConfigurePin(uint8_t pin)
{
  if(pin != INVALID_PIN)
  {
    pinMode(pin,OUTPUT);
    digitalWrite(pin,LOW);
  }
}

/**
 * @brief Construct a new Output Dev:: Output Dev object
 * 
 * @param pin1 
 * @param pin2 
 */
OutputDev::OutputDev(uint8_t pin1,uint8_t pin2)
{
  this->pin1 = pin1;
  this->pin2 = pin2;
  OutputDev::ConfigurePin(this->pin1);
  OutputDev::ConfigurePin(this->pin2);
}

/**
 * @brief 
 * 
 * @param pinState 
 */
void OutputDev::Write(bool pinState)
{
  digitalWrite(this->pin1,pinState);
}

/**
 * @brief 
 * 
 * @param pin1State 
 * @param pin2State 
 */
void OutputDev::Write(bool pin1State,bool pin2State)
{
  digitalWrite(this->pin1,pin1State);
  digitalWrite(this->pin2,pin2State);
}