#include "L298N_Dev.h"

void L298N_Dev::ConfigurePin(uint8_t pin)
{
  if(pin != INVALID_PIN)
  {
    pinMode(pin,OUTPUT);
    digitalWrite(pin,LOW);
  }
  else
  {
    Serial.println("Error: Invalid pin number");
  }
}

L298N_Dev::L298N_Dev(uint8_t pin1,uint8_t pin2)
{
  this->pin1 = pin1;
  this->pin2 = pin2;
  L298N_Dev::ConfigurePin(this->pin1);
  L298N_Dev::ConfigurePin(this->pin2);
}

void L298N_Dev::Write(bool pin1State)
{
  digitalWrite(this->pin1,pin1State);
}

void L298N_Dev::Write(bool pin1State,bool pin2State)
{
  digitalWrite(this->pin1,pin1State);
  digitalWrite(this->pin2,pin2State);
}

