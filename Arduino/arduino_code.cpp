/* Including all dependencies */

#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

#if defined(ESP32)
#include <WiFi.h>
#include <FirebaseESP32.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#endif

/**/

/* Setting baseline values for moisture sensor */
const int DryValue = 643;  
const int WetValue = 319;  

/* Helper functions */
#include "addons/RTDBHelper.h"

/* Wifi Creds */
#define WIFI_SSID "insert wifi name here"
#define WIFI_PASSWORD "insert wifi password here"

/* Database Authh*/
#define DATABASE_URL "insert database url here" //<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app
#define DATABASE_SECRET "insert auth token here"

/* Firebase Requirements */

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

int count = 0;
String path = "/HackProj";


void setup() {
  Serial.begin(9600);
  wifiSetup();
}

void wifiSetup(){
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  config.database_url = DATABASE_URL;
  config.signer.tokens.legacy_token = DATABASE_SECRET;

  Firebase.reconnectWiFi(true);

  /* Initialize the library with the Firebase auth and config */
  Firebase.begin(&config, &auth);
}

int sensorRead(){
  // Read the soil moisture sensor
  int moistureVal = analogRead(A0);
  int moisturePercent = map(moistureVal, DryValue, WetValue, 0, 100);
  return moisturePercent;
}

void loop() {
  int moisturePercent = sensorRead();
  
  if (moisturePercent >= 100) {
    Serial.println("100 %");
    Firebase.setDouble(fbdo, path + "/Moisture", 100);
  }
  
  else if (moisturePercent <= 0) {
    Serial.println("0 %");
    Firebase.setDouble(fbdo, path + "/Moisture", 0);
  }
  
  else if (moisturePercent > 0 && moisturePercent < 100) {
    Serial.print(moisturePercent);
    Serial.println(" %");
    Firebase.setDouble(fbdo, path + "/Moisture", moisturePercent);
  }
  delay(2000); // Delay by two seconds
}

