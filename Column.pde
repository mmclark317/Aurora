/*
COLUMN CLASS
Mary Clark ARTS104 Robinson
*/

class Column {
  color columnColor; //The column color
  boolean launched = false; //Whether or not the column has been activated and launched
  int columnHeight = 300; //Height of the column
  int columnWidth; //Widthpof the column
  int xCoor; //Current x-coordinate of the column
  int yCoor; //Current y-coordinate of the column
  int base; //The base y-coordinate
  int direction = -1;
 
  Column(color tempColor, int xCoorTemp, int tempWidth) {
    yCoor = height; //Make sure this is done AFTER THE SCREEN SIZE HAS BEEN SET
    base = yCoor;
    xCoor = xCoorTemp;
    columnWidth = tempWidth;
    columnColor = tempColor;
  }
  
  boolean moveColumn() {
    yCoor += (direction * ((yCoor+15)/15));
    if (yCoor <= 0 || yCoor >= base) {
      direction *= -1; 
    }
    if (yCoor >= base) {
      yCoor = base;
      return true;
    }
    else
      return false;
  }
  
  void setMove(boolean move) {
    launched = move;
  }
  
  boolean moving() {
    return launched;
  }
  
  void display() {
    noStroke();
    fill(columnColor);
    rect(xCoor, yCoor, columnWidth, columnHeight);
  }
  
  void printData() {
    println("xCoor: " + xCoor + "\tyCoor: " + yCoor);
  }
  
}