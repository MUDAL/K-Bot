#include "BluetoothSerial.h"
#include "outputDev.h"

//Output devices driven by L298N module
OutputDev pump(0,5);
OutputDev brush(1,23);
OutputDev leftWheel(2,15);
OutputDev rightWheel(3,17);
//Inbuilt Bluetooth
BluetoothSerial bluetooth;

static void ProcessAppData(char appData)
{
  static bool togglePump;
  static bool toggleBrush;
  switch(appData)
  {
    case '0': //Pump control
      togglePump ^= true;
      pump.WritePin(togglePump);
      break;
    case '1': //Brush control
      toggleBrush ^= true;
      brush.WritePin(toggleBrush);
      break;
    case '2': //Move Back
      break;
    case '3': //Turn Left
      break;
    case '4': //Stop
      leftWheel.WritePins(false,false);
      rightWheel.WritePins(false,false);
      break;
    case '5': //Turn Right
      break;
    case '6': //Move Forward
      break;
  }
}

void setup() 
{
  setCpuFrequencyMhz(80);
  bluetooth.begin("K-Bot");
  //Enable PWM for the actuators with appropriate duty cycle (in %)
  pump.EnablePWM(90);
  brush.EnablePWM(55);
  leftWheel.EnablePWM(65);
  rightWheel.EnablePWM(65);
  
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