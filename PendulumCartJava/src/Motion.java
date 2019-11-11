public class Motion{
    double x, xDot;
    double theta, thetaDot;
    public Motion(){}
    public Motion(Motion m){
        add(m);
    }
    public Motion(double x,double xDot,double theta,double thetaDot){
        this.x=x;
        this.xDot=xDot;
        this.thetaDot=thetaDot;
        this.theta=theta;
    }
    public String toString(){
        return "{x:"+x+" theta:"+theta+" xDot:"+xDot+" thetaDot:"+thetaDot+"}";
    }
    public Motion mult(double h){
        Motion m=new Motion();
        m.x=this.x*h;
        m.xDot=this.xDot*h;

        m.theta=this.theta*h;
        m.thetaDot=this.thetaDot*h;

        return m;
    }
    public Motion add(Motion m){
        Motion newMot=new Motion();
        newMot.x=this.x+m.x;
        newMot.xDot=this.xDot+m.xDot;

        newMot.theta=this.theta+m.theta;
        newMot.thetaDot=this.thetaDot+m.thetaDot;

        return newMot;
    }

}