#ifndef OUTPUT_DEV_H
#define OUTPUT_DEV_H

//The brush and water pump are controlled via one of their pins hence ...
//they're single pin output devices.
typedef enum
{
	CLEANING_BRUSH = 0,
	WATER_PUMP
}sPinDev_t;

typedef enum
{
	LEFT_WHEEL = 0,
	RIGHT_WHEEL
}wheel_t;

extern void SinglePinDevice_Init(sPinDev_t sPinDev);
extern void SinglePinDevice_Write(sPinDev_t sPinDev,bool pinState);
extern void Wheel_Init(wheel_t wheel);
extern void Wheel_Write(wheel_t wheel,bool pin1State,bool pin2State);

#endif

