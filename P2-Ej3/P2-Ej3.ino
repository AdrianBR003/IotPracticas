#include <DHT.h>

/*Sensor de Temperatura y Humedad DHT11 en Display LCD
Instrucciones:
Recuerda descargar la libreria DHT para poder utilizar este sensor
Conectaremos el Sensor DHT11 a 5v y el pin de señal a la entrada digital 7
*OJO* Utilizaremos un Display LCD controlado mediante un Modulo Serial I2C
*/
#include <Ethernet.h>
#include <Wire.h>                 
#include <LiquidCrystal.h>
#define DHT11_PIN 9

DHT dht11(DHT11_PIN, DHT11);

LiquidCrystal lcd(7, 6, 5, 4, 3, 2);

//Conexion a internet
byte mac[] = {0x90, 0xA2, 0xDA, 0x11, 0x3D, 0x13};
IPAddress ip(192,168,15,178);
IPAddress gateway(192,168,15,254);
IPAddress subnet(255,255,255,0);

IPAddress server(192,168,15,217);

void setup() {
  Serial.begin(9600);
  lcd.begin(16,2);// Indicamos medidas de LCD
  dht11.begin();
  Ethernet.begin(mac);
}



void loop() {

  float temperature = dht11.readTemperature();
  float humidity = dht11.readHumidity();
  
  lcd.clear();
  
  EthernetClient client;
  
  lcd.setCursor(0,0);
  lcd.print("Intentado conectar al servidor");
  Serial.println("Intentado conectar al servidor");
  
  if(client.connect(server, 80)){
    
    lcd.setCursor(0,0);
    lcd.print("Conectado Correctamente");
    delay(2000);
    lcd.clear();
    
    // Formateamos datos y query
    char id[5]="IoT1";
    char string_temperatura[5];
    char string_humedad[5];
    char query[50];
    char buffer[200];
    float len;

    dtostrf(temperature,2,1, string_temperatura);
    dtostrf(humidity,2,1, string_humedad);

    sprintf(query, "GET /rdin.php?i=%s&t=%s&h=%s", id, string_temperatura, string_humedad);
    
    // Enviamos peticion
    client.println(query);

    Serial.println(query); 
    
    while(client.connected()){
      Serial.println("Escuchando servidor...");
      lcd.print("Escuchando servidor...");
      if((len =client.available()) > 0){
        char c = client.read(buffer, len);
        Serial.println(c); 
        client.stop();
      }
      
      if(!client.connected()){
        client.stop();
        Serial.println("Conexion cerrada"); 
        lcd.clear();
        lcd.print("Conexion cerrada");
        delay(1000);
      }
    }
  }else {
    lcd.clear();
    lcd.setCursor(0,0);
    lcd.print("Error conex");
    Serial.println("Error conex");
    delay(2000);
  }


  // Mostrar temp y humd
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Temp: ");
  lcd.print(temperature);
  lcd.print(" C");
  
  lcd.setCursor(0,1);
  lcd.print("Humd: ");
  lcd.print(humidity);
  lcd.print(" %");
  // -------------------
  
  delay(5000);
}
