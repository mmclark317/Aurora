/*==============================================
AURORA: Reflection on Omnichords
Mary Clark ARTS104 Robinson

Creates a symmetrical, rippling effect with an omnichord's 
arpeggios. Works with the Column class and MidiBus
==============================================*/

import javax.sound.midi.MidiMessage;
import themidibus.*;

//Column testColumn;
int columnWidth;
Column[] columns1; 
Column[] columns2;
color backgroundColor = #6c0f6a;
color columnColor = #7fb4fb;
int currX = 0;
MidiBus omni;
int direction = 1;
int holdX;

void setup() {
  MidiBus.list();
  omni = new MidiBus(this, 0, 0);
  
  background(backgroundColor);
  fullScreen();
  //size(500,500);
  columnWidth = round(width/60); //Denominator = number of columns you want
  if (columnWidth % 2 > 0) //Make sure number of columns is even
    columnWidth++;
  columns1 = new Column[(width/columnWidth)];
  columns2 = new Column[(width/columnWidth)];

  for (int i = 0; i < width/columnWidth; i++) { //Add columns
    columns1[i] = new Column(columnColor, columnWidth*i, columnWidth);
    columns2[i] = new Column(columnColor, columnWidth*i, columnWidth);
  }
  
}

void draw() {
  
  //Create the fade effect
  fill(backgroundColor, 10);
  rect(0, 0, width, height);
  
  //Check all of the columns
  for (int i = (columns1.length/2)-1; i < columns1.length; i++) {
    int j = columns1.length - i - 1;
    
    if((currX > columns1[i].xCoor && currX < columns1[i].xCoor+columnWidth) ||
       (currX > columns1[j].xCoor && currX < columns1[j].xCoor+columnWidth)){
        if (direction > 0) {
          columns2[i].setMove(true);
          columns2[j].setMove(true);
        }
        else if (direction < 0) {
          columns1[i].setMove(true);
          columns1[j].setMove(true);
        }
    }
    
    //Move anything
    if (columns1[i].moving()) {
      boolean returnedRight = columns1[i].moveColumn();
      boolean returnedLeft = columns1[j].moveColumn();
      
      if (returnedRight || returnedLeft) {
        //println("i = " + i + "\tj = " + j);
        columns1[i].setMove(false);
        columns1[j].setMove(false);
      }
    }
    if (columns2[i].moving()) {
      boolean returnedRight = columns2[i].moveColumn();
      boolean returnedLeft = columns2[j].moveColumn();
      
      if (returnedRight || returnedLeft) {
        //println("i = " + i + "\tj = " + j);
        columns2[i].setMove(false);
        columns2[j].setMove(false);
      }
    }
  
    //Show em
    columns1[i].display();
    columns1[j].display();
    columns2[i].display();
    columns2[j].display();
  }
  currX = 0;
}

void midiMessage(MidiMessage message) {
  if (message.getStatus() == 144) {
    currX = holdX;
    //println(message.getStatus());
    currX += (direction * (columnWidth-1));
    holdX = currX;
    if (currX <= 0 || currX >= (columns1.length/2 * columnWidth)) {
      direction *= -1;
    }
  }
  else if (message.getStatus() == 176) {
    currX = 0;
    holdX = 0;
  }
}
