#include <SoftwareSerial.h>
#include "outputDev.h"

//Bluetooth
enum SoftwareSerialPins
{
  SS_RX_PIN = 2,
  SS_TX_PIN = -1
};
SoftwareSerial bluetooth = SoftwareSerial(SS_RX_PIN,SS_TX_PIN);

//Output devices driven by L298N module
OutputDev pump(5); 
OutputDev brush(6);
OutputDev leftWheel(7,8); 
OutputDev rightWheel(9,10); 

/**
 * @brief 
 * 
 * @param appData 
 */
static void ProcessAppData(char appData)
{
  static bool togglePump;
  static bool toggleBrush;
  switch(appData)
  {
    case '0': //Pump control
      togglePump ^= true;
      pump.Write(togglePump);
      break;
    case '1': //Brush control
      toggleBrush ^= true;
      brush.Write(toggleBrush);
      break;
    case '2': //Move Back
      break;
    case '3': //Turn Left
      break;
    case '4': //Stop
      leftWheel.Write(false,false);
      rightWheel.Write(false,false);
      break;
    case '5': //Turn Right
      break;
    case '6': //Move Forward
      break;    
  }
}

void setup() 
{
  pinMode(SS_RX_PIN,INPUT);
  bluetooth.begin(9600);

  //Serial debug
  Serial.begin(9600);
}

void loop() 
{
  //Testing bluetooth communication with app
  if(bluetooth.available())
  {
    char appData = bluetooth.read();
    //======== Debug ===============
    Serial.print("Received = ");
    Serial.println(appData);
    //==============================
    ProcessAppData(appData);
  }  
}