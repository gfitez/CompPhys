final double scale=50;


public class System{
  Motion mot;
  final double l=2;
  final double M=0.5;
  final double m=1;
  final double g=9.8;
  final double h=0.0001;
  double time=0;
  double a=2;
  public System(){
    mot=new Motion();
  }
  public double f(double x){return 1/a-Math.cos(a*x)/a;}
  public double f1(double x){return Math.sin(a*x);}
  public double f2(double x){return a*Math.cos(a*x);}
  
  /**public double f(double x){return Math.pow(x,10);}
  public double f1(double x){return 10*Math.pow(x,9);}
  public double f2(double x){return 90*Math.pow(x,8);}**/
  
  //public double f(double x){return Math.sin(1/x);}
  //public double f1(double x){return -Math.cos(1/x)/x/x;}
  //public double f2(double x){return (2*x*Math.cos(1/x)-Math.sin(1/x))/Math.pow(x,4);}
  
  public double PE(){
     return M*g*f(mot.x)+m*g*f(mot.x)-m*g*l*Math.cos(mot.theta);
   }
   public double KE(){
      return 0.5*(M+m)*mot.xDot*mot.xDot*(1+f1(mot.x)*f1(mot.x))+m*mot.xDot*l*mot.thetaDot*(Math.cos(mot.theta)+f1(mot.x)*Math.sin(mot.theta))+0.5*m*l*l*mot.thetaDot*mot.thetaDot; 
   }
   public double E(){
      return KE()+PE(); 
   }
   public void drawFunc(){
    float dist=0.01;
    for(float x=-10;x<10;x+=dist){
     line(x(x), y(f(x)),x(x+dist),y(f(x+dist)));
    }
   }
   public void updateForces(){
  double x=s.mot.x;
  double xD=s.mot.xDot;
  double xDD=s.mot.xDDot;
  double t=s.mot.theta;
  double sinT=Math.sin(s.mot.theta);
  double cosT=Math.cos(s.mot.theta);
  double tD=s.mot.thetaDot;
  double tDD=s.mot.thetaDDot;


  //main
  //s.xDDot=((M+m)*xD*xD*f1(x)*f2(x)+m*xD*tD*l*sinT*f2(x)-M*g*f1(x)-m*g*f1(x)-2*(M+m)*xD*xD*f1(x)*f2(x)-m*l*tDD*cosT+m*l*tD*tD*sinT-m*l*tDD*f1(x)*sinT-m*l*tD*f2(x)*xD*sinT-m*l*tD*tD*f1(x)*cosT)/((M+m)+(M+m)*f1(x)*f1(x));
  //s.thetaDDot=(-m*xD*l*tD*sinT+m*xD*l*tD*f1(x)*cosT-m*g*l*sinT-m*l*xDD*cosT+m*l*xD*sinT*tD-m*l*xDD*f1(x)*sinT-m*l*xD*xD*f2(x)*sinT-m*l*xD*f1(x)*cosT*tD)/(m*l*l);

  
  
  //original (broken)
  //s.xDDot=(-xD*tD*sinT+xD*tD*f1(x)*cosT-g*sinT+xD*sinT*tD-xD*xD*f2(x)*sinT-xD*f1(x)*cosT*tD-tDD*l)/(cosT+f1(x)*sinT);
  //s.thetaDDot=((M+m)*xD*xD*f1(x)*f2(x)+m*xD*l*tD*f2(x)*sinT-M*g*f1(x)-m*g*f1(x)-(M+m)*xDD-2*(M+m)*f1(x)*f2(x)*xD*xD-(M+m)*f1(x)*f1(x)*xDD+m*l*tD*tD*sinT-m*l*tD*f2(x)*xD*sinT-m*l*tD*f1(x)*cosT*tD)/(m*l*cosT+m*l*f1(x)*sinT);
  //println(s.xDDot+" "+s.thetaDDot);
  
  //simplified
  //s.xDDot=(-2*(M+m)*xD*xD*f1(x)*f2(x)-m*l*tDD*cosT+m*l*tD*tD*sinT-m*l*tDD*f1(x)*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))/((M+m)*(1+f1(x)*f1(x)));
  //s.thetaDDot=(-g*sinT-xDD*cosT-xDD*f1(x)*sinT-xD*xD*f2(x)*sinT)/l;
  
  //no xddot or thetaddot
  s.mot.xDDot=(-2*(M+m)*xD*xD*f1(x)*f2(x)+m*g*sinT*cosT+m*xD*xD*f2(x)*sinT*cosT+m*l*tD*tD*sinT+m*g*f1(x)*sinT*sinT+m*xD*xD*f1(x)*f2(x)*sinT*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))/((M+m)*(1+f1(x)*f1(x))-m*cosT*cosT-m*f1(x)*sinT*cosT-m*f1(x)*cosT*sinT-m*f1(x)*f1(x)*sinT*sinT);
  s.mot.thetaDDot=(-g*sinT-(cosT+f1(x)*sinT)/((M+m)*(1+f1(x)*f1(x)))*(-2*(M+m)*xD*xD*f1(x)*f2(x)+m*l*tD*tD*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))-xD*xD*f2(x)*sinT)/(l-m*l/((M+m)*(1+f1(x)*f1(x)))*(cosT*cosT+cosT*f1(x)*sinT+f1(x)*sinT*cosT+f1(x)*sinT*f1(x)*sinT));

  
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
  newMot.theta=mot.thetaDot;
  newMot.x=mot.xDot;
  
  newMot.xDot=(-2*(M+m)*xD*xD*f1(x)*f2(x)+m*g*sinT*cosT+m*xD*xD*f2(x)*sinT*cosT+m*l*tD*tD*sinT+m*g*f1(x)*sinT*sinT+m*xD*xD*f1(x)*f2(x)*sinT*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))/((M+m)*(1+f1(x)*f1(x))-m*cosT*cosT-m*f1(x)*sinT*cosT-m*f1(x)*cosT*sinT-m*f1(x)*f1(x)*sinT*sinT);
  newMot.thetaDot=(-g*sinT-(cosT+f1(x)*sinT)/((M+m)*(1+f1(x)*f1(x)))*(-2*(M+m)*xD*xD*f1(x)*f2(x)+m*l*tD*tD*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))-xD*xD*f2(x)*sinT)/(l-m*l/((M+m)*(1+f1(x)*f1(x)))*(cosT*cosT+cosT*f1(x)*sinT+f1(x)*sinT*cosT+f1(x)*sinT*f1(x)*sinT));
  
  
  
  return newMot;
}
public void euler(){
  updateForces();
  
  s.mot.x+=s.mot.xDot*h;
  s.mot.theta+=s.mot.thetaDot*h;
  
  s.mot.xDot+=s.mot.xDDot*h;
  s.mot.thetaDot+=s.mot.thetaDDot*h;
  
  time+=h;
}
public void rk4(){
  Motion k1=mult(f(s.mot),h);
  Motion k2=mult(f(add(s.mot, mult(k1,0.5))), h);
  Motion k3=mult(f(add(s.mot,mult(k2, 0.5))), h);
  Motion k4=mult(f(add(s.mot, k3)), h);
  s.mot=add(s.mot, mult(add(add(add(k1, mult(k2,2)), mult(k3, 2)), k4), 1.0/6));

  time+=h;
}

public void drawPendulum(){
  line(x(s.mot.x),y(f(s.mot.x)),x(s.mot.x+Math.sin(s.mot.theta)*l),y(f(s.mot.x)-Math.cos(s.mot.theta)*l)); 
  circle(x(s.mot.x+Math.sin(s.mot.theta)*l),y(f(s.mot.x)-Math.cos(s.mot.theta)*l),sqrt(500*(float)m));
  circle(x(s.mot.x),y(f(s.mot.x)),sqrt(500*(float)M));
}
}

public class Motion{
   double x, xDot, xDDot;
   double theta, thetaDot, thetaDDot;
   public Motion(){}
   
}


public float y(double y){
  return height*0.5-(float)(y*scale);
}
public float x(double x){
  return width/2+(float)(x*scale);
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




System s=new System();
double initialEnergy;
public void setup(){

   
   size(2000,2000); 
   s.mot.theta=0;
   s.mot.thetaDot=0;
   s.mot.x=-2;
   s.mot.xDot=10;

   //noLoop();
   
   initialEnergy=s.E();
   println(s.E());
}


public void draw(){
  strokeWeight(10);
  background(255);
  s.drawFunc();
  s.drawPendulum();
  fill(0);
  text((float)s.time, width/2, height/10);
  //while(time*3000<System.currentTimeMillis()-start){
  
  for(int i=0;i<300;i++){
    //euler();
    //print(s.xDDot+f(s).xDDot+" ");
    s.rk4();
    //println(s.xDDot);
    //println(s.xDDot);
    if(Double.isNaN(s.E()))exit();
  }
  //println(s.E());
  println((s.E()-initialEnergy)/s.E()*100+"%");
  //saveFrame();
  
    
}
