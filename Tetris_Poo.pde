Tetromino P;
Tetromino P1;
final int ROWS = 20;
final int COLS = 10;
final int LENGTH = 20;
int mov = 0;
int exc = 0;
int bajar = 0;
int t = 0; //tiempo
int vel = 1500;
int[][] tableu = new int[ROWS][COLS];
byte[][] T = {{0, 0, 0}, {1, 1, 1}, {0, 1, 0}};
byte[][] O = {{1, 1}, {1, 1}};
byte[][] I = {{0, 1, 0, 0}, {0, 1, 0, 0}, {0, 1, 0, 0}, {0, 1, 0, 0}};
byte[][] L = {{0, 1, 0}, {0, 1, 0}, {0, 1, 1}};
byte[][] J = {{0, 1, 0}, {0, 1, 0}, {1, 1, 0}};
byte[][] S = {{1, 1, 0}, {0, 1, 1}, {0, 0, 0}};
byte[][] Z = {{0, 1, 1}, {1, 1, 0}, {0, 0, 0}};
byte[][][] tetrominos = {T, O, I, L, J, S, Z};
//boolean vr;

void setup() {
  size(600, 600);
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
  println(bajar);
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
   * Horizontal reflection
   */
  /*public void reflect() {
   int l = shape.length / 2;
   int[] temp;
   for (int i = 0; i < l; i++) {
   temp = shape[shape.length - 1 - i];
   shape[shape.length - i - 1] = shape[i];
   shape[i] = temp;
   }
   }*/

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
    int[][] posiciones = {x, y};
    int c=0;
    for (int i = 0; i < shape.length; i++) {
      for (int j = 0; j < shape[i].length; j++) {
        if (shape[i][j] != 0) {
          x[c] = i;
          y[c] = j+4;
          c++;
        }
      }
    }
    return posiciones;
  }
}

Boolean siguiente() {
  if (bajar > 16) {
    return true;
  }
  return false;
}

/**
 * Display board
 */
void drawTablero() {
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
        fill(0,100,255);
        stroke(255);
        translate(j * LENGTH, i * LENGTH);
        rect(180, 79, LENGTH, LENGTH);
        pop();
      }
    }
  }
}

void glue(int[][] p) {
  try {
    tableu[p[0][0]+bajar][p[1][0]+mov] = 0;
    tableu[p[0][1]+bajar][p[1][1]+mov] = 0;
    tableu[p[0][2]+bajar][p[1][2]+mov] = 0;
    tableu[p[0][3]+bajar][p[1][3]+mov] = 0;
  }
  catch(ArrayIndexOutOfBoundsException e) {
    if (mov<=-4){
      mov++;
      exc--;
    } else if (mov >=4) {
      mov--;
      exc++;
    }
    if (siguiente() == true) {
      bajar--;
      tableu[p[0][0]+bajar][p[1][0]+mov+exc] = 1;
      tableu[p[0][1]+bajar][p[1][1]+mov+exc] = 1;
      tableu[p[0][2]+bajar][p[1][2]+mov+exc] = 1;
      tableu[p[0][3]+bajar][p[1][3]+mov+exc] = 1;
      bajar = 0;
      P.shape = P1.shape;
      P1.shape = tetrominos[int(random(7))];
    }
    exc = 0;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      P.rotate();
    }
    if (keyCode == DOWN) {
      //  P.reflect();
      bajar++;
    }
    if (keyCode == RIGHT) {
      mov++;
    } else if (keyCode == LEFT) {
      mov--;
    }
  }
}
