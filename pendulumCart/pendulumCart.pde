final double scale=1000;
final double l=0.2;
final double M=0.05;
final double m=0.1;
final double g=9.8;
final double h=0.000001;
double time=0;
double a=20;
public double f(double x){return 1/a-Math.cos(a*x)/a;}
public double f1(double x){return Math.sin(a*x);}
public double f2(double x){return a*Math.cos(a*x);}

public class Motion{
   double x, xDot, xDDot;
   double theta, thetaDot, thetaDDot;
   public Motion(){}
   public double PE(){
     return M*g*f(x)+m*g*f(x)-m*g*l*Math.cos(theta);
   }
   public double KE(){
      return 0.5*(M+m)*xDot*xDot*(1+f1(x)*f1(x))+m*xDot*l*thetaDot*(Math.cos(theta)+f1(x)*Math.sin(theta))+0.5*m*l*l*thetaDot*thetaDot; 
   }
   public double E(){
      return KE()+PE(); 
   }
   //public Motion f(){
     //public dTheta
   //}
   
}
Motion s=new Motion();

public float y(double y){
  return height*0.5-(float)(y*scale);
}
public float x(double x){
  return width/2+(float)(x*scale);
}
public void drawFunc(){
  for(float x=-1;x<1;x+=0.001){
   point(x(x), y(f(x)));
  }
}
public void updateForces(){
  double x=s.x;
  double xD=s.xDot;
  double xDD=s.xDDot;
  double t=s.theta;
  double sinT=Math.sin(s.theta);
  double cosT=Math.cos(s.theta);
  double tD=s.thetaDot;
  double tDD=s.thetaDDot;

  //s.xDDot=((M+m)*xD*xD*f1(x)*f2(x)+m*xD*tD*l*sinT*f2(x)-M*g*f1(x)-m*g*f1(x)-(M+m)*xDD*f1(x)*f1(x)-2*(M+m)*xD*xD*f1(x)*f2(x)-m*l*tDD*cosT+m*l*tD*tD*sinT-m*l*tDD*f1(x)*sinT-m*l*tD*f2(x)*xD*sinT-m*l*tD*tD*f1(x)*cosT)/(M+m);
  s.xDDot=((M+m)*xD*xD*f1(x)*f2(x)+m*xD*tD*l*sinT*f2(x)-M*g*f1(x)-m*g*f1(x)-2*(M+m)*xD*xD*f1(x)*f2(x)-m*l*tDD*cosT+m*l*tD*tD*sinT-m*l*tDD*f1(x)*sinT-m*l*tD*f2(x)*xD*sinT-m*l*tD*tD*f1(x)*cosT)/((M+m)+(M+m)*f1(x)*f1(x));
  s.thetaDDot=(-m*xD*l*tD*sinT+m*xD*l*tD*f1(x)*cosT-m*g*l*sinT-m*l*xDD*cosT+m*l*xD*sinT*tD-m*l*xDD*f1(x)*sinT-m*l*xD*xD*f2(x)*sinT-m*l*xD*f1(x)*cosT*tD)/(m*l*l);
  //println((-xD*tD*sinT-g*sinT-xDD*cosT+xD*sinT*tD)/(l));
  //println(s.thetaDDot+" "+s.xDDot);
  
  
  //original
  //s.xDDot=(-xD*tD*sinT+xD*tD*f1(x)*cosT-g*sinT+xD*sinT*tD-xD*xD*f2(x)*sinT-xD*f1(x)*cosT*tD-tDD*l)/(cosT+f1(x)*sinT);
  //s.thetaDDot=((M+m)*xD*xD*f1(x)*f2(x)+m*xD*l*tD*f2(x)*sinT-M*g*f1(x)-m*g*f1(x)-(M+m)*xDD-2*(M+m)*f1(x)*f2(x)*xD*xD-(M+m)*f1(x)*f1(x)*xDD+m*l*tD*tD*sinT-m*l*tD*f2(x)*xD*sinT-m*l*tD*f1(x)*cosT*tD)/(m*l*cosT+m*l*f1(x)*sinT);
  //println(s.xDDot+" "+s.thetaDDot);
  
  
  //f(x)=0
  //s.xDDot=(m*l*sinT*tD*tD-m*l*cosT*tDD)/(M+m);
  //s.thetaDDot=(-xD*sinT*tD-g*sinT+xD*sinT*tD-xDD*cosT)/l;
  //println(s.thetaDDot);
  //println("---");
  //println(s.xDDot+" "+s.thetaDDot);

  
}
public Motion f(Motion mot){
  double x=mot.x;
  double xD=mot.xDot;
  double xDD=mot.xDDot;
  double t=mot.theta;
  double sinT=Math.sin(mot.theta);
  double cosT=Math.cos(mot.theta);
  double tD=mot.thetaDot;
  double tDD=mot.thetaDDot;

  Motion newMot=new Motion();
  newMot.xDot=((M+m)*xD*xD*f1(x)*f2(x)+m*xD*tD*l*sinT*f2(x)-M*g*f1(x)-m*g*f1(x)-2*(M+m)*xD*xD*f1(x)*f2(x)-m*l*tDD*cosT+m*l*tD*tD*sinT-m*l*tDD*f1(x)*sinT-m*l*tD*f2(x)*xD*sinT-m*l*tD*tD*f1(x)*cosT)/((M+m)+(M+m)*f1(x)*f1(x));
  newMot.thetaDot=(-m*xD*l*tD*sinT+m*xD*l*tD*f1(x)*cosT-m*g*l*sinT-m*l*xDD*cosT+m*l*xD*sinT*tD-m*l*xDD*f1(x)*sinT-m*l*xD*xD*f2(x)*sinT-m*l*xD*f1(x)*cosT*tD)/(m*l*l);
  
  newMot.xDDot=newMot.xDot-mot.xDDot;
  newMot.thetaDDot=newMot.thetaDot-mot.thetaDDot;
  
  newMot.theta=mot.thetaDot;
  newMot.x=mot.xDDot;
  
  return newMot;
}
public Motion mult(Motion mot, double h){
  Motion newMot=new Motion();
  newMot.x=mot.x*h;
  newMot.theta=mot.theta*h;
  newMot.xDot=mot.xDot*h;
  newMot.thetaDot=mot.thetaDot*h;
  newMot.xDDot=mot.xDDot*h;
  newMot.thetaDDot=mot.thetaDDot*h;
  return newMot;
}
public Motion add(Motion mot1, Motion mot2){
  Motion newMot=new Motion();
  newMot.x=mot1.x+mot2.x;
  newMot.theta=mot1.theta+mot2.theta;
  newMot.xDot=mot1.xDot+mot2.xDot;
  newMot.thetaDot=mot1.thetaDot+mot2.thetaDot;
  newMot.xDDot=mot1.xDDot+mot2.xDDot;
  newMot.thetaDDot=mot1.thetaDDot+mot2.thetaDDot;
  return newMot; 
}
public void euler(){
  updateForces();
  
  s.x+=s.xDot*h;
  s.theta+=s.thetaDot*h;
  
  s.xDot+=s.xDDot*h;
  s.thetaDot+=s.thetaDDot*h;
  
  time+=h;
}
public void rk4(){
  updateForces();
  Motion k1=mult(f(s),h);
  Motion k2=mult(f(add(s, mult(k1,0.5))), h);
  Motion k3=mult(f(add(s,mult(k2, 0.5))), h);
  Motion k4=mult(f(add(s, k3)), h);
  s=add(s, mult(add(add(add(k1, mult(k2,2)), mult(k3, 2)), k4), 1.0/6));
  
  //println(s.xDDot+", "+mult(add(add(add(k1, mult(k2,2)), mult(k3, 2)), k4), 1.0/6).xDDot);
  time+=h;
}

public void drawPendulum(){
  line(x(s.x),y(f(s.x)),x(s.x+Math.sin(s.theta)*l),y(f(s.x)-Math.cos(s.theta)*l)); 
  circle(x(s.x+Math.sin(s.theta)*l),y(f(s.x)-Math.cos(s.theta)*l),500*(float)m);
  circle(x(s.x),y(f(s.x)),500*(float)M);
}
public void setup(){
   size(2000,2000); 
   s.theta=-2;
   s.thetaDot=3.5;
   s.thetaDDot=0;
   s.x=-0.5;
   s.xDot=0;
   s.xDDot=2.24225;
   updateForces();
   //noLoop();
}
double start=System.currentTimeMillis();
public void draw(){
  strokeWeight(10);
  background(255);
  drawFunc();
  drawPendulum();
  fill(0);
  text((float)time, width/2, height/10);
  //while(time*3000<System.currentTimeMillis()-start){
  for(int i=0;i<10000;i++){
    euler();
    //print(s.xDDot+f(s).xDDot+" ");
    //rk4();
    //println(s.xDDot);
    //println(s.xDDot);
    if(Double.isNaN(s.E()))exit();
  }
  //saveFrame();
  println(s.E());
    
}
