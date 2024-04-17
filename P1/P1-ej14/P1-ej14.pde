#include <WaspWIFI_PRO.h>

  char ESSID[] = "telema2";
  char PASSW[] = "teleco2015";
  uint16_t RPORT = 3500;
  uint16_t LPORT = 2000;
  int error; 
  int error2; 
  uint16_t socket_handle=0; 
  char DATA[] = "Puesto 12";
  char id[] = "IoT3";
  char temp[5]="10";
  char bat[10]; 
  char type[] = "http"; // "http" or "https"
  char host[] = "192.168.0.128";
  char port[] = "80";
  char link[50];
  
  
void setup()
{

  USB.ON();
  
  WIFI_PRO.ON(SOCKET0); 
  WIFI_PRO.resetValues();
  WIFI_PRO.setESSID(ESSID);
  WIFI_PRO.setPassword(WPA2,PASSW);

  socket_handle = WIFI_PRO._socket_handle; 
  
}
void loop()
{   



  if(WIFI_PRO.isConnected()){
    USB.println("Se ha conectado al WIFI!");   
    WIFI_PRO.getIP();
    WIFI_PRO.getGateway();
    USB.println(WIFI_PRO._ip);
    USB.println(WIFI_PRO._gw);
    Utils.long2array(PWR.getBatteryLevel(),bat);
    USB.println(bat);
    sprintf(link, "/rdin.php?i=%s&t=%s&b=%s", id, temp, bat);
    USB.println(link);
    // Peticion 'GET' HTTP 
    error = WIFI_PRO.getURL( type, host, port, link); 

    // check response
    if (error == 0)
    {
      USB.println(F("HTTP GET OK"));          
      USB.print(F("HTTP Time from OFF state (ms):"));
      
      USB.print(F("\nServer answer:"));
      USB.println(WIFI_PRO._buffer, WIFI_PRO._length);
      delay(5000);
      }
    else
    {
      USB.println(F("Error calling 'getURL' function"));
      WIFI_PRO.printErrorCode();
    }

  }
}
