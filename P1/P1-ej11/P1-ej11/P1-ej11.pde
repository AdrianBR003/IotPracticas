#include <WaspWIFI_PRO.h>

  char ESSID[] = "telema2";
  char PASSW[] = "teleco2015";
  char HOST[] = "170.20.10.9";
  uint16_t RPORT = 3500;
  uint16_t LPORT = 2000;
  int error; 
  uint16_t socket_handle=0; 
  char DATA[100];
  char id[] = "puesto 4";
  int temp = 0;
  int bat = 0; 
  
  
void setup()
{
 USB.ON();

 WIFI_PRO.ON(SOCKET0); 
 WIFI_PRO.resetValues();
 WIFI_PRO.setESSID(ESSID);
 WIFI_PRO.setPassword(WPA2,PASSW);
  
}


void loop()
{
 
 socket_handle = WIFI_PRO._socket_handle; 
  if(WIFI_PRO.isConnected()){
    USB.println("Se ha conectado al WIFI!");   
    WIFI_PRO.getIP();
    WIFI_PRO.getGateway();
    USB.println(WIFI_PRO._ip);
    USB.println(WIFI_PRO._gw);
      error = WIFI_PRO.setTCPclient("92.191.138.237","3500","3500"); 
      USB.println(error);

      float valor;
      float voltios; 
      float temperatura; 
      valor = analogRead(ANALOG6);
      voltios = (valor*3.3)/1023;
      temperatura = voltios/0.01;

      bat = (PWR.getBatteryLevel(),DEC);
      
      sprintf(DATA,"id=%s ; temp=%d ; bat=%d",id,temp,bat);
         
      WIFI_PRO.send(socket_handle,DATA); 
      USB.print("Sesion TCP = ");
      USB.println(socket_handle,DEC); 
      delay(5000);

  }else{
    USB.println(" NO Se ha conectado!");   
    Utils.setLED(LED0,LED_ON);
    }
}
