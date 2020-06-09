import processing.net.*;

Server myServer;

color lightbrown = #FFFFC3;
color darkbrown  = #D8864E;
PImage wrook, wbishop, wknight, wqueen, wking, wpawn;
PImage brook, bbishop, bknight, bqueen, bking, bpawn;
boolean firstClick;
int row1, col1, row2, col2;
boolean myTurn=true;

char grid[][] = {
  {'R', 'B', 'N', 'Q', 'K', 'N', 'B', 'R'}, 
  {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'}, 
  {'r', 'b', 'n', 'q', 'k', 'n', 'b', 'r'}
};

void setup() {
  size(800, 800);

  myServer=new Server(this,1234);
  
  firstClick = true;

  brook = loadImage("blackRook.png");
  bbishop = loadImage("blackBishop.png");
  bknight = loadImage("blackKnight.png");
  bqueen = loadImage("blackQueen.png");
  bking = loadImage("blackKing.png");
  bpawn = loadImage("blackPawn.png");

  wrook = loadImage("whiteRook.png");
  wbishop = loadImage("whiteBishop.png");
  wknight = loadImage("whiteKnight.png");
  wqueen = loadImage("whiteQueen.png");
  wking = loadImage("whiteKing.png");
  wpawn = loadImage("whitePawn.png");
}

void draw() {
  drawBoard();
  drawPieces();
  receiveMove();
  pawnPromotion();
}

void pawnPromotion(){
  if(myTurn==false){
  for(int c=0;c<8;c++){
  if(grid[0][c]=='p'){
    textSize(30);
    fill(0);
    textAlign(CENTER);
   text("press q for queen, n for knight, b for bishop, r for rook",width/2,height/2);
   if(keyPressed){
  if(key=='Q'||key=='q'){
   grid[0][c]='q';
   myServer.write(0+","+c+","+"q");
 }else if(key=='N'||key=='n'){
   grid[0][c]='n';
   myServer.write(0+","+c+","+"n");
 }else if(key=='B'||key=='b'){
   grid[0][c]='b';
   myServer.write(0+","+c+","+"b");
 }else if(key=='R'||key=='r'){
   grid[0][c]='r';
   myServer.write(0+","+c+","+"r");
 }
   }
  }
  if(grid[7][c]=='P'){
    fill(0);
    textSize(30);
    textAlign(CENTER);
   text("press q for queen, n for knight, b for bishop, r for rook",width/2,height/2);
   if(keyPressed){
  if(key=='Q'||key=='q'){
   grid[7][c]='Q';
   myServer.write(7+","+c+","+"Q");
 }else if(key=='N'||key=='n'){
   grid[7][c]='N';
   myServer.write(7+","+c+","+"N");
 }else if(key=='B'||key=='b'){
   grid[7][c]='B';
   myServer.write(7+","+c+","+"B");
 }else if(key=='R'||key=='r'){
   grid[7][c]='R';
   myServer.write(7+","+c+","+"R");
 }
  }
 }
  }
}
}

void receiveMove(){
  Client myclient=myServer.available();
  if(myclient!=null){
    myTurn=true;
   String incoming=myclient.readString();
   if(incoming.length()==7){
   int r1=int(incoming.substring(0,1));
   int c1=int(incoming.substring(2,3));
    int r2=int(incoming.substring(4,5));
   int c2=int(incoming.substring(6,7));
   grid[r2][c2]=grid[r1][c1];
   grid[r1][c1]=' ';
  }else if(incoming.length()==5){
   int r=int(incoming.substring(0,1));
   int c=int(incoming.substring(2,3));
  if(incoming.substring(4,5).equals("q")) grid[r][c]='q';
  if(incoming.substring(4,5).equals("r")) grid[r][c]='r';
  if(incoming.substring(4,5).equals("n"))grid[r][c]='n';
  if(incoming.substring(4,5).equals("b")) grid[r][c]='b';
  if(incoming.substring(4,5).equals("Q")) grid[r][c]='Q';
  if(incoming.substring(4,5).equals("R")) grid[r][c]='R';
  if(incoming.substring(4,5).equals("N"))grid[r][c]='N';
  if(incoming.substring(4,5).equals("B")) grid[r][c]='B';
  
  }
}
}
void drawBoard() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) { 
      if ( (r%2) == (c%2) ) { 
        fill(lightbrown);
      } else { 
        fill(darkbrown);
      }
      rect(c*100, r*100, 100, 100);
    }
  }
}

void drawPieces() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) {
      if (grid[r][c] == 'r') image (wrook, c*100, r*100, 100, 100);
      if (grid[r][c] == 'R') image (brook, c*100, r*100, 100, 100);
      if (grid[r][c] == 'b') image (wbishop, c*100, r*100, 100, 100);
      if (grid[r][c] == 'B') image (bbishop, c*100, r*100, 100, 100);
      if (grid[r][c] == 'n') image (wknight, c*100, r*100, 100, 100);
      if (grid[r][c] == 'N') image (bknight, c*100, r*100, 100, 100);
      if (grid[r][c] == 'q') image (wqueen, c*100, r*100, 100, 100);
      if (grid[r][c] == 'Q') image (bqueen, c*100, r*100, 100, 100);
      if (grid[r][c] == 'k') image (wking, c*100, r*100, 100, 100);
      if (grid[r][c] == 'K') image (bking, c*100, r*100, 100, 100);
      if (grid[r][c] == 'p') image (wpawn, c*100, r*100, 100, 100);
      if (grid[r][c] == 'P') image (bpawn, c*100, r*100, 100, 100);
    }
  }
}

void mouseReleased() {
  if(myTurn==true){
  if (firstClick) {
    row1 = mouseY/100;
    col1 = mouseX/100;
    firstClick = false;
  } else {
    row2 = mouseY/100;
    col2 = mouseX/100;
    if (!(row2 == row1 && col2 == col1)) {
      grid[row2][col2] = grid[row1][col1];
      grid[row1][col1] = ' ';
      myServer.write(row1+","+col1+","+row2+","+col2);
      firstClick = true;
      myTurn=false;
    }
  }
  }
}
