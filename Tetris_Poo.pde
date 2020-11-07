Tetromino P;
Tetromino P1;
Tetromino temp;
final int ROWS = 20;
final int COLS = 10;
final int LENGTH = 20;
int mov = 0;
int bajar = 0;
int t = 0; //tiempo
int vel;
int Rc = 0;
int score = 0, nivel = 1, nl = 0;
int[][] tableu = new int[ROWS][COLS];
byte[][] T = {{0, 0, 0}, {1, 1, 1}, {0, 1, 0}};
byte[][] O = {{1, 1}, {1, 1}};
byte[][] I = {{0, 0, 0, 0}, {1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}};
byte[][] L = {{0, 1, 0}, {0, 1, 0}, {0, 1, 1}};
byte[][] J = {{0, 1, 0}, {0, 1, 0}, {1, 1, 0}};
byte[][] Z = {{0, 0, 0}, {1, 1, 0}, {0, 1, 1}};
byte[][] S = {{0, 0, 0}, {0, 1, 1}, {1, 1, 0}};
byte[][][] tetrominos = {T, O, I, L, J, S, Z};
boolean IRot = true;
boolean bv = true, movdv = true, moviv = true, rv = true;

void setup() {
  size(600, 600);
  textSize(20);
  for (int i = 0; i < ROWS; i++) {
    for (int j = 0; j < COLS; j++) {
      tableu[i][j] = 0;
    }
  }
  P = new Tetromino();
  P1 = new Tetromino();
  P.shape = tetrominos[int(random(7))];
  P1.shape = tetrominos[int(random(7))];
}

void draw() {
  vel = 1500-50*(nivel-1);
  background(20);
  if (millis() >= t+1500) {
    bajar++;
    t = millis();
  }
  for (int i = 0; i < 12; i++) {
    push();
    translate(i * LENGTH, 0);
    fill(0);
    stroke(50);
    rect(160, 59, LENGTH, LENGTH);
    rect(160, 480, LENGTH, LENGTH);
    pop();
  }
  for (int i = 0; i < 20; i++) {
    push();
    translate(0, i * LENGTH);
    fill(0);
    stroke(50);
    rect(160, 79, LENGTH, LENGTH);
    rect(380, 79, LENGTH, LENGTH);
    pop();
  }
  drawTablero();
  P.displaytoP();
  P1.displayP();
  Extras();
  println(Rc);
}

class Tetromino {
  private byte[][] shape;
  int c1 = int(random(255));
  int c2 = int(random(255));
  int c3 = int(random(255));

  public byte[][] getShape() {
    return shape;
  }

  /**
   * @param {Array} shape [rowIndex][columnIndex]
   */
  public void setShape(byte[][] newShape) {
    this.shape = newShape;
  }

  /**
   * Clockwise rotation
   */
  private void rotate() {
    for (int i = 0; i < shape.length / 2; ++i) {
      for (int j = i; j < shape.length - 1 - i; ++j) {
        byte temp = shape[j][i];
        shape[j][i] = shape[i][shape.length - j - 1];
        shape[i][shape.length - j - 1] = shape[shape.length - j - 1][shape.length - i - 1];
        shape[shape.length - j - 1][shape.length - i - 1] = shape[shape.length - i - 1][j];
        shape[shape.length - i - 1][j] = temp;
      }
    }
  }

  /**
   * Display tetromino in game
   */
  private void displaytoP() {
    push();
    translate(20*mov, bajar*20);
    for (int i = 0; i < shape.length; i++) {
      for (int j = 0; j < shape[i].length; j++) {
        if (shape[i][j] != 0) {
          fill(c1, c2, c3);
          rect(260+20*j, 79+20*i, LENGTH, LENGTH);
        }
      }
    }
    pop();
  }

  /**
   * Display next tetromino
   */
  private void displayP() {
    push();
    fill(237, 233, 173);
    strokeWeight(1.5);
    rect(450, 80, 105, 105);
    pop();
    for (int i = 0; i < shape.length; i++) {
      for (int j = 0; j < shape[i].length; j++) {
        if (shape[i][j] != 0) {
          fill(c1, c2, c3);
          rect(470+20*j, 100+20*i, LENGTH, LENGTH);
        }
      }
    }
  }

  private int[][] update() {
    int[] x = new int[4], y = new int[4];
    int[][] posiciones = {y, x};
    int c=0;
    for (int i = 0; i < shape.length; i++) {
      for (int j = 0; j < shape[i].length; j++) {
        if (shape[i][j] != 0) {
          y[c] = i;
          x[c] = j+4;
          c++;
        }
      }
    }
    return posiciones;
  }
}

/**
 * Display board
 */
void drawTablero() {
  int borrar = 0, tempi = 0;
  glue(P.update());
  for (int i = 0; i < ROWS; i++) {
    for (int j = 0; j < COLS; j++) {
      if (tableu[i][j] == 0) {
        push();
        fill(110);
        stroke(255);
        translate(j * LENGTH, i * LENGTH);
        rect(180, 79, LENGTH, LENGTH);
        pop();
      } else if (tableu[i][j] == 1) {
        push();
        fill(128, 15, 17);
        stroke(255);
        translate(j * LENGTH, i * LENGTH);
        rect(180, 79, LENGTH, LENGTH);
        pop();
        borrar++;
      }
      if (borrar == COLS) {
        borrar = 0;
        tempi = i;
        nl++;
        score += 100;
        if (nl%5 == 0 && nl > 0 && nivel < 32)
          nivel++;
        for (int i1 = tempi; i1 >= 1; i1--) {
          for (int j1 = 0; j1 < COLS; j1++) {
            tableu[i1][j1] = tableu[i1-1][j1];
          }
        }
      }
    }
    borrar = 0;
  }
}

void siguiente() {
  if (P.shape != I && IRot == true)
    bajar = -1;
  else
    bajar = -2;
  mov = 0;
  Rc = 0;
  IRot = true;
  P.shape = P1.shape;
  P1.shape = tetrominos[int(random(7))];
}

void glue(int[][] p) {
  boolean vmd = false;
  boolean vmi = false;
  bv = true;
  movdv = true;
  moviv = true;
  rv = true;
  try {
    tableu[p[0][0]+bajar][p[1][0]+mov] = 0;
    tableu[p[0][1]+bajar][p[1][1]+mov] = 0;
    tableu[p[0][2]+bajar][p[1][2]+mov] = 0;
    tableu[p[0][3]+bajar][p[1][3]+mov] = 0;
  }
  catch(ArrayIndexOutOfBoundsException e) {
    if (mov<=-4) {
      mov++;
      vmi = true;
    } else if ((mov >=4 && P.shape != I) || (mov > 3 && P.shape == I && IRot == false) || (mov > 2 && P.shape == I && IRot == true)) {
      mov--;
      vmd = true;
    }
  }
  for (int i = 0; i < 4; i++) {
    try {
      if (p[1][i]+mov+1 < 10 && tableu[p[0][i]+bajar][p[1][i]+mov+1] != 0) {
        movdv = false;
      }
      if (tableu[p[0][i]+bajar][p[1][i]+mov-1] != 0) {
        moviv = false;
      }
    }
    catch(ArrayIndexOutOfBoundsException e) {
      /**
       *Este espacio se deja vacio porque no se espera que ocurra nada especial.
       */
    }
    if (p[0][i]+bajar > 19) {
      if (vmd)
        mov++;
      else if (vmi)
        mov--;
      tableu[p[0][0]+bajar-1][p[1][0]+mov] = 1;
      tableu[p[0][1]+bajar-1][p[1][1]+mov] = 1;
      tableu[p[0][2]+bajar-1][p[1][2]+mov] = 1;
      tableu[p[0][3]+bajar-1][p[1][3]+mov] = 1; //Casilla del tablero
      siguiente();
      break;
    }
    try {
      if (p[0][i]+bajar < 19 && p[0][i]+bajar >= 0 && tableu[p[0][i]+bajar+1][p[1][i]+mov] != 0) {
        bv = false;
        try {
          if (millis() >= t+1400) {
            tableu[p[0][0]+bajar][p[1][0]+mov] = 1;
            tableu[p[0][1]+bajar][p[1][1]+mov] = 1;
            tableu[p[0][2]+bajar][p[1][2]+mov] = 1;
            tableu[p[0][3]+bajar][p[1][3]+mov] = 1; //Casilla del tablero
            siguiente();
            break;
          }
        }
        catch(ArrayIndexOutOfBoundsException e) {
          println("Game over");
          noLoop();
        }
      }
     if((P.shape == T && Rc == 3 && tableu[p[0][2]+bajar][p[1][2]+mov+1] == 1) || (P.shape == T && Rc == 1 && tableu[p[0][2]+bajar][p[1][2]+mov-1] == 1) || (P.shape == I && IRot == true && (tableu[p[0][2]+bajar][p[1][2]+mov+1] == 1 || tableu[p[0][1]+bajar][p[1][1]+mov+1] == 1)) || (P.shape == L && Rc == 0 && (tableu[p[0][0]+bajar][p[1][0]+mov+1] == 1 || tableu[p[0][1]+bajar][p[1][1]+mov+1] == 1)) || (P.shape == L && Rc == 2 && (tableu[p[0][2]+bajar][p[1][2]+mov-1] == 1 || tableu[p[0][3]+bajar][p[1][3]+mov-1] == 1)) || (P.shape == J && Rc == 0 && (tableu[p[0][1]+bajar][p[1][1]+mov+1] == 1 || tableu[p[0][2]+bajar][p[1][2]+mov+1] == 1)) || (P.shape == J && Rc == 2 && (tableu[p[0][2]+bajar][p[1][2]+mov-1] == 1 || tableu[p[0][1]+bajar][p[1][1]+mov-1] == 1)) || (P.shape == S && (Rc == 0 || Rc == 2) && (tableu[p[0][1]+bajar][p[1][1]+mov+1] == 1 || tableu[p[0][2]+bajar+1][p[1][2]+mov] == 1)) || (P.shape == S && (Rc == 1 || Rc == 3) && (tableu[p[0][1]+bajar][p[1][1]+mov-1] == 1 || tableu[p[0][0]+bajar][p[1][0]+mov+1] == 1 || tableu[p[0][2]+bajar][p[1][2]+mov+1] == 1)) || (P.shape == Z && (Rc == 0 || Rc == 2) && (tableu[p[0][1]+bajar][p[1][1]+mov-1] == 1 || tableu[p[0][2]+bajar+1][p[1][2]+mov] == 1)) || (P.shape == Z && (Rc == 1 || Rc == 3) && (tableu[p[0][1]+bajar][p[1][1]+mov+1] == 1 || tableu[p[0][3]+bajar][p[1][3]+mov+1] == 1 || tableu[p[0][2]+bajar][p[1][2]+mov-1] == 1)))
       rv = false;
    }
    catch(ArrayIndexOutOfBoundsException e) {
      /**
       *Este espacio se deja vacio porque no se espera que ocurra nada especial.
       */
    }
  }
}

void Extras() { //Texto y decoracion
  push();
  textSize(40);
  fill(255, 0, 0);
  text("TETRIS", 435, 415);
  pop();
  fill(255, 0, 0);
  text("Lineas:", 30, 230);
  text("Puntaje:", 30, 360);
  text("Nivel:", 480, 300);
  fill(255);
  text(nivel, 500, 330);
  text(nl, 50, 260);
  text(score, 50, 390);
}

void keyPressed() {
  if (key == 'q') {
    temp = P1;
    P1 = P;
    P = temp;
  }
  if (key == CODED) {
    if (keyCode == UP && rv) {
      P.rotate();
      Rc++;
      if (Rc == 4)
        Rc = 0;
      if (P.shape == I) {
        IRot = !IRot;
      }
    }
    if (keyCode == DOWN && bv) {
      bajar++;
      score++;
    }
    if (keyCode == RIGHT && movdv) {
      mov++;
    } else if (keyCode == LEFT && moviv) {
      mov--;
    }
  }
}
