public class ChaosTest {
    Motion m;
    final boolean runX=false;
    final boolean runTheta=false;
    final boolean runXDot=true;
    final boolean runThetaDot=true;
    final double range=0.000001;
    int trials;
    public ChaosTest(Motion m){
        this.m=m;
        trials=1;
        if(runX)trials*=2;
        if(runXDot)trials*=2;
        if(runTheta)trials*=2;
        if(runThetaDot)trials*=2;
    }
    public double run(){
        Motion[] results=new Motion[trials];

        double[] x;
            if(runX)x=new double[]{m.x-range/2,m.x+range/2};else x=new double[]{m.x};
        double[] xDot;
            if(runXDot)xDot=new double[]{m.xDot-range/2,m.xDot+range/2};else xDot=new double[]{m.xDot};
        double[] theta;
            if(runTheta)theta=new double[]{m.theta-range/2,m.theta+range/2};else theta=new double[]{m.theta};
        double[] thetaDot;
            if(runThetaDot)thetaDot=new double[]{m.thetaDot-range/2,m.thetaDot+range/2};else thetaDot=new double[]{m.thetaDot};


        int index=0;
        for(double x0 : x)
            for(double xDot0 : xDot)
                for(double theta0 : theta)
                    for(double thetaDot0 : thetaDot) {
                        Motion mot = new Motion(x0, xDot0, theta0, thetaDot0);
                        Sys s=new Sys(mot);
                        results[index] = runSystem(s);
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
    public Motion runSystem(Sys s){
        while(s.time<s.period*5)s.rk4();
        return s.mot;
    }
}
