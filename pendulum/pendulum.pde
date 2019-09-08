final double g=9.81;
final double l=1;
final double scale=300;
final double h=0.0005;
final double m=1;

double t=0;
R r=new R(PI/4,0);

public class R{
  double theta, omega;
  public R(double theta,double omega){
    this.theta=theta;
    this.omega=omega;
  }
}
public R mult(R r, double x){
  return new R(r.theta*x, r.omega*x);
}
public R add(R r1, R r2){
  return new R(r1.theta+r2.theta,r1.omega+r2.omega);
}
public R f(R r,double t){
  double theta=r.theta;
  double omega=r.omega;
  double ftheta=omega;
  double fomega=-(g/l)*Math.sin(theta);
  return new R(ftheta,fomega);
}
public double E(R r){
  double PE=g*(l-Math.cos(r.theta)*l)*m;
  double v=l*r.omega;
  double KE=0.5*m*v*v;
  return KE+PE;
}
public void step(){
  R k1 = mult(f(r,t),h);
  R k2=mult(f(add(r,mult(k1,0.5)), t+h/2),h);
  R k3=mult(f(add(r,mult(k2,0.5)),t+h/2),h);
  R k4=mult(f(add(k3,r),t+h),h);
  
  r=add(r, mult(add(add(add(k1,mult(k2,2)),mult(k3,2)),k4),1.0/6));
  t+=h;
}

void setup(){
  size(500,500); 
}
void draw(){
  for(int i=0;i<100;i++)step();
  
  background(255);
  float startX=width/2;
  float startY=height/10;
  float x=startX+(float)(l*scale*Math.sin(r.theta));
  float y=startY+(float)(l*scale*Math.cos(r.theta));
  line(startX,startY,x,y);
  circle(x,y,30);
  fill(0);
  text("Time(seconds): "+t,10,10);
  text("Energy: "+E(r),10,20);
}
