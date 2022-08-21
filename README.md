# K-Bot  
The K-Bot is a floor cleaning robot with manual and automatic control.  
The aim of this project is to reduce the cost of a floor cleaning robot without altering its quality.     
The initial stage of the project involves developing and testing the manual aspects of the system.   
Currently, research is being done on the positioning and navigation of the robot in an indoor environment.   

The current prototype is manually controlled by an app (created using MIT App Inventor) through Bluetooth  
communication. Automation of this system is a plan for the future.  

## Components used for the current prototype  
1. Arduino Nano    
2. L298N Module (x2)    
3. MG996R Metal gear servo   
4. LM2596 Buck converter    
5. 7805 regulator    
6. On/Off switch     
7. 18650 Li-ion battery (x3)     
8. 18650 3-cell battery case     
9. Wooden chassis     
10. 12V Self-priming pump       
11. Water container    
12. Plastic enclosure   
13. HC05 Bluetooth module  

## Choice of power supply  
Initially regulated the 11.1v from the 3 Li-ion batteries to 5v using the LM2596 module.    
The 5v was used to power both the servo and the HC05 module. However, the servo drew a lot of power     
such that the HC05 started resetting itself thereby breaking Bluetooth connection between the K-Bot and     
the app.     
This issue was fixed by ensuring both the servo and the HC05 were powered by different 5v sources. The     
LM2596 was used to power the servo because the LM2596 can source more than 2A of current. Since the HC05     
wasn't drawing too much current, a simple 7805 regulator was added to power the HC05 separately. This prevented    
the HC05 from experiencing resets due to the servo's power consumption.      

## Choice of servo   
Initially, a plastic gear servo was used but it didn't last long as the gears stripped when the servo fell to the  
ground. Now, I could have replaced the gears but I decided to opt for the metal gear servo for strength and less  
probability of stripping.  

## How it works   
K-Bot is controlled through the app developed using the MIT App Inventor. The following controls are made using the app:
1. Movement (forward, backward, right, left)     
2. Activation and de-activation of the water pump (tp enable/disable water dispensation)   
3. Activation and de-activation of the servo (to enable/disable cleaning action)  
