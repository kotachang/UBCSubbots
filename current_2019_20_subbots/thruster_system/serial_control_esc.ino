#include <Servo.h>
#include <String.h>
//This Arduino program allows the user to control the motor speed with a serial monitor input.
//It can be easily adapted to receive I2C signals from the TX2; 
//the motor is stopped when the user inputs '1500', is in forward mode between 1500 and 1900. 
//At 1750, we appear to draw ~4 A which is the limit of a single power supply. 

byte servoPin = 9;
Servo servo;
String instring= ""; //String to hold input 

void setup() {
//Serial startup
  Serial.begin(9600);
  while(!Serial){ 
    ; //Wait for serial connection; 
  }
Serial.println("Enter a pulse-width between 1500 and 1700\n");

  
  servo.attach(servoPin);

  servo.writeMicroseconds(1500+25, 1); // send "stop" signal to ESC.

  delay(7000); // delay to allow the ESC to recognize the stopped signal
}
int rx_int=0;

    int signal;
void loop() {
    int fudge_factor=25;

  
  if (Serial.available() > 0) {    // is a character available?
   int inChar = Serial.read();
   if (isDigit(inChar)){
    //convert the incomping byte to a char and add it to the string; 
    instring += (char)inChar;
   }
   if(inChar=='\n'){
    signal=instring.toInt()+fudge_factor;
    Serial.println(instring);
    Serial.println(signal);
    instring="";
   }
  }
  
 // int signal =rx_int+fudge_factor; // Set signal value, which should be between 1100 and 1900
  bool invert=1;
  servo.writeMicroseconds(signal,invert); // Send signal to ESC.
}
