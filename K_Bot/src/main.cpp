#include "outputDev.h"

//Output devices driven by L298N module
OutputDev pump(0,5);
OutputDev brush(1,23);
OutputDev leftWheel(2,15);
OutputDev rightWheel(3,17);

void setup() 
{
}

void loop() 
{
  //Testing the actuators
  pump.EnablePWM(35);
  brush.EnablePWM(50);
  leftWheel.EnablePWM(75);
  rightWheel.EnablePWM(100);
  delay(5000);

  pump.DisablePWM();
  brush.DisablePWM();
  leftWheel.DisablePWM();
  rightWheel.DisablePWM();
  delay(5000);
}