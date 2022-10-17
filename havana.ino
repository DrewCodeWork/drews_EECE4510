/******************************************************************************
* EECE 4510 / 5510 Digital Signal Processing
*
* Sketch to read photo resistor signal on A5. 
* When light from unconnected fluorescent bulb is detected, RF may be present.
* 
* Results are  displayed on 8x2 LCD display
*
* Original Code Credit:
* Fred J. Frigo
* Marquette University
* Sep 25, 2022
*
* Edited Version:
* Andrew Simon
* Marquette University
* Oct 18, 2022
*
* Kuman 1602 LCD Shield for Arduino:
*
* LCD RS pin to digital pin 8
* LCD Enable pin to digital pin 9
* LCD D4 pin to digital pin 4
* LCD D5 pin to digital pin 5
* LCD D6 pin to digital pin 6
* LCD D7 pin to digital pin 7
******************************************************************************/

// Include statements
#include <LiquidCrystal.h>

// Initialize parameters
unsigned int SAMPLE_SIZE = 10;
unsigned int sample_list[10];
unsigned int count = 0;

// initialize the library with the numbers of the interface pins of LCD display
LiquidCrystal lcd(8, 9, 4, 5, 6, 7);

// Setup function
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);

  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
}

// Main loop
void loop() {
  int sensorValue = analogRead(A5); //Read ADC value of A5
  sample_list[count] = sensorValue; //Store sample in list
  count += 1;                       //Increment sample count
  count = count % SAMPLE_SIZE;      //Keep count in sample range

  // Calculate average of samples
  unsigned int avgSample = 0;
  for (unsigned int i = 0; i < SAMPLE_SIZE; i++){
    avgSample += sample_list[i];
  }
  avgSample = (int)(avgSample / SAMPLE_SIZE);

  // Calculate and display voltage of average sample
  float avgVolt = avgSample * (5 / 1024.0);
  lcd.setCursor(0, 0);            // Set the cursor to column 0, line 0
  lcd.print("Volt (V): ");
  lcd.print(avgVolt);

  // Display average sample
  lcd.setCursor(0, 1);            // Set the cursor to column 0, line 1
  lcd.print("ADC Avg.: ");

  // Determine the number of digits needed to display
  if (avgSample < 10){          // Sensor value is one digit
    lcd.print(" ");
  } else if(avgSample < 100) {  // Sensor value is two digits
    lcd.print(" ");
  } else if(avgSample < 1000) { // Sensor value is three digits
    lcd.print(" ");
  }else {
    // No spacing needed
  }
  lcd.print(avgSample);         // Print value to LCD
  
  delay(500); //Add delay to main loop
}


