#include "main.h"

static void ProcessAppData(char* appData)
{
	if(*appData == 0) {return;}
	
	switch(*appData)
	{
		case '0':
			break;
		case '1':
			break;
		case '2':
			break;
		case '3':
			break;
		case '4':
			break;
		case '5':
			break;
		case '6':
			break;
	}
	*appData = 0;
}

int main(void)
{
	//Initializations
	const uint8_t numOfBytesToReceive = 1;
	char appData = 0; 
	
	System_Config();
	BT_RxInit();
	BT_RxBufferInit(&appData,numOfBytesToReceive);
	
	while(1)
	{
		ProcessAppData(&appData);
	}
}

