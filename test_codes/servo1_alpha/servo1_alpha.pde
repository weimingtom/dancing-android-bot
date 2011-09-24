#include <Wire.h>
// wire libs.
#include <Servo.h>
// micro servo control libs.

#include <Max3421e.h>
#include <Usb.h>
#include <AndroidAccessory.h>

#define  SERVO1         13

AndroidAccessory acc("Google, Inc.",
		     "DemoKit",
		     "DemoKit Arduino Board",
		     "1.0",
		     "http://www.android.com",
		     "0000000012345678");

Servo servos[1];

void setup();
void loop();

void setup()
{
	Serial.begin(115200);
	Serial.print("\r\nStart");

	servos[0].attach(SERVO1);
	servos[0].write(90);

	acc.powerOn();
}

void loop()
{
	byte err;
	byte idle;
	static byte count = 0;
	byte msg[3];
 
	if (acc.isConnected()) {
                Serial.print("Accessory connected. ");
		int len = acc.read(msg, sizeof(msg), -1);
                Serial.print("Message length: ");
                Serial.println(len, DEC);
        }
 	delay(100);

	if (acc.isConnected()) {
		int len = acc.read(msg, sizeof(msg), -1);
		
		if (len > 0) {
			// assumes only one command per packet
			if (msg[0] == 0x2) {
				if (msg[1] == 0x10){
					servos[0].write(map(msg[2], 0, 255, 0, 180));
                                }
            		}

		msg[0] = 0x1;

		switch (count++ % 0x10) {
		case 0:
                break;
		}
	} else {
		// reset outputs to default values on disconnect
		servos[0].write(90);
		servos[0].write(90);
		servos[0].write(90);
	}

	delay(10);
      }
}



