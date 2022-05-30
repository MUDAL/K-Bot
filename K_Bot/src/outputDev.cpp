#include "outputDev.h"

/**
 * @brief Source file for output devices driven by L298N Module
 * These devices include:
 * 1. Water pump
 * 2. 3 DC gear motors
 */

/**
 * @brief Converts duty cycle in percentage to clock cycles
 * 
 * @param percentage duty cycle in percentage 
 * @return uint32_t duty cycle expressed in clock cycles
 */
static uint32_t percentToDutyCycle(uint8_t percentage)
{
  //(1 << resolution) =  2 ^ resolution 
  return (percentage * (1<<PWM_TIMER_RES) / 100.0) - 1;
}

/**
 * @brief Configure pin of output device as an output pin
 * and ensure it's initial state is logic 0. Pin configuration
 * will be ignored if pin number isn't valid.
 * @param pin pin to be configured.
 * @return None
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
 * @brief Initializes output device driven by L298N module
 * @param channel PWM channel 
 * @param pwmPin GPIO pin routed to PWM 'channel'
 * @param pin1 first terminal of output device
 * @param pin2 second terminal of output device
 * @return None
 */
OutputDev::OutputDev(uint8_t channel,
                     uint8_t pwmPin,
                     uint8_t pin1,
                     uint8_t pin2)
{
  //Init private variables
  this->channel = channel;
  this->pwmPin = pwmPin;
  this->pin1 = pin1;
  this->pin2 = pin2;
  //Output device setup
  ledcSetup(this->channel,PWM_FREQ_HZ,PWM_TIMER_RES);
  ledcAttachPin(this->pwmPin,this->channel);
  OutputDev::ConfigurePin(this->pin1);
  OutputDev::ConfigurePin(this->pin2);
  OutputDev::DisablePWM();
}

/**
 * @brief Enable output device driven by L298N module.
 * When enabled, the output device is driven by a PWM signal.
 * @param percentDutyCycle Duty cycle of PWM signal (in %) required
 * to drive the output device.
 * @return None
 */
void OutputDev::EnablePWM(uint8_t percentDutyCycle)
{
  ledcWrite(this->channel,
            percentToDutyCycle(percentDutyCycle));
}

/**
 * @brief Disable output device driven by L298N module.
 * When disabled, no PWM signal drives the output device.
 * @return None
 */
void OutputDev::DisablePWM(void)
{
  ledcWrite(this->channel,0);
}

/**
 * @brief Writes a logic value to 'pin 1' of output device.
 * 
 * @param state value to be written to 'pin 1'.
 * 'state' can either be true or false.
 * @return None
 */
void OutputDev::WritePin(bool state)
{
  digitalWrite(this->pin1,state);
}

/**
 * @brief Writes logic to pins 1 and 2 of output device.
 * 
 * @param state1 value to be written to 'pin 1'.
 * @param state2 value to be written to 'pin 2'.
 * States 1 and 2 can either be true or false.
 * @return None
 */
void OutputDev::WritePins(bool state1,bool state2)
{
  digitalWrite(this->pin1,state1);
  digitalWrite(this->pin2,state2);
}