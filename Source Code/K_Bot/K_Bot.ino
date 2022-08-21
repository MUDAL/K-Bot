#include <SoftwareSerial.h>
#include <Servo.h>
#include "L298N_Dev.h"

//The K-Bot is a floor cleaning device that can be controlled through
//Bluetooth communication with a mobile app (developed using MIT App
//Inventor).

//Defines
#define RX_PIN                 2 //connected to HC05 Tx pin
#define TX_PIN                -1 //no need to connect HC05 Rx pin to valid Arduino pin
#define SERVO_POS_DELAY     1500
#define SERVO_PIN              9
#define PUMP_PIN               8
#define LEFT_WHEEL_PIN1        5
#define LEFT_WHEEL_PIN2        6
#define LEFT_WHEEL_PWM_PIN     3
#define RIGHT_WHEEL_PIN1       A2
#define RIGHT_WHEEL_PIN2       A3
#define RIGHT_WHEEL_PWM_PIN    11
//App commands
enum AppCmd
{
  CONTROL_PUMP = '0',
  CONTROL_SERVO = '1',
  MOVE_BACK = '2',
  TURN_LEFT = '3',
  STOP = '4',
  TURN_RIGHT = '5',
  MOVE_FORWARD = '6'
};
//Bluetooth
SoftwareSerial bluetooth = SoftwareSerial(RX_PIN,TX_PIN);
//Output devices driven by L298N module
L298N_Dev pump(PUMP_PIN); 
L298N_Dev leftWheel(LEFT_WHEEL_PIN1,LEFT_WHEEL_PIN2,LEFT_WHEEL_PWM_PIN); 
L298N_Dev rightWheel(RIGHT_WHEEL_PIN1,RIGHT_WHEEL_PIN2,RIGHT_WHEEL_PWM_PIN); 
//Servo (Brush/cleaning pad/cloth is attached to a shaft connected to the servo)
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
    case CONTROL_PUMP: 
      pumpState ^= 1;
      pump.Write(pumpState);
      break;
    case CONTROL_SERVO: 
      servo.write(90);//set servo to default position
      servoActivated ^= 1;
      servoStartTime = millis();
      break;
    case MOVE_BACK: 
      leftWheel.SetSpeed(180);
      rightWheel.SetSpeed(180);
      leftWheel.Write(1,0);
      rightWheel.Write(1,0);
      break;
    case TURN_LEFT:
      leftWheel.SetSpeed(220);
      rightWheel.SetSpeed(220);
      leftWheel.Write(1,0);
      rightWheel.Write(0,1);
      break;
    case STOP: 
      leftWheel.Write(0,0);
      rightWheel.Write(0,0);
      break;
    case TURN_RIGHT:
      leftWheel.SetSpeed(220);
      rightWheel.SetSpeed(220);
      leftWheel.Write(0,1);
      rightWheel.Write(1,0);
      break;
    case MOVE_FORWARD:
      leftWheel.SetSpeed(180);
      rightWheel.SetSpeed(180);
      leftWheel.Write(0,1);
      rightWheel.Write(0,1);
      break;    
  }
}

void setup(void) 
{
  pinMode(RX_PIN,INPUT);
  bluetooth.begin(9600);
  servo.attach(SERVO_PIN);
  //switch output devices off
  pump.Write(0);
  leftWheel.SetSpeed(0);
  rightWheel.SetSpeed(0);
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
    const int servoPos[] = {0,180}; //extreme servo positions
    servo.write(servoPos[i]);
    servoStartTime = millis();
    i ^= 1;
  }
}

