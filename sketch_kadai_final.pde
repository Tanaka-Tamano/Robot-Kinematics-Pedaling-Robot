
int l1 = 150; // アーム1の長さ
int l2 = 150; // アーム2の長さ
int l3 = 150; // アーム3の長さ
int l4 = 150; // アーム4の長さ
float theta1; // アーム1の角度
float theta2; // アーム2の角度
float theta3; // アーム3の角度
float theta4; // アーム4の角度

void setup() {
  size(800, 800);
}

void draw() {
  background(128);
  
  float x0 = width/2; // x方向の画面中心（原点とする）
  float y0 = height/2; // y方向の画面中心（原点とする）
  float Px = mouseX - x0; // 画面の中心を原点とした時のマウスのx座標
  float Py = mouseY - y0; // 画面の中心を原点とした時のマウスのy座標
  
  // 青アームと緑アームを表示できる範囲を濃いグレーの円で表示
  noStroke();
  fill(150);
  ellipse(x0, y0, 2*abs(l1+l2), 2*abs(l1+l2)); // アームの最大距離の円を描く
  
  // ペダルの可動範囲
  noStroke();
  fill(180);
  ellipse(470, 570, 170, 170);
  
  // 自転車の車輪（前）
  strokeWeight(2);
  stroke(0);
  noFill();
  ellipse(650, 570, 200, 200);
  for (int i = 0; i < 16; i += 1){
    line(650, 570, 650 + 100*cos(PI/8*i), 570 + 100*sin(PI/8*i));
  }
  
  // 自転車の車輪（後）
  ellipse(300, 570, 200, 200);
  for (int i = 0; i < 16; i += 1){
    line(300, 570, 300 + 100*cos(PI/8*i), 570 + 100*sin(PI/8*i));
  }  
  
  // 自転車 その他の部分
  strokeWeight(8);
  line(300, 570, 470, 570);
  line(300, 570, 420, 450);
  line(470, 570, 400, 400);
  line(470, 570, 620, 450);  
  line(650, 570, 600, 380);
  line(600, 380, 580, 360);
  line(600, 380, 570, 390);
  fill(0);
  rect(370, 400, 30, 10);
  
  
  // アーム1の計算
  float cos_alfa_n1 = sq(l1) - sq(l2) + sq(Px) + sq(Py); // cosαの分子を計算
  float cos_alfa_d1 = 2 * l1 * sqrt(sq(Px)+sq(Py)); // cosαの分母を計算

  // theta1を算出
  if (mouseX >= x0) { // atanの範囲が-π/2~π/2なので場合分けが必要
    theta1 = atan(Py/Px) - acos(cos_alfa_n1/cos_alfa_d1); // theta1を算出
  } else {
    theta1 = atan(Py/Px) - acos(cos_alfa_n1/cos_alfa_d1) + PI; // x<0になる領域では+PIする
  }

  float x1 = x0 + l1*cos(theta1); // アーム1の終点 かつ アーム2の原点
  float y1 = y0 + l1*sin(theta1); // アーム1の終点 かつ アーム2の原点

  // アーム1を描画
  stroke(0, 10, 255);
  strokeWeight(3);
  // 原点(x0,y0)とアーム1の終点(x1,y1)を結んで描く
  line(x0, y0, x1, y1);

  // アーム2の計算
  float cos_gamma_n1 = sq(l1) + sq(l2) - sq(Px) - sq(Py); // cosγの分子を計算
  float cos_gamma_d1 = 2 * l1 * l2; // cosγの分母を計算
  theta2 = PI - acos(cos_gamma_n1/cos_gamma_d1);// theata2を算出

  // アーム2の線を描画
  stroke(0, 255, 0);
  // アーム1の終点(x1,y1)とアーム2の終点を結んで描く
  line(x1, y1, x1 + l2*cos(theta1 + theta2), y1 + l2*sin(theta1 + theta2));

  float Qx = 140 - Px;
  float Qy = 340 - Py;
  
  // アーム3の計算
  float cos_alfa_n2 = sq(l3) - sq(l4) + sq(Qx) + sq(Qy); // cosαの分子を計算
  float cos_alfa_d2 = 2 * l3 * sqrt(sq(Qx)+sq(Qy)); // cosαの分母を計算

  // theta3を算出
  if (mouseX >= x0) { // atanの範囲が-π/2~π/2なので場合分けが必要
    theta3 = atan(Qy/Qx) - acos(cos_alfa_n2/cos_alfa_d2); // theta3を算出
  } else {
    theta3 = atan(Qy/Qx) - acos(cos_alfa_n2/cos_alfa_d2) + PI; // x<0になる領域では+PIする
  }

  float x3 = x0 + l3*cos(theta3); // アーム3の終点 かつ アーム4の原点
  float y3 = y0 + l3*sin(theta3); // アーム3の終点 かつ アーム4の原点

  // アーム3を描画
  stroke(255, 0, 0);
  strokeWeight(3);
  // 原点(x0,y0)とアーム3の終点(x3,y3)を結んで描く
  line(x0, y0, x3, y3);

  // アーム4の計算
  float cos_gamma_n2 = sq(l3) + sq(l4) - sq(Qx) - sq(Qy); // cosγの分子を計算
  float cos_gamma_d2 = 2 * l2 * l4; // cosγの分母を計算
  theta4 = PI - acos(cos_gamma_n2/cos_gamma_d2);// theata4を算出

  // アーム4の線を描画
  stroke(255, 250, 0);
  // アーム3の終点(x3,y3)とアーム4の終点を結んで描く
  line(x3, y3, x3 + l4*cos(theta3 + theta4), y3 + l4*sin(theta3 + theta4));
}
