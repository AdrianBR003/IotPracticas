/*
    ------ Waspmote Pro Code Example --------

    Explanation: This is the basic Code for Waspmote Pro

    Copyright (C) 2016 Libelium Comunicaciones Distribuidas S.L.
    http://www.libelium.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// Put your libraries here (#include ...)
#include <WaspUtils.h>

void setup()
{
  USB.ON();
}


void loop()
{ 
  
  USB.println("LED 0 parpadeando\n");
  Utils.blinkRedLED(1000, 5);

  delay(1000);

  USB.println("LED 0 apagado\n");
  Utils.setLED(LED0, LED_OFF);

  delay(5000);

  USB.println("LED 1 parpadeando\n");
  Utils.blinkGreenLED(1000, 10);

  delay(1000);

  USB.println("LED 1 apagado\n");
  Utils.setLED(LED1, LED_OFF);

  
  delay(5000);
}
