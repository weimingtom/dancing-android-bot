#include <Wire.h>
// wire lib.
#include <Servo.h>
// micro servo control lib.

//USB Host Shield Rev.2
#include <avrpins.h>
#include <max3421e.h>
#include <usbhost.h>
#include <usb_ch9.h>
#include <Usb.h>
#include <usbhub.h>
#include <avr/pgmspace.h>
#include <address.h>

#include <adk.h>

#include <printhex.h>
#include <message.h>
#include <hexdump.h>
#include <parsetools.h>

USB Usb;
USBHub hub0(&Usb);
USBHub hub1(&Usb);
ADK adk(&Usb,"Google, Inc.",
"DemoKit",
"DemoKit Arduino Board",
"1.0",
"http://www.android.com",
"0000000012345678");

uint8_t  b, b1;

#define  SERVO1         11 // digital pin 11
#define  SERVO2         12 // digital pin 12
#define  SERVO3         13 // digital pin 13dnq
//define servo_name      pin_number

Servo servos[3]; //define numbers of servo

void setup();
void loop();

void setup() // initial setup function
{
  Serial.begin(115200); // To monitoring ADK by serial port with monitor function in Arduino IDE
  Serial.println("\r\nADK demo start");

  if (Usb.Init() == -1) {
    Serial.println("OSCOKIRQ failed to assert");
    while(1); //halt
  }//if (Usb.Init() == -1...

  servos[0].attach(SERVO1);
  servos[0].write(0);
  servos[1].attach(SERVO2);
  servos[1].write(180);
  servos[2].attach(SERVO3);
  servos[2].write(90);

  //acc.powerOn(); //Ignite voltage on a elements
}

void loop() // action code
{
  uint8_t rcode;
  uint8_t msg[3] = {0x00};
  Usb.Task();

  uint16_t len = sizeof(msg);

  rcode = adk.RcvData(&len, msg);
  if(rcode) {
    USBTRACE2("Data rcv. :", rcode );
  }
  if (len > 0) { 
    USBTRACE("\r\nData Packet."); 
    // assumes only one command per packet
    if (msg[0] == 0x2){
      if (msg[1] == 0x10) // 0x10 select servos[NUMBER], this line calls #1 servo function on Demokit app
        servos[0].write(map(msg[2], 0, 255, 0, 180));  //  left arm(0~255)
      else if (msg[1] == 0x11) // This line(0x11) calls #2 servo servo function on Demokit app
        servos[1].write(map(msg[2], 255, 0, 0, 180));  //  right arm(255~0)
      else if (msg[1] == 0x12) // This line(0x11) calls #3 servo servo function on Demokit app
        servos[2].write(map(msg[2], 0, 255, 80, 160));  //  head control range (0~255), Decreased head parts movement angle (65~140)

      // control two servo at once is still not working, 
      /* Still buggy, it mulfunctionize same way on #1 servo and #3 servo
       else if (msg[1] == 0x12) // This line(0x12) calls #3 servo servo function on Demokit app
       					servos[0].write(map(msg[2], 0, 255, 0, 180));  //  left arm(0~255)
       					servos[1].write(map(msg[2], 255, 0, 0, 180));  //  right arm(255~0)
       */
      msg[0] = 0x1;
    }
    delay(0);
  }
}

/*                        
 		msg[0] = 0x1;
 
 		switch (count++ % 0x10) {
 		case 0:
 break; 
 	} *//*
	else {  // reset outputs to default values when no input in a 10 seconds.
 		servos[0].write(0);  // left arm set to initial position(lay)
 		servos[1].write(180); // right arm set to initial position(lay)
 		servos[2].write(90);  // head face heading to front angle.
 	}
 	delay(0); // control response timing (immidiate)
 // loop function close*/







