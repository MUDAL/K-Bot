#include <SoftwareSerial.h>
#include <Servo.h>
#include "L298N_Dev.h"
//Defines
#define RX_PIN                 2
#define TX_PIN                -1
#define SERVO_POS_DELAY     1500
//Bluetooth
SoftwareSerial bluetooth = SoftwareSerial(RX_PIN,TX_PIN);
//Output devices driven by L298N module
L298N_Dev pump(8); 
L298N_Dev leftWheel(5,6,3); 
L298N_Dev rightWheel(A2,A3,11); 
//Servo (Brush/cleaning pad is attached to servo arm)
Servo servo;
static bool servoActivated;
static uint32_t servoStartTime;

/**
 * @brief Receive and process commands from mobile app
*/
static void ProcessAppData(char appData)
{
  static bool pumpState;
  switch(appData)
  {
    case '0': //Pump control
      pumpState ^= 1;
      pump.Write(pumpState);
      break;
    case '1': //Servo control
      servo.write(90);//set servo to default position
      servoActivated ^= 1;
      servoStartTime = millis();
      break;
    case '2': //Move Back
      leftWheel.Write(1,0);
      rightWheel.Write(1,0);
      break;
    case '3': //Turn Left
      leftWheel.Write(1,0);
      rightWheel.Write(0,1);
      break;
    case '4': //Stop
      leftWheel.Write(0,0);
      rightWheel.Write(0,0);
      break;
    case '5': //Turn Right
      leftWheel.Write(0,1);
      rightWheel.Write(1,0);
      break;
    case '6': //Move Forward
      leftWheel.Write(0,1);
      rightWheel.Write(0,1);
      break;    
  }
}

void setup(void) 
{
  pinMode(RX_PIN,INPUT);
  bluetooth.begin(9600);
  leftWheel.SetSpeed(120);
  rightWheel.SetSpeed(120);
  servo.attach(9);
  //switch output devices off
  pump.Write(0);
  leftWheel.Write(0,0);
  rightWheel.Write(0,0);
}

void loop(void) 
{
  if(bluetooth.available())
  {
    char appData = bluetooth.read();
    ProcessAppData(appData);
  }
  if(servoActivated && ((millis() - servoStartTime) >= SERVO_POS_DELAY))
  {
    static int i;
    const int servoPos[] = {30,150};
    servo.write(servoPos[i]);
    servoStartTime = millis();
    i ^= 1;
  }
}

