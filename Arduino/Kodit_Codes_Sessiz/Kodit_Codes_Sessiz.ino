int sol1 = 7; 
int sol2 = 6;  
int sol3 = 8; 
int sol4 = 9;

int sag1 = 5;
int sag2 = 4;
int sag3 = 3;
int sag4 = 2;

int red = A0;
int green = A1;
int blue = A2;

int baslaB = 13;
int sagB = 11;
int solB = 12;
int ileriB = 10;

int del = 4000;

void setup() {
  pinMode(sol1, OUTPUT);
  pinMode(sol2, OUTPUT);
  pinMode(sol3, OUTPUT);
  pinMode(sol4, OUTPUT);
  pinMode(sag1, OUTPUT);
  pinMode(sag2, OUTPUT);
  pinMode(sag3, OUTPUT);
  pinMode(sag4, OUTPUT);

  pinMode(red,OUTPUT); // Red
  pinMode(green,OUTPUT); // Green
  pinMode(blue,OUTPUT); // Blue
  
  pinMode(baslaB,INPUT); 
  pinMode(sagB,INPUT); 
  pinMode(solB,INPUT); 
  pinMode(ileriB,INPUT); 
 
  digitalWrite(red,HIGH);
  digitalWrite(green,HIGH);
  digitalWrite(blue,HIGH);
  motorOff(); 
  rengarenk();  
}

void rengarenk(){
  int ara = 400;
  digitalWrite(red,LOW);
  digitalWrite(green,HIGH);
  digitalWrite(blue,HIGH);
  delay(ara);
  digitalWrite(red,LOW);
  digitalWrite(green,LOW);
  digitalWrite(blue,HIGH);
  delay(ara);
  digitalWrite(red,HIGH);
  digitalWrite(green,LOW);
  digitalWrite(blue,HIGH);
  delay(ara);
  digitalWrite(red,HIGH);
  digitalWrite(green,LOW);
  digitalWrite(blue,LOW);
  delay(ara);
  digitalWrite(red,HIGH);
  digitalWrite(green,HIGH);
  digitalWrite(blue,LOW);
  delay(ara);
  digitalWrite(red,LOW);
  digitalWrite(green,HIGH);
  digitalWrite(blue,LOW);
  delay(ara);
  }

void phaseOne() {
  digitalWrite(sol1,LOW);
  digitalWrite(sag1,LOW);
  digitalWrite(sol2,HIGH);
  digitalWrite(sag2,HIGH);
  digitalWrite(sol3,HIGH);
  digitalWrite(sag3,HIGH);
  digitalWrite(sol4,LOW);
  digitalWrite(sag4,LOW);
}

void phaseTwo() {
  digitalWrite(sol1,LOW);
  digitalWrite(sag1,LOW);
  digitalWrite(sol2,HIGH);
  digitalWrite(sag2,HIGH);
  digitalWrite(sol3,LOW);
  digitalWrite(sag3,LOW);
  digitalWrite(sol4,HIGH);
  digitalWrite(sag4,HIGH);
}

void phaseThree() {
  digitalWrite(sol1,HIGH);
  digitalWrite(sag1,HIGH);
  digitalWrite(sol2,LOW);
  digitalWrite(sag2,LOW);
  digitalWrite(sol3,LOW);
  digitalWrite(sag3,LOW);
  digitalWrite(sol4,HIGH);
  digitalWrite(sag4,HIGH);
}

void phaseFour() {
  digitalWrite(sol1,HIGH);
  digitalWrite(sag1,HIGH);
  digitalWrite(sol2,LOW);
  digitalWrite(sag2,LOW);
  digitalWrite(sol3,HIGH);
  digitalWrite(sag3,HIGH);
  digitalWrite(sol4,LOW);
  digitalWrite(sag4,LOW);
}

void motorOff() {
  digitalWrite(sol1,LOW);
  digitalWrite(sag1,LOW);
  digitalWrite(sol2,LOW);
  digitalWrite(sag2,LOW);
  digitalWrite(sol3,LOW);
  digitalWrite(sag3,LOW);
  digitalWrite(sol4,LOW);
  digitalWrite(sag4,LOW);
}

// the loop routine runs over and over again forever:
int k = 0;
int moveState = 0;
int pushedButton = 0;
int commandIndex = 0;
int counterLed = 0;
int commandPosition = 0;
int commandArray[100]; //this array will hold integers
int bekleme = 0;

void loop() {
  if(moveState == 0){
    if(pushedButton == 0){
      if(digitalRead(ileriB)==1){
          digitalWrite(red,HIGH);
          digitalWrite(green,LOW);
          digitalWrite(blue,HIGH);
          pushedButton = 1;
          commandArray[commandIndex] = 1;
          commandIndex = commandIndex + 1;
          //Serial.println(commandIndex);
        }else if(digitalRead(sagB)==1){
          digitalWrite(red,LOW);
          digitalWrite(green,HIGH);
          digitalWrite(blue,HIGH);
          pushedButton = 2;
          commandArray[commandIndex] = 2;
          commandIndex = commandIndex + 1;
          //Serial.println(commandIndex);
        }else if(digitalRead(solB)==1){
          digitalWrite(red,HIGH);
          digitalWrite(green,HIGH);
          digitalWrite(blue,LOW);
          pushedButton = 3;
          commandArray[commandIndex] = 3;
          commandIndex = commandIndex + 1;                 
        }else if(digitalRead(baslaB)==1){                   
          pushedButton = 4;
          digitalWrite(red,LOW);
          digitalWrite(green,LOW);
          digitalWrite(blue,HIGH);    
        }else{
          
          delay(100);
          counterLed = counterLed + 1;
          if(counterLed < 55 && counterLed > 53){
            sari();                        
          }else if(counterLed < 60 && counterLed > 55){
            son();                          
          }else if(counterLed < 65 && counterLed > 63){
            sari();                        
          }else{
            son();  
          } 
          if(counterLed == 65){
              counterLed = 0; 
           } 
        }
     }else{
      if(digitalRead(baslaB)==0 && digitalRead(solB)==0 && digitalRead(sagB)==0 && digitalRead(ileriB)==0){
        delay(500);
        digitalWrite(red,HIGH);
        digitalWrite(green,HIGH);
        digitalWrite(blue,HIGH);
        if(pushedButton == 4){
          if(commandIndex != 0){
            moveState = 1;           
            perform();
            moveState = 0;
            delay(1500);         
           }
        }
        pushedButton = 0; 
      }
     }
   }
}
int checkbaslaBSound = 0;
void perform(){
  delay(1000);
  checkbaslaBSound=1;
  for(int m = 0;m<commandIndex;m++){
    sari();
    delay(300);
    son();
    switch( commandArray[m] )
        {
          case 1: // 1) Fast forward
            ileri();            
            break; 
          case 2: // 1) right
            sag();                      
            break; 
          case 3: // 1) left
            sol();            
            break;
       } 
  }
  rengarenk();  
  commandIndex = 0;
}

void ileri(){
  del=4000;
  for (int i = 0; i <= 260; i++) {    
    phaseOne();
    delayMicroseconds(del);    
    phaseTwo();
    delayMicroseconds(del);    
    phaseThree();
    delayMicroseconds(del);    
    phaseFour();
    delayMicroseconds(del); 
    if(i>180){
      del = del + i/10;
    }   
  }
  motorOff(); 
}

void sol(){
  del=4000;
  sol1 = 6; 
  sol2 = 7;  
  sol3 = 8; 
  sol4 = 9;  
  for (int i = 0; i <= 140; i++) {
    phaseOne();
    delayMicroseconds(del);    
    phaseTwo();
    delayMicroseconds(del);    
    phaseThree();
    delayMicroseconds(del);    
    phaseFour();
    delayMicroseconds(del); 
  } 
  sol1 = 7; 
  sol2 = 6;  
  sol3 = 8; 
  sol4 = 9;
  motorOff();
}

void sag(){
  del=4000;
  sag1 = 4;
  sag2 = 5;
  sag3 = 3;
  sag4 = 2;
  for (int i = 0; i <= 140; i++) {
    phaseOne();
    delayMicroseconds(del);    
    phaseTwo();
    delayMicroseconds(del);    
    phaseThree();
    delayMicroseconds(del);    
    phaseFour();
    delayMicroseconds(del); 
  } 
  sag1 = 5;
  sag2 = 4;
  sag3 = 3;
  sag4 = 2;
  motorOff();
}

void sari(){
  digitalWrite(red,LOW);
  digitalWrite(green,LOW);
  digitalWrite(blue,HIGH); 
}

void son(){
  digitalWrite(red,HIGH);
  digitalWrite(green,HIGH);
  digitalWrite(blue,HIGH); 
}
