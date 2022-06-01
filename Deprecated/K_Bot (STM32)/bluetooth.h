#ifndef BLUETOOTH_H
#define BLUETOOTH_H

/**
* Bluetooth: HC05/6
*/
	
extern void BT_RxInit(void);
extern void BT_RxBufferInit(char* buffer,uint8_t numOfBytes);

#endif //BLUETOOTH_H
