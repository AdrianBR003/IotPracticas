
// ALUMNOS: Adrian Benitez Roldan y Alejandron Montes Cantero

#include <SPI.h>
#include <Ethernet.h>
#include <Wire.h>    
#include <DHT.h>
             
#define DHT11_PIN 9
DHT dht11(DHT11_PIN, DHT11);


// Definir la dirección MAC del shield Ethernet
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };

// Definir la dirección IP del Arduino
IPAddress ip(192, 168, 15, 177); // Modifica la dirección IP según tu red

// Crear un servidor web en el puerto 80
EthernetServer server(80);



void setup() {
  // Inicializar el puerto serie
  Serial.begin(9600);

  // Inicializar el shield Ethernet usando DHCP para obtener una dirección IP
  if (Ethernet.begin(mac) == 0) {
    Serial.println("Error al configurar Ethernet usando DHCP");
    // Si falla la configuración DHCP, puedes usar una dirección IP estática
    Ethernet.begin(mac, ip);
  }

  // Iniciar el servidor
  server.begin();

  Serial.print("Servidor disponible en: ");
  Serial.println(Ethernet.localIP());

  dht11.begin();
}

void loop() {
  // Esperar a que se conecte un cliente
  EthernetClient client = server.available();
  if (client) {
    Serial.println("Nuevo cliente");
    // Esperar a que el cliente envíe datos
    while (client.connected()) {
      if (client.available()) {
        
        // Leer la solicitud del cliente
        String request = client.readStringUntil('\r');
      
        // Leer la temperatura del sensor
        float temperature = dht11.readTemperature();
        float humidity = dht11.readHumidity();
        
        Serial.println(temperature);
        
        //formateamos datos 
        char string_temperatura[5];
        char string_humedad[5];
        dtostrf(temperature,2,1, string_temperatura);
        dtostrf(humidity,2,1, string_humedad);
        

        // Enviar la respuesta al cliente con la temperatura
        client.println("HTTP/1.1 200 OK");
        client.println("Content-Type: text/plain");
        client.println();
        client.print("Temperatura: ");
        client.print(string_temperatura);
        client.println(" grados Celsius");
        client.print("Humedad: ");
        client.print(string_humedad);
        break;
      }
    }
    // Cerrar la conexión
    delay(1);
    client.stop();
    Serial.println("Cliente desconectado");
  }
}
