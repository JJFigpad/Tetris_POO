Tetromino P;
Tetromino P1;
final int ROWS = 20;
final int COLS = 10;
int LENGTH = 20;
int mov = 0;
int bajar = 0;
int t = 0;
int[][] tableu = new int[ROWS+2][COLS+2];
byte[][] T = {{0, 0, 0}, {1, 1, 1}, {0, 1, 0}};
byte[][] O = {{1, 1}, {1, 1}};
byte[][] I = {{0, 1, 0, 0}, {0, 1, 0, 0}, {0, 1, 0, 0}, {0, 1, 0, 0}};
byte[][] L = {{0, 1, 0}, {0, 1, 0}, {0, 1, 1}};
byte[][] J = {{0, 1, 0}, {0, 1, 0}, {1, 1, 0}};
byte[][] S = {{1, 1, 0}, {0, 1, 1}, {0, 0, 0}};
byte[][] Z = {{0, 1, 1}, {1, 1, 0}, {0, 0, 0}};
byte[][][] tetrominos = {T, O, I, L, J, S, Z};

void setup() {
  size(600, 600);
  for (int i = 0; i <= ROWS+1; i++) {
    for (int j = 0; j <= COLS+1; j++) {
      if (i == 0 || i == ROWS+1 || j == 0 || j == COLS+1)
        tableu[i][j] = -1;
      else
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
          rect(280+20*j, 79+20*i, LENGTH, LENGTH);
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
    fill(237,233,173);
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
}

/**
 * Display board
 */
void drawTablero() {
  for (int i = 0; i <= ROWS+1; i++) {
    for (int j = 0; j <= COLS+1; j++) {
      if (tableu[i][j] == 0) {
        push();
        fill(110);
        stroke(255);
        translate(j * LENGTH, i * LENGTH);
        rect(180, 79, LENGTH, LENGTH);
        pop();
      } else if (tableu[i][j] == -1) {
        push();
        fill(0);
        stroke(50);
        translate(j * LENGTH, i * LENGTH);
        rect(180, 79, LENGTH, LENGTH);
        pop();
      }
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      P.rotate();
      mov++;
    }
    if (keyCode == DOWN) {
      //  P.reflect();
      bajar++;
      mov++;
    }
    if (keyCode == RIGHT)
      mov++;
    else
      mov--;
  }
}
