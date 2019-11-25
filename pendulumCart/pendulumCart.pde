final double scale=50;


public class System{
  Motion mot;
  final double l=1;//length of Pendulum
  final double M=1;//weight of upper mass
  final double m=1;//weight of lower Mass
  final double g=9.8;//acceleration due to gravity
   double h=0.01;//delta time
  double time=0;
  public System(){
    mot=new Motion();
  }
  public double f(double x){return 1-Math.cos(x);}
  public double f1(double x){return Math.sin(x);}//first derivative of f with respect to x
  public double f2(double x){return Math.cos(x);}//second derivative of f with respect to x
  /**public double f(double x){return 1/a-Math.cos(a*x)/a;}
  public double f1(double x){return Math.sin(a*x);}
  public double f2(double x){return a*Math.cos(a*x);}**/
  
  /**public double f(double x){return Math.pow(x,10);}
  public double f1(double x){return 10*Math.pow(x,9);}
  public double f2(double x){return 90*Math.pow(x,8);}**/
  
  //public double f(double x){return Math.sin(1/x);}
  //public double f1(double x){return -Math.cos(1/x)/x/x;}
  //public double f2(double x){return (2*x*Math.cos(1/x)-Math.sin(1/x))/Math.pow(x,4);}
  
  public double PE(){//Potential Energy
     return M*g*f(mot.x)+m*g*f(mot.x)-m*g*l*Math.cos(mot.theta);
   }
   public double KE(){//Kinetic Energy
      return 0.5*(M+m)*mot.xDot*mot.xDot*(1+f1(mot.x)*f1(mot.x))+m*mot.xDot*l*mot.thetaDot*(Math.cos(mot.theta)+f1(mot.x)*Math.sin(mot.theta))+0.5*m*l*l*mot.thetaDot*mot.thetaDot; 
   }
   public double E(){//Total energy
      return KE()+PE(); 
   }
   public void drawFunc(){//draw function 
    float dist=0.01;
    for(float x=-10;x<10;x+=dist){
     line(x(x), y(f(x)),x(x+dist),y(f(x+dist)));
    }
   }
   public void updateForces(){//update x double dot and theta double dot
    double x=mot.x;
    double xD=mot.xDot;
    double xDD=mot.xDDot;
    double t=mot.theta;
    double sinT=Math.sin(mot.theta);
    double cosT=Math.cos(mot.theta);
    double tD=mot.thetaDot;
    double tDD=mot.thetaDDot;
  
  
    //main
    //xDDot=((M+m)*xD*xD*f1(x)*f2(x)+m*xD*tD*l*sinT*f2(x)-M*g*f1(x)-m*g*f1(x)-2*(M+m)*xD*xD*f1(x)*f2(x)-m*l*tDD*cosT+m*l*tD*tD*sinT-m*l*tDD*f1(x)*sinT-m*l*tD*f2(x)*xD*sinT-m*l*tD*tD*f1(x)*cosT)/((M+m)+(M+m)*f1(x)*f1(x));
    //thetaDDot=(-m*xD*l*tD*sinT+m*xD*l*tD*f1(x)*cosT-m*g*l*sinT-m*l*xDD*cosT+m*l*xD*sinT*tD-m*l*xDD*f1(x)*sinT-m*l*xD*xD*f2(x)*sinT-m*l*xD*f1(x)*cosT*tD)/(m*l*l);
  
    
    
    //original (broken)
    //xDDot=(-xD*tD*sinT+xD*tD*f1(x)*cosT-g*sinT+xD*sinT*tD-xD*xD*f2(x)*sinT-xD*f1(x)*cosT*tD-tDD*l)/(cosT+f1(x)*sinT);
    //thetaDDot=((M+m)*xD*xD*f1(x)*f2(x)+m*xD*l*tD*f2(x)*sinT-M*g*f1(x)-m*g*f1(x)-(M+m)*xDD-2*(M+m)*f1(x)*f2(x)*xD*xD-(M+m)*f1(x)*f1(x)*xDD+m*l*tD*tD*sinT-m*l*tD*f2(x)*xD*sinT-m*l*tD*f1(x)*cosT*tD)/(m*l*cosT+m*l*f1(x)*sinT);
    //println(xDDot+" "+thetaDDot);
    
    //simplified
    //xDDot=(-2*(M+m)*xD*xD*f1(x)*f2(x)-m*l*tDD*cosT+m*l*tD*tD*sinT-m*l*tDD*f1(x)*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))/((M+m)*(1+f1(x)*f1(x)));
    //thetaDDot=(-g*sinT-xDD*cosT-xDD*f1(x)*sinT-xD*xD*f2(x)*sinT)/l;
    
    //no xddot or thetaddot
    mot.xDDot=(-2*(M+m)*xD*xD*f1(x)*f2(x)+m*g*sinT*cosT+m*xD*xD*f2(x)*sinT*cosT+m*l*tD*tD*sinT+m*g*f1(x)*sinT*sinT+m*xD*xD*f1(x)*f2(x)*sinT*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))/((M+m)*(1+f1(x)*f1(x))-m*cosT*cosT-m*f1(x)*sinT*cosT-m*f1(x)*cosT*sinT-m*f1(x)*f1(x)*sinT*sinT);
    mot.thetaDDot=(-g*sinT-(cosT+f1(x)*sinT)/((M+m)*(1+f1(x)*f1(x)))*(-2*(M+m)*xD*xD*f1(x)*f2(x)+m*l*tD*tD*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))-xD*xD*f2(x)*sinT)/(l-m*l/((M+m)*(1+f1(x)*f1(x)))*(cosT*cosT+cosT*f1(x)*sinT+f1(x)*sinT*cosT+f1(x)*sinT*f1(x)*sinT));
  
    
  }
  public Motion f(Motion mot){//return delta x, delta theta, delta x dot, and delta theta dot
    double x=mot.x;
    double xD=mot.xDot;

    double t=mot.theta;
    double sinT=Math.sin(mot.theta);
    double cosT=Math.cos(mot.theta);
    double tD=mot.thetaDot;

  
    Motion newMot=new Motion();
    newMot.theta=mot.thetaDot;
    newMot.x=mot.xDot;
    
    newMot.xDot=(-2*(M+m)*xD*xD*f1(x)*f2(x)+m*g*sinT*cosT+m*xD*xD*f2(x)*sinT*cosT+m*l*tD*tD*sinT+m*g*f1(x)*sinT*sinT+m*xD*xD*f1(x)*f2(x)*sinT*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))/((M+m)*(1+f1(x)*f1(x))-m*cosT*cosT-m*f1(x)*sinT*cosT-m*f1(x)*cosT*sinT-m*f1(x)*f1(x)*sinT*sinT);
    newMot.thetaDot=(-g*sinT-(cosT+f1(x)*sinT)/((M+m)*(1+f1(x)*f1(x)))*(-2*(M+m)*xD*xD*f1(x)*f2(x)+m*l*tD*tD*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))-xD*xD*f2(x)*sinT)/(l-m*l/((M+m)*(1+f1(x)*f1(x)))*(cosT*cosT+cosT*f1(x)*sinT+f1(x)*sinT*cosT+f1(x)*sinT*f1(x)*sinT));
    
    
    
    return newMot;
  }
  public void euler(){//run iteration of euler's method
    updateForces();
    
    mot.x+=mot.xDot*h;
    mot.theta+=mot.thetaDot*h;
    
    mot.xDot+=mot.xDDot*h;
    mot.thetaDot+=mot.thetaDDot*h;
    
    time+=h;
  }
  public void rk4(){//run iteration of fourth order runge-kutta
    Motion k1=mult(f(mot),h);
    Motion k2=mult(f(add(mot, mult(k1,0.5))), h);
    Motion k3=mult(f(add(mot,mult(k2, 0.5))), h);
    Motion k4=mult(f(add(mot, k3)), h);
    mot=add(mot, mult(add(add(add(k1, mult(k2,2)), mult(k3, 2)), k4), 1.0/6));
  
    time+=h;
  }
  
  public void drawPendulum(){//draw system
    line(x(mot.x),y(f(mot.x)),x(mot.x+Math.sin(mot.theta)*l),y(f(mot.x)-Math.cos(mot.theta)*l)); 
    circle(x(mot.x+Math.sin(mot.theta)*l),y(f(mot.x)-Math.cos(mot.theta)*l),sqrt(500*(float)m));
    circle(x(mot.x),y(f(mot.x)),sqrt(500*(float)M));
  }
}

public class Motion{
   double x, xDot, xDDot;
   double theta, thetaDot, thetaDDot;
   public Motion(){}
   public String toString(){
     return "{x:"+x+" theta:"+theta+" xDot:"+xDot+" thetaDot:"+thetaDot+"}";
   }
   
}


public float y(double y){//scale a simulated y cooridanant for teh screen
  return height*0.5-(float)(y*scale);
}
public float x(double x){//scale a simulated x cooridanant for teh screen
  return width/2+(float)(x*scale);
}



public Motion mult(Motion mot, double h){//multiply motion vector by scalar
  Motion newMot=new Motion();
  newMot.x=mot.x*h;
  newMot.theta=mot.theta*h;
  newMot.xDot=mot.xDot*h;
  newMot.thetaDot=mot.thetaDot*h;
  newMot.xDDot=mot.xDDot*h;
  newMot.thetaDDot=mot.thetaDDot*h;
  return newMot;
}
public Motion add(Motion mot1, Motion mot2){//add two motion vectors
  Motion newMot=new Motion();
  newMot.x=mot1.x+mot2.x;
  newMot.theta=mot1.theta+mot2.theta;
  newMot.xDot=mot1.xDot+mot2.xDot;
  newMot.thetaDot=mot1.thetaDot+mot2.thetaDot;
  newMot.xDDot=mot1.xDDot+mot2.xDDot;
  newMot.thetaDDot=mot1.thetaDDot+mot2.thetaDDot;
  return newMot; 
}


public double chaosTest(double x, double theta, double xDot, double thetaDot, double maxError){//measure how chaotic a certain area of the system is in 4d space (x,theta,xDot,thetaDot)
  double range=0.000001;//difference between sample points
  Motion[] results=new Motion[16];
  int index=0;
  for(double x0=x-range/2; x0<=x+range/2; x0+=range)
    for(double theta0=theta-range/2; theta0<=theta+range/2; theta0+=range)
      for(double xDot0=xDot-range/2; xDot0<=xDot+range/2; xDot0+=range)
        for(double thetaDot0=thetaDot-range/2; thetaDot0<=thetaDot+range/2; thetaDot0+=range){
          System s=new System();
          s.mot.x=x0;
          s.mot.theta=theta0;
          s.mot.xDot=xDot0;
          s.mot.thetaDot=thetaDot0;
          double initialE=s.E();
          while(s.time<10){s.rk4();}//run system for certain amount of time
          while((s.E()-initialE)/initialE>maxError){//rerun if too much error
            s.h/=2;
            println("rerunning");
            s.mot.x=x0;
            s.mot.theta=theta0;
            s.mot.xDot=xDot0;
            s.mot.thetaDot=thetaDot0;
            s.time=0;
            while(s.time<10){s.rk4();}//run system for certain amount of time
          }
          results[index]=s.mot;
          index++;
        }
   double distTotal=0;
   

  for(int i=0;i<results.length-1;i++){
    for(int j=i+1;j<results.length;j++){
      Motion a=results[i];
      Motion b=results[j];
      distTotal+=Math.sqrt(Math.pow(a.x-b.x,2)+Math.pow(a.theta-b.theta,2)+Math.pow(a.xDot-b.xDot,2)+Math.pow(a.thetaDot-b.thetaDot,2));//find distance between final positions in 4d phase space
    }
  }
  return distTotal;
}

System s=new System();
double initialEnergy;
  
PrintWriter output;

public void setup(){
  output = createWriter("positions.txt"); 
  
   for(double xDot0=-5;xDot0<5;xDot0+=0.1)
     for(double thetaDot0=-5; thetaDot0<5;thetaDot0+=0.1)
       for(double x0=-5; x0<5; x0+=0.1)
         for(double theta0=-5; theta0<5; theta0+=0.1){
             //println(thetaDot0);
           }
   
   size(1000,1000); 



   //noLoop();
   
 //initialEnergy=s.E();
 //for(double xDot0=2.5;xDot0<5;xDot0+=0.01){
 //for(double thetaDot0=2.5; thetaDot0<5; thetaDot0+=0.01){
 //  output.println(xDot0+", "+thetaDot0+", "+chaosTest(0,0,xDot0,thetaDot0,0.0005));
 //  println(xDot0+", "+thetaDot0);
 //}
 
 //}
   output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    
    s.mot.xDot=10;
    s.mot.thetaDot=-20;
    frameRate(100);
}


public void draw(){
  strokeWeight(10);
  background(255);
  s.drawFunc();
  s.drawPendulum();
  fill(0);
  text((float)s.time, width/2, height/10);
  //while(time*3000<System.currentTimeMillis()-start){
  
  for(int i=0;i<1;i++){
    //euler();
    //print(xDDot+f(s).xDDot+" ");
    s.rk4();
    
    //println(xDDot);
    //println(xDDot);
    if(Double.isNaN(s.E()))exit();
  }
  //println(E());
  //println((E()-initialEnergy)/E()*100+"%");
  saveFrame();
  
    
}
