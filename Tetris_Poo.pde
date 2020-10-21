final int ROWS = 20;
final int COLS = 10;
int LENGTH = 20;
Tetromino P;
int[][] tableu = new int[ROWS+2][COLS+2];
int[][] arr = {{0, 0, 0}, {1, 1, 1}, {0, 1, 0}};

void setup() {
  size(600, 600);
  for (int i = 0; i <= ROWS+1; i++) {
    for (int j = 0; j <= COLS+1; j++) {
      if(i == 0 || i == ROWS+1 || j == 0 || j == COLS+1)
        tableu[i][j] = -1;
      else
        tableu[i][j] = 0;
    }
  }
  P = new Tetromino();
  P.shape = arr;
}

void draw() {
  background(20);
  drawTablero();
  P.displayP();
}

class Tetromino {
  private int[][] shape;
  int c1 = int(random(255));
  int c2 = int(random(255));
  int c3 = int(random(255));

  /**
   * @param {Array} shape [rowIndex][columnIndex]
   */
  public int[][] getShape() {
    return shape;
  }

  public void setShape(int[][] newShape) {
    this.shape = newShape;
  }

  /**
   * Horizontal reflection
   */
  public void reflect() {
    int l = shape.length / 2;
    int[] temp;
    for (int i = 0; i < l; i++) {
      temp = shape[shape.length - 1 - i];
      shape[shape.length - i - 1] = shape[i];
      shape[i] = temp;
    }
  }

  /**
   * Clockwise rotation
   */
  private void rotate() {
    for (int i = 0; i < shape.length / 2; ++i) {
      for (int j = i; j < shape.length - 1 - i; ++j) {
        int temp = shape[j][i];
        shape[j][i] = shape[i][shape.length - j - 1];
        shape[i][shape.length - j - 1] = shape[shape.length - j - 1][shape.length - i - 1];
        shape[shape.length - j - 1][shape.length - i - 1] = shape[shape.length - i - 1][j];
        shape[shape.length - i - 1][j] = temp;
      }
    }
  }

  private void displayP() {
    //int c = 0;
    for (int i = 0; i < shape.length; i++) {
      for (int j = 0; j < shape[i].length; j++) {
        if (shape[i][j] != 0) {
          fill(c1, c2, c3);
          rect(280+20*j, 80+20*i, LENGTH, LENGTH);
        }
      }
    }
  }
}

void drawTablero() {
  for(int i = 0; i <= ROWS+1; i++){
    for(int j = 0; j <= COLS+1; j++){
      if(tableu[i][j] == 0){
        push();
        fill(110);
        stroke(255);
        translate(j * LENGTH, i * LENGTH);
        rect(180,79,LENGTH,LENGTH);
        pop();
      }else if(tableu[i][j] == -1){
        push();
        fill(0);
        stroke(255);
        translate(j * LENGTH, i * LENGTH);
        rect(180,79,LENGTH,LENGTH);
        pop();
      }
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      P.rotate();
    }
    if (keyCode == DOWN) {
      P.reflect();
    }
  }
}
