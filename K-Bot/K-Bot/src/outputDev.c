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
 * @param resolution duty cycle resolution of PWM timer (e.g LEDC_TIMER_13_BIT)
 * @return uint32_t duty cycle expressed in clock cycles
 */
static uint32_t percentToDutyCycle(uint8_t percentage,
                                   ledc_timer_bit_t resolution)
{
  //(1 << resolution) =  2 ^ resolution 
  return (percentage * (1<<resolution) / 100.0) - 1;
}

/**
 * @brief Initializes output device driven by L298N module
 * 
 * @param dev pointer to structure containing output device's 
 * configuration data
 * @return None
 */
void OutputDev_Init(outputDev_t* dev)
{
  ledc_timer_config_t pwmTimer = 
  {
    .timer_num = dev->timerNum,
    .freq_hz = 2000, //2kHz 
    .speed_mode = LEDC_LOW_SPEED_MODE,
    .duty_resolution = PWM_TIMER_RES,
    .clk_cfg = LEDC_AUTO_CLK
  };

  ledc_channel_config_t pwmChannel =
  {
    .timer_sel = dev->timerNum,
    .channel = dev->channel,
    .gpio_num = dev->gpioNum,
    .speed_mode = LEDC_LOW_SPEED_MODE,
    .intr_type = LEDC_INTR_DISABLE,
    .duty = 0,
    .hpoint = 0
  };

  ledc_timer_config(&pwmTimer);
  ledc_channel_config(&pwmChannel);  
}

/**
 * @brief Enables output device driven by L298N module.
 * When enabled, the output device is driven by a PWM signal.
 * @param dev pointer to structure containing output device's 
 * configuration data
 * @param percentDutyCycle Duty cycle of PWM signal (in %) required
 * to drive the output device.
 * @return None
 */
void OutputDev_Enable(outputDev_t* dev,uint8_t percentDutyCycle)
{
  ledc_set_duty(LEDC_LOW_SPEED_MODE,dev->channel,
                percentToDutyCycle(percentDutyCycle,PWM_TIMER_RES));
  ledc_update_duty(LEDC_LOW_SPEED_MODE,dev->channel);
}

/**
 * @brief Disables output device driven by L298N module.
 * When disabled, no PWM signal drives the output device.
 * @param dev pointer to structure containing output device's 
 * configuration data
 * @return None
 */
void OutputDev_Disable(outputDev_t* dev)
{
  ledc_set_duty(LEDC_LOW_SPEED_MODE,dev->channel,0);
  ledc_update_duty(LEDC_LOW_SPEED_MODE,dev->channel); 
}