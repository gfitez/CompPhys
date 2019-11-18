void setup(){
  size(1000,1000,P3D);
  translate(width/2, height/2,0);
  box(100);
}

void draw(){
  background(0);
  translate(width/2, height/2,0);
  box(100);
 camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
}
