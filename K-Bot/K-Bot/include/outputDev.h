#ifndef OUTPUT_DEV_H
#define OUTPUT_DEV_H

#include <stdio.h>
#include <driver/gpio.h>
#include <driver/ledc.h>

/**
 * @brief Header file for output devices driven by L298N Module.
 * These devices include:
 * 1. Water pump
 * 2. 3 DC gear motors
 */

#define PWM_TIMER_RES  LEDC_TIMER_13_BIT

typedef struct 
{
  /* data */
  ledc_timer_t  timerNum;
  ledc_channel_t channel;
  gpio_num_t gpioNum;
}outputDev_t;

extern void OutputDev_Init(outputDev_t* dev);
extern void OutputDev_Enable(outputDev_t* dev,uint8_t percentDutyCycle);
extern void OutputDev_Disable(outputDev_t* dev);

#endif