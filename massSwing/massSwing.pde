final double l=0.2;
final double k=100;
final double m1=0.25;
final double m2=0.3;
final double g=-9.8;
final float scale=5000;
final double h=0.00003;

double theta=-PI/4*0.5;
double r=0.1;

double thetaDot=0.0;
double rDot=0.0;


public void run(){
  double rDoubleDot=(r*thetaDot*thetaDot-m1*g+m2*g*1/Math.cos(theta))/(m1+m2);
  double thetaDoubleDot=(g/Math.cos(theta)*Math.tan(theta)-2*thetaDot*rDot)/r;
  
  
  rDot+=rDoubleDot*h;
  thetaDot+=thetaDoubleDot*h;
  
  r+=rDot*h;
  theta+=thetaDot*h;
}
void setup(){
  size(1000,1000);
  //noLoop();
  
}
final float pulleyRadius=30;
void draw(){
  background(255);
  for(int i=0;i<100;i++)run();
  
  circle(width/10, height/5, pulleyRadius*2);
  circle(width/2, height/5, pulleyRadius*2);
  
  circle((width/10)+cos((float)r*scale/pulleyRadius/2)*pulleyRadius/2, (height/5)+sin((float)r*scale/pulleyRadius/2)*pulleyRadius/2,9);
  
  line(width/10, height/5-pulleyRadius, width/2, height/5-pulleyRadius);
  
  float endX=(float)(Math.sin(theta)*r);
  float endY=(float)(Math.cos(theta)*r);
  
  
   
  line(width/2+pulleyRadius, height/5, (width/2+pulleyRadius+scale*endX), (height/10+scale*endY));
  circle((float)(width/2+pulleyRadius+scale*endX), (float)(height/10+scale*endY), 100*(float)m1);
  
  line(width/10-pulleyRadius, height/5, width/10-pulleyRadius, height/5+(float)(l-r)*scale);
  circle(width/10-pulleyRadius, height/5+(float)(l-r)*scale, 100*(float)m2); 
}
