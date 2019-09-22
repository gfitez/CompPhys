final double l=0.1;
final double k=100;
final double m=0.3;
final double g=9.8;
final float scale=6000;
final double h=0.00003;

double theta=-PI/4;
double r=0.1;

double thetaDot=0;
double rDot=0;


public void run(){
  double rDoubleDot=(m*r*thetaDot*thetaDot+l*k-k*r+m*g*Math.cos(theta))/m;
  double thetaDoubleDot=(-Math.sin(theta)*g-2*rDot*thetaDot)/r;
  
  rDot+=rDoubleDot*h;
  thetaDot+=thetaDoubleDot*h;
  
  r+=rDot*h;
  theta+=thetaDot*h;
}
void setup(){
  size(1500,1500);
  
  
}
void draw(){
  background(255);
  for(int i=0;i<100;i++)run();
  
  
  float endX=(float)(Math.sin(theta)*r);
  float endY=(float)(Math.cos(theta)*r);
  
   
  line(width/2, height/10, (width/2+scale*endX), (height/10+scale*endY));
  circle((float)(width/2+scale*endX), (float)(height/10+scale*endY), 50);
}
