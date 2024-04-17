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
    int error; 

    WIFI_PRO.getIP();
    WIFI_PRO.getGateway();
    WIFI_PRO.getNetmask();
    WIFI_PRO.getDNS(1);
    
    error = WIFI_PRO.getIP();
    if(error==0){
      USB.print("IP= ");
      USB.println(WIFI_PRO._ip);
    }else{
      USB.println("Ip ERROR");    
    }

    error = WIFI_PRO.getGateway();
    if(error==0){
      USB.print("GW= ");
      USB.println(WIFI_PRO._gw);
    }else{
      USB.println("GW ERROR");    
    }

    error = WIFI_PRO.getNetmask();
    if(error==0){
      USB.print("Netmask= ");
      USB.println(WIFI_PRO._netmask);
    }else{
      USB.println("Netmask ERROR");    
    }

    error = WIFI_PRO.getDNS(1);
    if(error==0){
      USB.print("DNS= ");
      USB.println(WIFI_PRO._dns1);
    }else{
      USB.println("DNS ERROR");    
    }
   
  }else{
    USB.println(" NO Se ha conectado!");   
    Utils.setLED(LED0,LED_ON);
    }
}
