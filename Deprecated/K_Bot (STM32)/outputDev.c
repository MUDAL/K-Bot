#include "stm32f10x.h"                  // Device header
#include "gpio.h"
#include "outputDev.h"

void SinglePinDevice_Init(sPinDev_t sPinDev)
{
	switch(sPinDev)
	{
		case CLEANING_BRUSH:
			break;
		case WATER_PUMP:
			break;
	}
}

void SinglePinDevice_Write(sPinDev_t sPinDev,bool pinState)
{
	switch(sPinDev)
	{
		case CLEANING_BRUSH:
			break;
		case WATER_PUMP:
			break;
	}	
}

void Wheel_Init(wheel_t wheel)
{
	switch(wheel)
	{
		case LEFT_WHEEL:
			break;
		case RIGHT_WHEEL:
			break;
	}
}

void Wheel_Write(wheel_t wheel,bool pin1State,bool pin2State)
{
	switch(wheel)
	{
		case LEFT_WHEEL:
			break;
		case RIGHT_WHEEL:
			break;
	}	
}
