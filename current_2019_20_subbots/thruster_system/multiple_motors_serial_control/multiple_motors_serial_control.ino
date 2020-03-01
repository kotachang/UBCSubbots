#include <Servo.h>
#include <String.h>
//This Arduino program allows the user to control the motor speed with a serial monitor input.
//It can be easily adapted to receive I2C signals from the TX2;
//the motor is stopped when the user inputs '1500', is in forward mode between 1500 and 1900.
//At 1750, we appear to draw ~4 A which is the limit of a single power supply.

//pins that work


byte servoPin = 6;
byte servoPin2 = 7;
byte servoPin3 = 8;
byte servoPin4 = 9;
byte servoPin5 = 10;
byte servoPin6 = 11;

String instring = ""; //String to hold input

Servo servo, servo2, servo3, servo4, servo5, servo6;

void setup() {
  //Serial startup
  Serial.begin(9600);
  while (!Serial) {
    ; //Wait for serial connection;
  }
  Serial.println("Enter a pulse-width between 1500 and 1700\n");


  servo.attach(servoPin);
 servo2.attach(servoPin2);
  servo3.attach(servoPin3);
   servo4.attach(servoPin4);
    servo5.attach(servoPin5);
     servo6.attach(servoPin6);
     
  delay(100);

  servo.writeMicroseconds(1500); // send "stop" signal to ESC.
  servo2.writeMicroseconds(1500);
  servo3.writeMicroseconds(1500);
  servo4.writeMicroseconds(1500); 
  servo5.writeMicroseconds(1500);
  servo6.writeMicroseconds(1500);
  
  delay(7000); // delay to allow the ESC to recognize the stopped signal
}
int rx_int = 0;

int signal = 1500;


void loop() {

  if (Serial.available() > 0) {    // is a character available?
    int inChar = Serial.read();
    if (isDigit(inChar)) {
      //convert the incomping byte to a char and add it to the string;
      instring += (char)inChar;
    }
    if (inChar == '\n') {
      signal = instring.toInt();
      Serial.println(instring);
      Serial.println(signal);
      instring = "";
    }
  }

  servo.writeMicroseconds(signal-400);

  servo2.writeMicroseconds(signal);// Send signal to ESC.
  servo3.writeMicroseconds(signal);
  servo4.writeMicroseconds(signal);
  servo5.writeMicroseconds(signal);
  servo6.writeMicroseconds(signal);
  
  delay(500);

}
