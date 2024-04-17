#include <WaspWIFI_PRO.h>

void setup()
{
 USB.ON();

 WIFI_PRO.ON(SOCKET0); 
}


void loop()
{
  char ESSID[] = "teleco";
  char PASSW[] = "contrasena2015";
  WIFI_PRO.setESSID(ESSID);
  WIFI_PRO.setPassword(WPA2,PASSW);
  
  if(WIFI_PRO.isConnected()){
    
    USB.println("Se ha conectado!");   
    Utils.setLED(LED1,LED_ON);
    delay(5000);
    Utils.setLED(LED1,LED_OFF);

  }else{
    USB.println(" NO Se ha conectado!");   
    Utils.setLED(LED0,LED_ON);
    }
}
