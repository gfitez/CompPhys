public class Integrator {
    final double a=0.1;
    final double b=1;
    public double f(double x){
        return Math.sin(1/x);
        //return Math.pow(Math.sin(Math.sqrt(100*x)),2);
    }
    public double riemannSum(int n){
        double h=(b-a)/n;
        double sum=0;
        for(int i=0;i<n;i++){
            double pos=a+h/2+h*i;//midpoint riemann sum
            sum+=f(pos)*h;
        }
        return sum;
    }
    public double trapezoidalSum(int n){
        double h=(b-a)/n;
        double sum=0;
        double left=f(a);

        for(int i=0;i<=n;i++){
            double right=f(a+h*i);
            sum+=(left+right)/2*h;
            left=right;
        }
        return sum;
    }
    public double adaptiveTrapezoidalSum(int times){
        int n=1;
        double sum=trapezoidalSum(n);
        for(int i=0;i<times;i++){
            n*=2;
            double h=(b-a)/n;
            double newSum=0;
            for(int j=0;j<n;j++)
                if(j%2==1)newSum+=f(a+j*h);
            sum=newSum*h+sum/2;
        }
        return sum;

    }
    public double romberg(int times){
        int n=1;
        double[] layer=new double[]{trapezoidalSum(n)};
        for(int i=1;i<times;i++){
            n*=2;
            double[] newLayer=new double[layer.length+1];
            newLayer[0]=trapezoidalSum(n);
            for(int m=1;m<newLayer.length;m++){
                newLayer[m]=newLayer[m-1]+1/(Math.pow(4,m)-1)*(newLayer[m-1]-layer[m-1]);
            }
            layer=newLayer;
        }
        return layer[layer.length-1];
    }
    public double gaussianQuadrature(int n){
        //this is disgusting...
        double[] x=new X().roots[n];
        double[] w=new W().roots[n];

        double[] xp=new double[x.length];
        double[] wp=new double[w.length];
        for(int i=0;i<x.length;i++){
            xp[i]=(b-a)/2*x[i]+(a+b)/2;
            wp[i]=(b-a)/2*w[i];

        }
        double sum=0;
        for(int i=0;i<n;i++){
            sum+=wp[i]*f(xp[i]);
        }
        return sum;

    }
    public double secondDerivative(double x){
        double h=0.000001;
        return (f(x+h)-2*f(x)+f(x-h))/(h*h);
    }
    public double adaptiveAdaptiveTrapezoidal(double error){
        return computeSlice(a,b,error);
    }
    private double computeSlice(double a, double b, double maxError){
        double oneSlice=(f(a)+f(b))/2*(b-a);
        double twoSlice=(f(a)+2*f(a+(b-a)/2)+f(b))/4*(b-a);
        double error=1.0/3*(twoSlice-oneSlice);
        if(Math.abs(error)<maxError*(b-a)/(this.b-this.a))return twoSlice;
        else return computeSlice(a,a+(b-a)/2,maxError)+computeSlice(a+(b-a)/2,b,maxError);

    }

}
