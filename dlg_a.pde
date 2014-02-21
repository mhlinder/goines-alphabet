// construction of the Roman letter A, from DL Goines
// http://www.professores.uff.br/hjbortol/arquivo/2011.1/goines/goines-html/goines-a-en.html
int w = 480,
    h = 480,
    margin = 320;

int fg = 0,
    bg = 255;

float[][] points = new float[37][2];
float[][] extra_points = new float[1][2];

void setup() {
  size(w + margin, h + margin);
  translate(margin/2, margin/2);

  background(bg);
  
  fill(fg);
  
  // TODO:
  // 1. add loop for points, lines, circle to draw
  // 2. functions for math?

  // 1. Construct first a square ABCD, and bisect AC at E, BD at F, AB at G, and CD at H.
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

  // 2.  Draw the straight lines EF and GH, thereby establishing a point I at their intersection.
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


  // 3. Using a diameter of one-ninth the distance AB, describe on EC a circle
  // EJK, on IH a circle ILM, on FD a circle FNO, on AG a circle PQG, from the
  // center G a circle QGR, and from the center M a circle LMT.
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

  // 4. Bisect the intersection of L and M to establish on LM a point U.
  points[19] = bisect(points[11], points[12]); // U
  
  drawPoint(points[19]);

  // 5. Using the radius EJ, describe a circle GRS on RB.
  points[20][0] = points[17][0] + r; // S
  points[20][1] = points[6][1];

  drawPoint(points[20]);
  
  drawCircle(points[17], d);

  // 6. Bisect the distance GR, thereby establishing a point V on GR.
  points[21] = bisect(points[6], points[17]); // V

  drawPoint(points[21]);

  // 7. Draw now the straight lines JN and KO.
  drawLine(points[9], points[13]);
  drawLine(points[10], points[14]);

  float d_u = distance(points[6], points[19]) * 2;
  float r_u = d_u / 2;

  drawCircle(points[19], d_u);

  // 8. From the center U, describe a circle intersecting G, thereby establishing a point W on CH and a point X on HD.
  points[22][0] = points[19][0] - sqrt(pow(r_u,2) - pow(points[2][1] - points[19][1], 2)); // W
  points[22][1] = points[2][1];
  points[23][0] = points[19][0] + sqrt(pow(r_u,2) - pow(points[2][1] - points[19][1], 2)); // X
  points[23][1] = points[2][1];

  drawPoint(points[22]);
  drawPoint(points[23]);

  // 9. Using the radius EJ, describe on WH a circle WYZ, and on HX a circle abX.
  points[24][0] = points[22][0] + r; // Y
  points[24][1] = points[22][1];
  points[25][0] = points[24][0] + r; // Z
  points[25][1] = points[22][1];

  points[26][0] = points[23][0] - d; // a
  points[26][1] = points[23][1];
  points[27][0] = points[23][0] - r; // b
  points[27][1] = points[23][1];

  drawPoint(points[24]);
  drawPoint(points[25]);
  drawPoint(points[26]);
  drawPoint(points[27]);

  drawCircle(points[24], d);
  drawCircle(points[27], d);

  // 10. Draw a straight line tangential to PQG and abX, in such a manner that it intersects AP and Ha.

  // we want to find lines tangent to the circles drawn with centers Q, b, and radius r;
  // these outer tangent lines will have slopes parallel to the slope of the line between
  // points Q and b
  float m = (points[16][1] - points[27][1]) / (points[16][0] - points[27][0]);

  float tan_x1_Q = points[16][0] - r*m / sqrt(pow(m, 2) + 1);
  float tan_y1_Q = (-1/m)*(tan_x1_Q - points[16][0]) + points[16][1];
  float[] tan_p1_Q = {tan_x1_Q, tan_y1_Q};

  // so equation of first tangent line is
  //    y - tan_y1_Q = m * (x - tan_x1_Q)

  // these two points and their line precede points c and d; but they are not named, so we name them c_prime and d_prime
  float[] c_prime = new float[2];
  c_prime[1] = points[27][1];
  c_prime[0] = (c_prime[1] - tan_y1_Q) / m + tan_x1_Q;
  float[] d_prime = new float[2];
  d_prime[1] = points[16][1];
  d_prime[0] = (d_prime[1] - tan_y1_Q) / m + tan_x1_Q;

  drawPoint(c_prime);
  drawPoint(d_prime);

  drawLine(c_prime, d_prime);

  // 11. Draw another straight line tangential to PQG and abX, in such a manner that it intersects XD at c and GV at d.
  float tan_x2_Q = points[16][0] + r*m / sqrt(pow(m, 2) + 1);
  float tan_y2_Q = (-1/m)*(tan_x2_Q - points[16][0]) + points[16][1];
  float[] tan_p2_Q = {tan_x2_Q, tan_y2_Q};

  // so equation of first tangent line is
  //    y - tan_y2_Q = m * (x - tan_x2_Q)
  points[28][1] = points[27][1];
  points[28][0] = (points[28][1] - tan_y2_Q) / m + tan_x2_Q; // c
  points[29][1] = points[16][1];
  points[29][0] = (points[29][1] - tan_y2_Q) / m + tan_x2_Q; // d

  drawPoint(points[28]);
  drawPoint(points[29]);


  // 12. Draw the straight line WQ, and produce it to e.
  //
  // drawLine(points[28], points[29]);

  float m_W_Q = (points[22][1] - points[16][1]) / (points[22][0] - points[16][0]);

  // e is the intersection of the lines c-d and W-Q
  points[30][0] = (m_W_Q*points[22][0] - m*points[28][0] + points[28][1] - points[22][1]) / (m_W_Q - m); // e
  points[30][1] = m*(points[30][0] - points[29][0]) + points[29][1];

  drawPoint(points[30]);

  // 13. Produce Xd to e.
  drawLine(points[28], points[30]);
  drawLine(points[22], points[30]);

  // 14. From the center Z, using the radius EJ, describe a circle YZf.
  points[31][0] = points[25][0] + r; // f
  points[31][1] = points[25][1];

  drawPoint(points[31]);

  drawCircle(points[25], d);

  // 15. Bisect the intersections of Y and Z to establish a point g on YZ.
  points[32] = bisect(points[24], points[25]); // g

  drawPoint(points[32]);

  // 16. Draw the straight line Vg.
  drawLine(points[21], points[32]);

  // 17. Using the radius EJ, describe a circle h tangential to Vg and to Zf.
  // h_xshift = r / tan(theta/2), 
  // tan(theta/2) = abs(slope Vg, as Zf is parallel to X axis) / 2 = abs((...)) / 2
  float h_xshift = r / tan(atan(abs((points[21][1]-points[32][1])/(points[21][0]-points[32][0]))) / 2); // horizontal shift from point Z to h; vertshift is just r

  points[33][0] = points[32][0] + h_xshift; // h
  points[33][1] = points[32][1] - r;

  drawPoint(points[33]);

  drawCircle(points[33], d);

  // 18. Describe a circle i on KC tangential to CW and to WQ.

  // for i at point (x0=0, y0), we know the lengths of Ci and Ti are equal, giving us the
  // equation is y0:
  //    (yc-y0)^2 = xT^2 + (yT-y0)^2
  // which simplifies to:

  // 19. Describe a circle j on OD tangential to XD and to Xe.
  // 20. Using a diameter equal to the radius EJ, describe a circle k tangential to Ha and to Pa.
  save("A.png");
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
