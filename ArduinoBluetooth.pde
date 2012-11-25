#include <NewSoftSerial.h>

int bluetoothTx = 2;
int bluetoothRx = 3;
int ledPin = 13;

NewSoftSerial bluetooth(bluetoothTx, bluetoothRx);

void setup()
{
  //Setup usb serial connection to computer
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT); 
  //Setup Bluetooth serial connection to android
  bluetooth.begin(115200);
  bluetooth.print("$$$");
  delay(100);
  bluetooth.println("U,9600,N");
  bluetooth.begin(9600);
}

void loop()
{
  //Read from bluetooth and write to usb serial
  if(bluetooth.available())
  {
    char toSend = (char)bluetooth.read();
    Serial.println(toSend);
    if(toSend == 'h')
    {
      digitalWrite(ledPin, HIGH); // set the LED on
      bluetooth.println("Light On");
    }
      
    if(toSend == 'l')
    {
      digitalWrite(ledPin, LOW); // set the LED off
      bluetooth.println("Light Off");
    }
  }

  //Read from usb serial to bluetooth
  if(Serial.available())
  {
    char toSend = (char)Serial.read();
    bluetooth.print(toSend);
  }
}
