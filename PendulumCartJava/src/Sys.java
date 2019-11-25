public class Sys {
    Motion mot;
    final double l=1;//length of Pendulum
    double M=1;//weight of upper mass
    double m=1;//weight of lower Mass
    final double g=9.8;//acceleration due to gravity
    double h=0.01;//delta time
    double time=0;
    final double period=2*Math.PI*Math.sqrt(l/g);
    public int overTop=0;
    public Sys(){
        mot=new Motion();
    }
    public Sys(Motion m){
        mot=m;
    }

    public double f(double x){return 1-Math.cos(x);}
    public double f1(double x){return Math.sin(x);}//first derivative of f with respect to x
    public double f2(double x){return Math.cos(x);}//second derivative of f with respect to x

    public double PE(){//Potential Energy
        return M*g*f(mot.x)+m*g*f(mot.x)-m*g*l*Math.cos(mot.theta);
    }
    public double KE(){//Kinetic Energy
        return 0.5*(M+m)*mot.xDot*mot.xDot*(1+f1(mot.x)*f1(mot.x))+m*mot.xDot*l*mot.thetaDot*(Math.cos(mot.theta)+f1(mot.x)*Math.sin(mot.theta))+0.5*m*l*l*mot.thetaDot*mot.thetaDot;
    }
    public double E(){//Total energy
        return KE()+PE();
    }
    public Motion f(Motion motion){//return delta x, delta theta, delta x dot, and delta theta dot
        double x=motion.x;
        double xD=motion.xDot;


        double sinT=Math.sin(motion.theta);
        double cosT=Math.cos(motion.theta);
        double tD=motion.thetaDot;


        Motion newMot=new Motion();
        newMot.theta=motion.thetaDot;
        newMot.x=motion.xDot;

        newMot.xDot=(-2*(M+m)*xD*xD*f1(x)*f2(x)+m*g*sinT*cosT+m*xD*xD*f2(x)*sinT*cosT+m*l*tD*tD*sinT+m*g*f1(x)*sinT*sinT+m*xD*xD*f1(x)*f2(x)*sinT*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))/((M+m)*(1+f1(x)*f1(x))-m*cosT*cosT-m*f1(x)*sinT*cosT-m*f1(x)*cosT*sinT-m*f1(x)*f1(x)*sinT*sinT);
        newMot.thetaDot=(-g*sinT-(cosT+f1(x)*sinT)/((M+m)*(1+f1(x)*f1(x)))*(-2*(M+m)*xD*xD*f1(x)*f2(x)+m*l*tD*tD*sinT-m*l*tD*tD*f1(x)*cosT+(M+m)*xD*xD*f1(x)*f2(x)-M*g*f1(x)-m*g*f1(x))-xD*xD*f2(x)*sinT)/(l-m*l/((M+m)*(1+f1(x)*f1(x)))*(cosT*cosT+cosT*f1(x)*sinT+f1(x)*sinT*cosT+f1(x)*sinT*f1(x)*sinT));


        return newMot;
    }

    public void rk4(){//run iteration of fourth order runge-kutta
        Motion k1=f(mot).mult(h);
        Motion k2=f(k1.mult(0.5).add(mot)).mult(h);
        Motion k3=f(k2.mult(0.5).add(mot)).mult(h);
        Motion k4=f(mot.add(k3)).mult(h);

        double oldX=this.mot.x;
        double oldXDot=this.mot.xDot;
        this.mot=this.mot.add((k1.add(k2.mult(2)).add(k3.mult(2)).add(k4)).mult(1.0/6));
        double newX=this.mot.x;

        if((oldX-Math.PI)%(2*Math.PI)>(newX-Math.PI)%(2*Math.PI) && this.mot.xDot>0 && oldXDot>0)overTop++;
        else if((oldX-Math.PI)%(2*Math.PI)<(newX-Math.PI)%(2*Math.PI) && this.mot.xDot<0 && oldXDot<0)overTop++;

        time+=h;
    }
}
