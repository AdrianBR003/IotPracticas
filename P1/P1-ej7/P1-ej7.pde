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

void setup()
{
  USB.ON();
  RTC.ON(); 
  RTC.setTime("24:03:13:06:11:06:00");
  analogRead(ANALOG6);
}


void loop()
{
  float valor;
  float voltios; 
  float temperatura; 
  valor = analogRead(ANALOG6);
  voltios = (valor*3.3)/1023;
  temperatura = voltios/0.01;
  
  USB.println("Modo Activo");
  USB.print("Temperatura= ");
  USB.print(temperatura);
  USB.println(" ºC");
  USB.print("Fecha y Hora= ");
  USB.println(RTC.getTime());
  USB.print("Bateria= ");
  USB.print((PWR.getBatteryLevel(),DEC)); //Hay que ponerlo en decimal
  USB.println("%"); 
  USB.println("Se activará el modo SLEEP durante 30 segundos"); //Cambiar a 30
  PWR.sleep(WTD_32MS,ALL_OFF);
  USB.println("Modo Activo");

}
