final double G=6.67430E-11;
final double M=1.989E30;
final double scale=width/5E11;

int t=0;

public class Motion{
  double x,y,xVel,yVel,xAcc,yAcc;
  public Motion(double x,double y,double xVel,double yVel){
    this.x=x;
    this.y=y;
    this.xVel=xVel;
    this.yVel=yVel;
    this.xAcc=xAcc;
    this.yAcc=yAcc;
  }
}
public Motion mult(Motion m, double h){
  return new Motion(m.x*h,m.y*h,m.xVel*h,m.yVel*h);
}
public Motion add(Motion m1, Motion m2){
  return new Motion(m1.x+m2.x,m1.y+m2.y,m1.xVel+m2.xVel,m1.yVel+m2.yVel);
}
public class Body{
  public Motion m;
  public double mass;
  public Body(Motion m){
    this.m=m;
    mass=1;
  }
  public void draw(){
    circle(width/10+(float)(m.x*scale),height/2+(float)(m.y*scale),10);
  }
  public double E(){
    double r=Math.sqrt(Math.pow(m.x-sun.m.x,2)+Math.pow(m.y-sun.m.y,2));
    double PE=-G*M*mass/r;
    
    double v=Math.sqrt(Math.pow(m.xVel,2)+Math.pow(m.yVel,2));
    double KE=0.5*mass*v*v;
    
    
    return PE+KE;
  }
}
public Motion f(Motion m){
  double r=Math.sqrt(Math.pow(m.x-sun.m.x,2)+Math.pow(m.y-sun.m.y,2));
  
  double dx=m.xVel;
  double dy=m.yVel;
  double dXVel=-G*M/Math.pow(r,3)*m.x;
  double dYVel=-G*M/Math.pow(r,3)*m.y;

  return new Motion(dx,dy,dXVel,dYVel);
  
}
public Motion rk4(Motion m){
  double h=10000;
  Motion k1=mult(f(m),h);
  Motion k2=mult(f(add(m,mult(k1,0.5))),h);
  Motion k3=mult(f(add(m,mult(k2,0.5))),h);
  Motion k4=mult(f(add(m,k3)),h);
  t+=h;

  return add(m, mult(add(add(add(k1,mult(k2,2)),mult(k3,2)),k4),1.0/6));
}
Body sun=new Body(new Motion(1E6,0,0,0));
Body comet=new Body(new Motion(4E12,0,0,500));
void setup(){
  size(1000,500);
}
void draw(){
  background(255);
  for(int i=0;i<100;i++)comet.m=rk4(comet.m);
  sun.draw();
  comet.draw();
  fill(0);
  text("Time(seconds): "+t,10,10);
  text("Energy: "+comet.E(),10,20);
}
