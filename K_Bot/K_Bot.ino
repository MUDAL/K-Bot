#include <SoftwareSerial.h>
#include <Servo.h>
#include "L298N_Dev.h"

//Defines
#define BLUETOOTH_RX_PIN     2
#define BLUETOOTH_TX_PIN    -1
#define SERVO_POS_DELAY   1500
//Bluetooth
SoftwareSerial bluetooth = SoftwareSerial(BLUETOOTH_RX_PIN,BLUETOOTH_TX_PIN);
//Output devices driven by L298N module
L298N_Dev pump(4); 
L298N_Dev leftWheel(5,6); 
L298N_Dev rightWheel(7,8); 
//Servo (Brush/cleaning pad is attached to servo arm)
Servo servo;
static bool servoActivated;
static uint32_t servoStartTime;

/**
 * @brief Receive and process data received from mobile app
*/
static void ProcessAppData(char appData)
{
  static bool togglePump;
  switch(appData)
  {
    case '0': //Pump control
      togglePump ^= true;
      pump.Write(togglePump);
      break;
    case '1': //Servo control
      servo.write(90);//set servo to default position
      servoActivated ^= true;
      servoStartTime = millis();
      break;
    case '2': //Move Back
      leftWheel.Write(true,false);
      rightWheel.Write(true,false);
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
      leftWheel.Write(false,true);
      rightWheel.Write(false,true);
      break;    
  }
}

void setup(void) 
{
  Serial.begin(9600);
  pinMode(BLUETOOTH_RX_PIN,INPUT);
  bluetooth.begin(9600);
  servo.attach(3);
}

void loop(void) 
{
  if(bluetooth.available())
  {
    char appData = bluetooth.read();
    ProcessAppData(appData);
  }
  if(servoActivated && ((millis()-servoStartTime) >= SERVO_POS_DELAY))
  {
    static int i;
    int servoPos[] = {0,180};
    servo.write(servoPos[i]);
    servoStartTime = millis();
    i ^= 1;
  }
}
