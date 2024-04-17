#include <WaspWIFI_PRO.h>

  char ESSID[] = "telema2";
  char PASSW[] = "teleco2015";
  uint16_t RPORT = 3500;
  uint16_t LPORT = 2000;
  int error; 
  int error2; 
  uint16_t socket_handle=0; 
  char DATA[] = "Puesto 12";
  char id[] = "puesto 4";
  char temp[5]="10";
  char bat[5]="5"; 
  char type[] = "https"; // "http" or "https"
  char host[] = "api.thingspeak.com";
  char port[] = "443";
  char link[50];
char TRUSTED_CA[] =\ 
"-----BEGIN CERTIFICATE-----\r"\
"MIIDjjCCAnagAwIBAgIQAzrx5qcRqaC7KGSxHQn65TANBgkqhkiG9w0BAQsFADBh\r"\
"MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3\r"\
"d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBH\r"\
"MjAeFw0xMzA4MDExMjAwMDBaFw0zODAxMTUxMjAwMDBaMGExCzAJBgNVBAYTAlVT\r"\
"MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j\r"\
"b20xIDAeBgNVBAMTF0RpZ2lDZXJ0IEdsb2JhbCBSb290IEcyMIIBIjANBgkqhkiG\r"\
"9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuzfNNNx7a8myaJCtSnX/RrohCgiN9RlUyfuI\r"\
"2/Ou8jqJkTx65qsGGmvPrC3oXgkkRLpimn7Wo6h+4FR1IAWsULecYxpsMNzaHxmx\r"\
"1x7e/dfgy5SDN67sH0NO3Xss0r0upS/kqbitOtSZpLYl6ZtrAGCSYP9PIUkY92eQ\r"\
"q2EGnI/yuum06ZIya7XzV+hdG82MHauVBJVJ8zUtluNJbd134/tJS7SsVQepj5Wz\r"\
"tCO7TG1F8PapspUwtP1MVYwnSlcUfIKdzXOS0xZKBgyMUNGPHgm+F6HmIcr9g+UQ\r"\
"vIOlCsRnKPZzFBQ9RnbDhxSJITRNrw9FDKZJobq7nMWxM4MphQIDAQABo0IwQDAP\r"\
"BgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBhjAdBgNVHQ4EFgQUTiJUIBiV\r"\
"5uNu5g/6+rkS7QYXjzkwDQYJKoZIhvcNAQELBQADggEBAGBnKJRvDkhj6zHd6mcY\r"\
"1Yl9PMWLSn/pvtsrF9+wX3N3KjITOYFnQoQj8kVnNeyIv/iPsGEMNKSuIEyExtv4\r"\
"NeF22d+mQrvHRAiGfzZ0JFrabA0UWTW98kndth/Jsw1HKj2ZL7tcu7XUIOGZX1NG\r"\
"Fdtom/DzMNU+MeKNhJ7jitralj41E6Vf8PlwUHBHQRFXGU7Aj64GxJUTFy8bJZ91\r"\
"8rGOmaFvE7FBcf6IKshPECBV1/MUReXgRPTqh5Uykw7+U0b6LJ3/iyK5S9kJRaTe\r"\
"pLiaWN0bfVKfjllDiIGknibVb63dDcY3fe0Dkhvld1927jyNxF1WW6LZZm6zNTfl\r"\
"MrY=\r"\
"-----END CERTIFICATE-----";

void setup()
{
 
 USB.ON();
  
  WIFI_PRO.ON(SOCKET0); 
  WIFI_PRO.resetValues();
  WIFI_PRO.setESSID(ESSID);
  WIFI_PRO.setPassword(WPA2,PASSW);
  socket_handle = WIFI_PRO._socket_handle; 


  int error = WIFI_PRO.setCA(TRUSTED_CA);

  if(error==0){
        USB.println("Trusted CA OK"); 
      }else{
        USB.println("False CA ER");
        }
}
void loop()
{   

  USB.println("Entrando en el bucle"); 
  
  if(WIFI_PRO.isConnected()){
    USB.println("Se ha conectado al WIFI!");   
    WIFI_PRO.getIP();
    WIFI_PRO.getGateway();
    USB.println(WIFI_PRO._ip);
    USB.println(WIFI_PRO._gw);
    
    sprintf(link, "/update?api_key=DOF975KIXQH5LCFP&field1=%s&field2=%s", temp, bat);
    // Peticion 'GET' HTTP 
    error = WIFI_PRO.getURL( type, host, port, link); 

    // check response
    if (error == 0)
    {
      USB.println(F("HTTP GET OK"));          
      USB.print(F("HTTP Time from OFF state (ms):"));
      
      USB.print(F("\nServer answer:"));
      USB.println(WIFI_PRO._buffer, WIFI_PRO._length);
    }
    else
    {
      USB.println(F("Error calling 'getURL' function"));
      WIFI_PRO.printErrorCode();
    }

  }

}

