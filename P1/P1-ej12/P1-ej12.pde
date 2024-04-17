#include <WaspWIFI_PRO.h>

  char ESSID[] = "IoT";
  char PASSW[] = "12345678";
  char HOST[] = "170.20.10.9";
  uint16_t RPORT = 3500;
  uint16_t LPORT = 2000;
  int error; 
  int error2; 
  uint16_t socket_handle=0; 
  char DATA[] = "Puesto 12";
  char id[] = "puesto 4";
  int temp = 0;
  int bat = 0; 
  
  
void setup()
{

}
void loop()
{   



  USB.ON();
  
  WIFI_PRO.ON(SOCKET0); 
  WIFI_PRO.resetValues();
  WIFI_PRO.setESSID(ESSID);
  WIFI_PRO.setPassword(WPA2,PASSW);

  socket_handle = WIFI_PRO._socket_handle; 
  
  if(WIFI_PRO.isConnected()){
    USB.println("Se ha conectado al WIFI!");   
    WIFI_PRO.getIP();
    WIFI_PRO.getGateway();
    USB.println(WIFI_PRO._ip);
    USB.println(WIFI_PRO._gw);

    //cliente TCP 
    
    error = WIFI_PRO.setTCPclient("192.168.1.101","3500","2500");
    USB.println(error); 
    
    WIFI_PRO.send(socket_handle,DATA); 
    USB.print("Sesion TCP = ");
    USB.println(socket_handle,DEC); 
    delay(5000);

      
    //servidor TCP
    //error = WIFI_PRO.setTCPserver("2000", 3);
    
    if (error == 0){
      USB.println("Open TCP server OK"); 

      error2 = WIFI_PRO.receive(WIFI_PRO._socket_handle,50000);
      if(error2==0){
          USB.println("Escuchando..."); 
          USB.println(WIFI_PRO._buffer,WIFI_PRO._length);
        }else{
          USB.println("Fallo en la recepción");   
        } 
    } else {
      USB.println("Error calling setTCPserver function");
      WIFI_PRO.printErrorCode();
    }
  }else{
    USB.println(" NO Se ha conectado!");   
    Utils.setLED(LED0,LED_ON);
  }

}
