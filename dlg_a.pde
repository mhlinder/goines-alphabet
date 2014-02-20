// construction of the Roman letter A, from DL Goines
// http://www.professores.uff.br/hjbortol/arquivo/2011.1/goines/goines-html/goines-a-en.html
int w = 480,
    h = 480,
    margin = 320;

int fg = 0,
    bg = 255;

float[][] points = new float[37][2];

void setup() {
  size(w + margin, h + margin);
  translate(margin/2, margin/2);

  background(bg);
  
  fill(fg);

  points[0][0] = 0; // A
  points[0][1] = 0;
  points[1][0] = w; // B
  points[1][1] = 0;
  points[2][0] = 0; // C
  points[2][1] = h;
  points[3][0] = w; // D
  points[3][1] = h;

  drawPoint(points[0]);
  drawPoint(points[1]);
  drawPoint(points[2]);
  drawPoint(points[3]);
  
  drawLine(points[0], points[1]);
  drawLine(points[0], points[2]);
  drawLine(points[1], points[3]);
  drawLine(points[2], points[3]);

  points[4] = bisect(points[0], points[2]); // E
  points[5] = bisect(points[1], points[3]); // F
  points[6] = bisect(points[0], points[1]); // G
  points[7] = bisect(points[2], points[3]); // H

  drawPoint(points[4]);
  drawPoint(points[5]);
  drawPoint(points[6]);
  drawPoint(points[7]);

  drawLine(points[4], points[5]);
  drawLine(points[6], points[7]);

  points[8] = lineInt(points[4], points[5], points[6], points[7]); // I
  drawPoint(points[8]);

  float d = w / 9;
  float r = d / 2;

  points[9][0] = points[4][0]; // J
  points[9][1] = points[4][1] + r;
  points[10][0] = points[4][0]; // K
  points[10][1] = points[9][1] + r;

  points[11][0] = points[8][0]; // L
  points[11][1] = points[8][1] + r;
  points[12][0] = points[8][0]; // M
  points[12][1] = points[11][1] + r;

  points[13][0] = points[5][0]; // N
  points[13][1] = points[5][1] + r;
  points[14][0] = points[5][0]; // O
  points[14][1] = points[13][1] + r;

  points[15][0] = points[6][0] - d; // P
  points[15][1] = points[6][1];
  points[16][0] = points[15][0] + r; // Q
  points[16][1] = points[6][1];
  points[17][0] = points[6][0] + r; // R
  points[17][1] = points[6][1];
  
  points[18][0] = points[12][0]; // T
  points[18][1] = points[12][1] + r;

  drawPoint(points[9]);
  drawPoint(points[10]);
  drawPoint(points[11]);
  drawPoint(points[12]);
  drawPoint(points[13]);
  drawPoint(points[14]);
  drawPoint(points[15]);
  drawPoint(points[16]);
  drawPoint(points[17]);
  drawPoint(points[18]);

  drawCircle(points[9], d);
  drawCircle(points[11], d);
  drawCircle(points[13], d);
  drawCircle(points[16], d);
  drawCircle(points[6], d);
  drawCircle(points[12], d);

  points[19] = bisect(points[11], points[12]); // U
  
  drawPoint(points[19]);

  points[20][0] = points[17][0] + r; // S
  points[20][1] = points[6][1];

  drawPoint(points[20]);
  
  drawCircle(points[17], d);

  points[21] = bisect(points[6], points[17]); // V

  drawPoint(points[21]);

  drawLine(points[9], points[13]);
  drawLine(points[10], points[14]);

  float d_u = distance(points[6], points[19]) * 2;
  float r_u = d_u / 2;

  drawCircle(points[19], d_u);

  points[22][0] = points[19][0] - sqrt(pow(r_u,2) - pow(points[2][1] - points[19][1], 2)); // W
  points[22][1] = points[2][1];
  points[23][0] = points[19][0] + sqrt(pow(r_u,2) - pow(points[2][1] - points[19][1], 2)); // X
  points[23][1] = points[2][1];

  drawPoint(points[22]);
  drawPoint(points[23]);

  points[24][0] = points[22][0] + r; // Y
  points[24][1] = points[22][1];
  points[25][0] = points[24][0] + r; // Z
  points[25][1] = points[22][1];

  points[26][0] = points[23][0] - r; // a
  points[26][1] = points[23][1];
  points[27][0] = points[26][0] - r; // b
  points[27][1] = points[23][1];

  drawPoint(points[24]);
  drawPoint(points[25]);
  drawPoint(points[26]);
  drawPoint(points[27]);

  drawCircle(points[24], d);
  drawCircle(points[26], d);

}

void drawPoint(float[] p) {
  noStroke();
  fill(fg);
  float x = p[0];
  float y = p[1];
  ellipse(x, y, 5, 5);
}

void drawLine(float[] p1, float[] p2) {
  stroke(fg);
  line(p1[0], p1[1], p2[0], p2[1]);
}

void drawCircle(float[] p, float d) {
  stroke(fg);
  noFill();
  ellipse(p[0], p[1], d, d);
}

// intersection of line segments (p1,p2) and (p3,p4)
float[] lineInt(float[] p1, float[] p2, float[] p3, float[] p4) {
  float x1 = p1[0],
        y1 = p1[1],
        x2 = p2[0],
        y2 = p2[1],
        x3 = p3[0],
        y3 = p3[1],
        x4 = p4[0],
        y4 = p4[1];
  float px = ((x1*y2-y1*x2)*(x3-x4) - (x1-x2)*(x3*y4-y3*x4)) /
    ((x1-x2)*(y3-y4) - (y1-y2)*(x3-x4));
  float py = ((x1*y2-y1*x2)*(y3-y4) - (y1-y2)*(x3*y4-y3*x4)) /
    ((x1-x2)*(y3-y4) - (y1-y2)*(x3-x4));
  float[] p = {px, py};

  return p;
}

float[] bisect(float[] p1, float[] p2) {
  float[] mid = new float[2];
  mid[0] = (p1[0]+p2[0])/2;
  mid[1] = (p1[1]+p2[1])/2;
  return mid;
}

float distance(float[] p1, float[] p2) {
  return sqrt(pow(p2[0]-p1[0], 2) + pow(p2[1]-p1[1], 2));
}
