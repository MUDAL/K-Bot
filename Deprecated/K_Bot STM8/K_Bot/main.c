/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */

#include "stm8s.h"

/*	Pinouts	*/
/**
	* 	|	STM8 | Component
	*1.	|	PD6	 | Bluetooth Tx	
	*2. | PC3	 | Pump 
	*3. | PC4	 | Brush
	*4. | PC5  | Left motor terminal 1
	*5. | PC6  | Left motor terminal 2
	*6. | PD0	 | Right motor terminal 1
	*7. | PD3  | Right motor terminal 2
	*8. | PD2  | Left motor sensor
	*9. | PD4  | Right motor sensor
	*10.| PC1  | Left motor PWM
	*11.| PC2  | Right motor PWM
*/

#define MAX_SPEED	 395 //cycles

/*	Functions	*/
//Bluetooth
static void Bluetooth_Init(void)
{
	//Initialize UART2 Rx [PD6]
	UART2_Init(9600,UART2_WORDLENGTH_8D,
						 UART2_STOPBITS_1,UART2_PARITY_NO,
						 UART2_SYNCMODE_CLOCK_DISABLE,
						 UART2_MODE_RX_ENABLE);
	UART2_Cmd(ENABLE);
}

static char Bluetooth_Receive(void)
{
	char rxData = '\0';
	if(UART2_GetFlagStatus(UART2_FLAG_RXNE) == SET)
	{
		rxData = (char)UART2_ReceiveData8();
	}
	return rxData;
}

//Speed sensors
static void SpeedSensors_Init(void)
{
	//TIM3 CH1 [PD2] for left motor's sensor
	TIM3_ICInit(TIM3_CHANNEL_1,TIM3_ICPOLARITY_RISING,
							TIM3_ICSELECTION_DIRECTTI,TIM3_ICPSC_DIV8,
							0x0F);
	TIM3_Cmd(ENABLE); //Enable TIM3
	TIM3_ClearFlag(TIM3_FLAG_CC1); //Clear CC1 flag
	//TIM2 CH1 [PD4] for right motor's sensor
	TIM2_ICInit(TIM2_CHANNEL_1,TIM2_ICPOLARITY_RISING,
							TIM2_ICSELECTION_DIRECTTI,TIM2_ICPSC_DIV8,
							0x0F);
	TIM2_Cmd(ENABLE); //Enable TIM2
	TIM2_ClearFlag(TIM2_FLAG_CC1); //Clear CC1 flag
}

static uint16_t LeftSensor_GetPeriod(void)
{
	uint16_t firstCapture = 0;
	uint16_t secondCapture = 0;
	//wait for first capture
	while((TIM3->SR1 & TIM3_FLAG_CC1) != TIM3_FLAG_CC1){}
	firstCapture = TIM3_GetCapture1();
	TIM3_ClearFlag(TIM3_FLAG_CC1);
	//wait for second capture
	while((TIM3->SR1 & TIM3_FLAG_CC1) != TIM3_FLAG_CC1){}
	secondCapture = TIM3_GetCapture1();
	TIM3_ClearFlag(TIM3_FLAG_CC1);
	//return period
	return (secondCapture - firstCapture);
}

static uint16_t RightSensor_GetPeriod(void)
{
	uint16_t firstCapture = 0;
	uint16_t secondCapture = 0;
	//wait for first capture
	while((TIM2->SR1 & TIM2_FLAG_CC1) != TIM2_FLAG_CC1){}
	firstCapture = TIM2_GetCapture1();
	TIM2_ClearFlag(TIM2_FLAG_CC1);
	//wait for second capture
	while((TIM2->SR1 & TIM2_FLAG_CC1) != TIM2_FLAG_CC1){}
	secondCapture = TIM2_GetCapture1();
	TIM2_ClearFlag(TIM2_FLAG_CC1);
	//return period
	return (secondCapture - firstCapture);
}

//Actuators
static void Actuators_Init(void)
{
	//Pump and Brush GPIO Init
	GPIO_Init(GPIOC,GPIO_PIN_3,GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(GPIOC,GPIO_PIN_4,GPIO_MODE_OUT_PP_LOW_FAST);
	//Left motor GPIO Init
	GPIO_Init(GPIOC,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(GPIOC,GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_FAST);
	//Right motor GPIO Init
	GPIO_Init(GPIOD,GPIO_PIN_0,GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(GPIOD,GPIO_PIN_3,GPIO_MODE_OUT_PP_LOW_FAST);
	//Timer 1 Init for PWM generation [5kHz frequency]
	//Prescaler = 8, period = 400 cycles
	TIM1_TimeBaseInit(7,TIM1_COUNTERMODE_UP,399,0);
	//Left motor PWM mode 2 Init[duty = pulse]
	TIM1_OC1Init(TIM1_OCMODE_PWM2,TIM1_OUTPUTSTATE_ENABLE,
							 TIM1_OUTPUTNSTATE_ENABLE,395,
							 TIM1_OCPOLARITY_LOW,TIM1_OCNPOLARITY_HIGH,
							 TIM1_OCIDLESTATE_SET,
							 TIM1_OCNIDLESTATE_RESET);
	//Right motor PWM mode 2 Init[duty = pulse] 
	TIM1_OC2Init(TIM1_OCMODE_PWM2,TIM1_OUTPUTSTATE_ENABLE,
							 TIM1_OUTPUTNSTATE_ENABLE,0,
							 TIM1_OCPOLARITY_LOW,TIM1_OCNPOLARITY_HIGH,
							 TIM1_OCIDLESTATE_SET,
							 TIM1_OCNIDLESTATE_RESET);	
	//TIM1 counter enable
	TIM1_Cmd(ENABLE);
	//TIM1 Main Output Enable
	TIM1_CtrlPWMOutputs(ENABLE);
}

static void Pump_Toggle(void)
{
	GPIO_WriteReverse(GPIOC,GPIO_PIN_3);
}

static void Brush_Toggle(void)
{
	GPIO_WriteReverse(GPIOC,GPIO_PIN_4);
}

static void Motors_Stop(void)
{
	//Stop left motor
	GPIO_WriteLow(GPIOC,GPIO_PIN_5);
	GPIO_WriteLow(GPIOC,GPIO_PIN_6);
	//Stop right motor
	GPIO_WriteLow(GPIOD,GPIO_PIN_0);
	GPIO_WriteLow(GPIOD,GPIO_PIN_3);
}

static void Motors_Advance(void)
{
	//Start left motor
	GPIO_WriteHigh(GPIOC,GPIO_PIN_5);
	GPIO_WriteLow(GPIOC,GPIO_PIN_6);
	//Start right motor
	GPIO_WriteHigh(GPIOD,GPIO_PIN_0);
	GPIO_WriteLow(GPIOD,GPIO_PIN_3);	
}

static void Motors_Reverse(void)
{
	//Reverse left motor
	GPIO_WriteLow(GPIOC,GPIO_PIN_5);
	GPIO_WriteHigh(GPIOC,GPIO_PIN_6);
	//Reverse right motor
	GPIO_WriteLow(GPIOD,GPIO_PIN_0);
	GPIO_WriteHigh(GPIOD,GPIO_PIN_3);		
}

static void LeftMotor_SetSpeed(uint16_t speed)
{
	if(speed > MAX_SPEED)
	{//Invalid input
		return;
	}
	TIM1_SetCompare1(speed);//Adjust duty cycle
}

static void RightMotor_SetSpeed(uint16_t speed)
{
	if(speed > MAX_SPEED)
	{//Invalid input
		return;
	}
	TIM1_SetCompare2(speed);//Adjust duty cycle	
}

static void KBot_TurnRight(void)
{
	//Start left motor
	GPIO_WriteHigh(GPIOC,GPIO_PIN_5);
	GPIO_WriteLow(GPIOC,GPIO_PIN_6);	
	//Reverse right motor
	GPIO_WriteLow(GPIOD,GPIO_PIN_0);
	GPIO_WriteHigh(GPIOD,GPIO_PIN_3);		
}

static void KBot_TurnLeft(void)
{
	//Reverse left motor
	GPIO_WriteLow(GPIOC,GPIO_PIN_5);
	GPIO_WriteHigh(GPIOC,GPIO_PIN_6);	
	//Start right motor
	GPIO_WriteHigh(GPIOD,GPIO_PIN_0);
	GPIO_WriteLow(GPIOD,GPIO_PIN_3);		
}

//Main application
int main(void)
{
	//Variables
	bool speedBalanceEnable = 0;
	char appData = '\0';
	//Initializations
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //16MHz
	Bluetooth_Init();
	SpeedSensors_Init();
	Actuators_Init();
	
	while(1)
	{
		//Process data received from bluetooth app
		appData = Bluetooth_Receive();
		
		switch(appData)
		{
			case '0': //Pump control
				Pump_Toggle();
				speedBalanceEnable = 0;
				break;
			case '1': //Brush control
				Brush_Toggle();
				speedBalanceEnable = 0;
				break;
			case '2': //Move back
				Motors_Reverse();
				speedBalanceEnable = 1;
				break;
			case '3': //Turn left
				KBot_TurnLeft();
				speedBalanceEnable = 0;
				break;
			case '4': //Stop
				Motors_Stop();
				speedBalanceEnable = 0;
				break;
			case '5': //Turn right
				KBot_TurnRight();
				speedBalanceEnable = 0;
				break;
			case '6': //Move forward
				Motors_Advance();
				speedBalanceEnable = 1;
				break;
		}
		
		if(speedBalanceEnable)
		{
			//Balance the speed of both motors
		}
	}
}