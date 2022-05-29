#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include "outputDev.h"

void app_main(void) 
{
  //Configure K-Bot's actuators
  outputDev_t pump = {LEDC_TIMER_0,LEDC_CHANNEL_0,GPIO_NUM_5};
  outputDev_t brush = {LEDC_TIMER_0,LEDC_CHANNEL_1,GPIO_NUM_23};
  outputDev_t leftWheel = {LEDC_TIMER_0,LEDC_CHANNEL_2,GPIO_NUM_15};
  outputDev_t rightWheel = {LEDC_TIMER_0,LEDC_CHANNEL_3,GPIO_NUM_17};

  OutputDev_Init(&pump);
  OutputDev_Init(&brush);
  OutputDev_Init(&leftWheel);
  OutputDev_Init(&rightWheel);

  while(1)
  {
    //Testing the actuators
    OutputDev_Enable(&pump,25);
    OutputDev_Enable(&brush,50);
    OutputDev_Enable(&leftWheel,75);
    OutputDev_Enable(&rightWheel,100);
    vTaskDelay(pdMS_TO_TICKS(16000));

    OutputDev_Disable(&pump);
    OutputDev_Disable(&brush);
    OutputDev_Disable(&leftWheel);
    OutputDev_Disable(&rightWheel);
    vTaskDelay(pdMS_TO_TICKS(16000));
  }
}