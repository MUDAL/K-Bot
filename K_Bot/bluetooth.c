#include "stm32f10x.h"                  // Device header
#include "gpio.h"
#include "uart.h"
#include "dma.h"

void BT_RxInit(void)
{
	//GPIO configuration for USART3 Rx
	GPIO_InputInit(GPIOB,
								 GPIO_PORT_REG_HIGH,
								 GPIO_PIN11,
								 GPIO_PIN11_INPUT_PULLUP_OR_PULLDOWN,
								 GPIO_PULLUP_ENABLE);	
	USART_Init(USART3,BAUD_9600,RX_DMA_ENABLE,USART_RX_ENABLE);	
}

void BT_RxBufferInit(char* buffer,uint8_t numOfBytes)
{
	//DMA1 channel 3 configuration for USART3 Rx
	DMA_USART_Rx_Init(DMA1_Channel3,
										USART3,
										(uint8_t*)buffer,
										numOfBytes, 
										DMA_CHANNEL3_MEMORY_INC_MODE |
										DMA_CHANNEL_ENABLE);	
}
