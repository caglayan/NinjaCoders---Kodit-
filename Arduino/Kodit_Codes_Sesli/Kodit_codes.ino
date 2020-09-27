/*
  Code 3
  Board:        L293D Motor Drive DIP 16 Pin IC & 28BYJ-48 Stepper Motor & Arduino Uno IDE 1.8.5
  Connections:  See Fritzing in https://medium.com/jungletronics/28byj-48-stepper-motor-peak-rpm-658eae6afe2f
  Power Supply: 12v .5A Power Cable right into 5.5mm Jack of Arduino UNO
  Max RPM:      24 RPM  
*/

#include "DFRobotDFPlayerMini.h"
DFRobotDFPlayerMini myDFPlayer;

int Blue = 7; // 2YSag              // Firing order for 28BYJ-48 Stepper Motor
int Pink = 6;  // 1YSag            // First Blue coil
int Yellow = 8; //            // Then yellow coil and so on...
int Orange = 9;
long del = 2800;  //          // Below this figure the motor will stall:/


int A = 4;
int B = 5;
int C = 3;
int D = 2;


void setup() {
  pinMode(Blue, OUTPUT);
  pinMode(Pink, OUTPUT);
  pinMode(Yellow, OUTPUT);
  pinMode(Orange, OUTPUT);
  pinMode(A, OUTPUT);
  pinMode(B, OUTPUT);
  pinMode(C, OUTPUT);
  pinMode(D, OUTPUT);

  pinMode(A0,OUTPUT); // RED
  pinMode(A1,OUTPUT); // Green
  pinMode(A2,OUTPUT); // Blue
  pinMode(10,INPUT); // ileri
  pinMode(11,INPUT); // sag
  pinMode(12,INPUT); // basla
  pinMode(13,INPUT); // sol
 
  
  Serial.begin(9600);
  myDFPlayer.begin(Serial); 
  myDFPlayer.volume(30);  //Set volume value. From 0 to 30
  myDFPlayer.play(0006);
// 6:Merhaba ben Kodit
// 7:Beni yere koy
// 8:İleri gittim
// 9:Saga dondum
// 5:Sola dondum
// 6:Bitti
// 7:Şaka yaptım
// 8:RobotSesi1
// 9:RobotSesi2

  //delay(4000);
  //myDFPlayer.pause();
  //myDFPlayer.sleep();
  //ileri();
  //delay(500);
  //sag();
  //delay(500);
  //sol();
  digitalWrite(A0,HIGH);
  digitalWrite(A1,HIGH);
  digitalWrite(A2,HIGH);
  rengarenk();
}

void rengarenk(){
  int ara = 250;
  digitalWrite(A0,LOW);
  digitalWrite(A1,HIGH);
  digitalWrite(A2,HIGH);
  delay(ara);
  digitalWrite(A0,LOW);
  digitalWrite(A1,LOW);
  digitalWrite(A2,HIGH);
  delay(ara);
  digitalWrite(A0,HIGH);
  digitalWrite(A1,LOW);
  digitalWrite(A2,HIGH);
  delay(ara);
  digitalWrite(A0,HIGH);
  digitalWrite(A1,LOW);
  digitalWrite(A2,LOW);
  delay(ara);
  digitalWrite(A0,HIGH);
  digitalWrite(A1,HIGH);
  digitalWrite(A2,LOW);
  delay(ara);
  digitalWrite(A0,LOW);
  digitalWrite(A1,HIGH);
  digitalWrite(A2,LOW);
  delay(ara);
  
  }

void phaseOne() {
  digitalWrite(Blue, LOW);
  digitalWrite(Pink, HIGH);
  digitalWrite(Yellow, HIGH);
  digitalWrite(Orange, LOW);
  //delayMicroseconds(del);
}
void phaseOneSol() {
  digitalWrite(A, LOW);
  digitalWrite(B, HIGH);
  digitalWrite(C, HIGH);
  digitalWrite(D, LOW);
  //delayMicroseconds(del);
}
void phaseTwo() {
  digitalWrite(Blue, LOW);
  digitalWrite(Pink, HIGH);
  digitalWrite(Yellow, LOW);
  digitalWrite(Orange, HIGH);
  //delayMicroseconds(del);
}
void phaseTwoSol() {
  digitalWrite(A, LOW);
  digitalWrite(B, HIGH);
  digitalWrite(C, LOW);
  digitalWrite(D, HIGH);
  //delayMicroseconds(del);
}
void phaseThree() {
  digitalWrite(Blue, HIGH);
  digitalWrite(Pink, LOW);
  digitalWrite(Yellow, LOW);
  digitalWrite(Orange, HIGH);
  //delayMicroseconds(del);
}
void phaseThreeSol() {
  digitalWrite(A, HIGH);
  digitalWrite(B, LOW);
  digitalWrite(C, LOW);
  digitalWrite(D, HIGH);
  //delayMicroseconds(del);
}
void phaseFour() {
  digitalWrite(Blue, HIGH);
  digitalWrite(Pink, LOW);
  digitalWrite(Yellow, HIGH);
  digitalWrite(Orange, LOW);
  //delayMicroseconds(del);
}
void phaseFourSol() {
  digitalWrite(A, HIGH);
  digitalWrite(B, LOW);
  digitalWrite(C, HIGH);
  digitalWrite(D, LOW);
  //delayMicroseconds(del);
}
void motorOff() {
  digitalWrite(A, LOW);
  digitalWrite(B, LOW);
  digitalWrite(C, LOW);
  digitalWrite(D, LOW);
  digitalWrite(Blue, LOW);
  digitalWrite(Pink, LOW);
  digitalWrite(Yellow, LOW);
  digitalWrite(Orange, LOW);
}

// the loop routine runs over and over again forever:
int k = 0;
int moveState = 0;
int pushedButton = 0;
int commandIndex = 0;
int counter = 39;
int commandPosition = 0;
int commandArray[100]; //this array will hold integers

int bekleme = 0;

void loop() {
  if(moveState == 0){
    if(pushedButton == 0){
      if(digitalRead(10)==1){ // ileri
          digitalWrite(A0,HIGH);
          digitalWrite(A1,LOW);
          digitalWrite(A2,HIGH);
          pushedButton = 1;
          commandArray[commandIndex] = 1;
          commandIndex = commandIndex + 1;
          //Serial.println(commandIndex);
        }else if(digitalRead(11)==1){ // sag
          digitalWrite(A0,LOW);
          digitalWrite(A1,HIGH);
          digitalWrite(A2,LOW);
          pushedButton = 2;
          commandArray[commandIndex] = 2;
          commandIndex = commandIndex + 1;
          //Serial.println(commandIndex);
        }else if(digitalRead(12)==1){ // basla
          pushedButton = 4;
          digitalWrite(A0,LOW);
          digitalWrite(A1,LOW);
          digitalWrite(A2,HIGH);
          //Serial.println(commandIndex);
        }else if(digitalRead(13)==1){ //sol
          digitalWrite(A0,HIGH);
          digitalWrite(A1,HIGH);
          digitalWrite(A2,LOW);
          pushedButton = 3;
          commandArray[commandIndex] = 3;
          commandIndex = commandIndex + 1;
          //Serial.println(commandIndex);
        }else{
          digitalWrite(A0,HIGH);
          digitalWrite(A1,HIGH);
          digitalWrite(A2,HIGH);  
        }
     }else{
      if(digitalRead(10)==0 && digitalRead(11)==0 && digitalRead(12)==0 && digitalRead(13)==0){
        delay(500);
        digitalWrite(A0,HIGH);
        digitalWrite(A1,HIGH);
        digitalWrite(A2,HIGH);
        if(pushedButton == 4){
          if(commandIndex != 0){
            moveState = 1;
            //Serial.println(commandIndex);
            perform();
            moveState = 0;
            delay(1500);
            myDFPlayer.play(0002);
           }
        }
        pushedButton = 0; 
      }
     }
   }
}
int checkbaslaSound = 0;
void perform(){
  if(checkbaslaSound==0){
    myDFPlayer.play(0007);
    delay(4000);
  }else{
    delay(2000);  
  }
  checkbaslaSound=1;
  for(int m = 0;m<commandIndex;m++){
    delay(300);
    switch( commandArray[m] )
        {
          case 1: // 1) Fast forward
            ileri();
            myDFPlayer.play(8);
            break; 
          case 2: // 1) right
            sag();          
            myDFPlayer.play(9);
            break; 
          case 3: // 1) left
            sol();
            myDFPlayer.play(0001);
            break;
       } 
  }  
  commandIndex = 0;
}

void ileri(){
  int del = 4000;
  for (int i = 0; i <= 320; i++) {
    phaseOneSol();
    phaseOne();
    delayMicroseconds(del);
    phaseTwoSol();
    phaseTwo();
    delayMicroseconds(del);
    phaseThreeSol();
    phaseThree();
    delayMicroseconds(del);
    phaseFourSol();
    phaseFour();
    delayMicroseconds(del);    
  }
  motorOff(); 
}

void sol(){
  A = 5;
  B = 2;
  C = 3;
  D = 4;
  del=4000;
  for (int i = 0; i <= 142; i++) {
    phaseOneSol();
    phaseOne();
    delayMicroseconds(del);
    phaseTwoSol();
    phaseTwo();
    delayMicroseconds(del);
    phaseThreeSol();
    phaseThree();
    delayMicroseconds(del);
    phaseFourSol();
    phaseFour();
    delayMicroseconds(del);
  } 
  A = 3;
  B = 4;
  C = 5;
  D = 2;
  motorOff();
}

void sag(){
  Blue = 9; // 2YSag              // Firing order for 28BYJ-48 Stepper Motor
  Pink = 6;  // 1YSag            // First Blue coil
  Yellow = 8; //            // Then yellow coil and so on...
  Orange = 7;
  for (int i = 0; i <= 142; i++) {
    phaseOneSol();
    phaseOne();
    delayMicroseconds(del);
    phaseTwoSol();
    phaseTwo();
    delayMicroseconds(del);
    phaseThreeSol();
    phaseThree();
    delayMicroseconds(del);
    phaseFourSol();
    phaseFour();
    delayMicroseconds(del);
  } 
  Blue = 8; // 2YSag              // Firing order for 28BYJ-48 Stepper Motor
  Pink = 7;  // 1YSag            // First Blue coil
  Yellow = 9; //            // Then yellow coil and so on...
  Orange = 6;
  motorOff();
}
