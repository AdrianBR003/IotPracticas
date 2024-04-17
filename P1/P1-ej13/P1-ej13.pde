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

    // UDP client 

    error = WIFI_PRO.setUDP("192.168.1.101","3500","2500");
    if(error==0){
        USB.println("Cliente UDP creado");
        USB.println("Enviando datos");
        error = WIFI_PRO.send(socket_handle, "Puesto 12");
        if(error==0){
          USB.println("Los datos se han enviado correctamente");
          delay(5000);
          }else{
            USB.println("Los datos no se han enviado correctamente");
            }
      }else{
        USB.println("ERROR Cliente UDP");
        }


    // UDP Server 

    if (error == 0){
      USB.println("Open UDP server OK"); 

      error2 = WIFI_PRO.receive(WIFI_PRO._socket_handle,50000);
      if(error2==0){
          USB.println("Escuchando..."); 
          USB.println(WIFI_PRO._buffer,WIFI_PRO._length);
        }else{
          USB.println("Fallo en la recepción");   
        } 
    } else {
      USB.println("Error calling setUDPserver function");
      WIFI_PRO.printErrorCode();
    }

  }else{
    USB.println(" NO Se ha conectado!");   
    Utils.setLED(LED0,LED_ON);
  }

}
