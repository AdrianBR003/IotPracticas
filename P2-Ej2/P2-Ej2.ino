#include <DHT.h>

/*Sensor de Temperatura y Humedad DHT11 en Display LCD
Instrucciones:
Recuerda descargar la libreria DHT para poder utilizar este sensor
Conectaremos el Sensor DHT11 a 5v y el pin de señal a la entrada digital 7
*OJO* Utilizaremos un Display LCD controlado mediante un Modulo Serial I2C
*/

#include <Wire.h>                 
#include <LiquidCrystal.h>
#define DHT11_PIN 9

DHT dht11(DHT11_PIN, DHT11);

LiquidCrystal lcd(7, 6, 5, 4, 3, 2);
void setup() {
  lcd.begin(16,2);// Indicamos medidas de LCD
  dht11.begin();
}

void loop() {
  float temperature = dht11.readTemperature();
  float humidity = dht11.readHumidity();
  
  
  lcd.setCursor(0,0);
  lcd.print("Temp: ");
  lcd.print(temperature);
  lcd.print(" C");
  
  lcd.setCursor(0,1);
  lcd.print("Humd: ");
  lcd.print(humidity);
  lcd.print(" %"); 

  delay(2000);
}
