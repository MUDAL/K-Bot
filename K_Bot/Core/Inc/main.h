/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2022 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

void HAL_TIM_MspPostInit(TIM_HandleTypeDef *htim);

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define leftSpeedSensor_Pin GPIO_PIN_0
#define leftSpeedSensor_GPIO_Port GPIOA
#define rightSpeedSensor_Pin GPIO_PIN_6
#define rightSpeedSensor_GPIO_Port GPIOA
#define motorIn1_Pin GPIO_PIN_12
#define motorIn1_GPIO_Port GPIOB
#define motorIn2_Pin GPIO_PIN_13
#define motorIn2_GPIO_Port GPIOB
#define motorIn3_Pin GPIO_PIN_14
#define motorIn3_GPIO_Port GPIOB
#define motorIn4_Pin GPIO_PIN_15
#define motorIn4_GPIO_Port GPIOB
#define bluetoothRx_Pin GPIO_PIN_7
#define bluetoothRx_GPIO_Port GPIOC
#define leftMotorPWM_Pin GPIO_PIN_8
#define leftMotorPWM_GPIO_Port GPIOA
#define rightMotorPWM_Pin GPIO_PIN_9
#define rightMotorPWM_GPIO_Port GPIOA
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */
