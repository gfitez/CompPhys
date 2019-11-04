public class Motion{
    double x, xDot, xDDot;
    double theta, thetaDot, thetaDDot;
    public Motion(){}
    public String toString(){
        return "{x:"+x+" theta:"+theta+" xDot:"+xDot+" thetaDot:"+thetaDot+"}";
    }

}