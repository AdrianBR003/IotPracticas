#include <WaspWIFI_PRO.h>

  char ESSID[] = "teleco";
  char PASSW[] = "contrasena2015";
  char HOST[] = "92.191.138.237";
  uint16_t RPORT = 3500;
  uint16_t LPORT = 2000;
  int error; 
  uint16_t socket_handle=0; 
  char DATA[] = "";
  char *idd = "IotT1";
  int temp = 23; 
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
      sprintf(DATA,"id=%s ; temp=%d ; bat=%d",idd,temp,bat);
      char DATA1[] ="hola";
      WIFI_PRO.send(socket_handle,DATA1); 
      USB.print("Sesion TCP = ");
      USB.println(socket_handle,DEC); 
      delay(5000);

  }else{
    USB.println(" NO Se ha conectado!");   
    Utils.setLED(LED0,LED_ON);
    }
}

