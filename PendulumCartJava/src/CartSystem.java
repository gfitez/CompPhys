public class CartSystem{
    Motion mot;
    final double l=1;//length of Pendulum
    final double M=1;//weight of upper mass
    final double m=1;//weight of lower Mass
    final double g=9.8;//acceleration due to gravity
    final double h=0.01;//delta time
    double time=0;
    public CartSystem(){
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
}