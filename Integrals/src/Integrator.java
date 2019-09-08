public class Integrator {
    final double a=0;
    final double b=1;
    public int samples;
    public double f(double x){
        samples++;
        return Math.pow(Math.sin(Math.sqrt(100*x)),2);
        //answer =
    }
    public double answer=0.4558325323090851;//1/400-(20*sin(20)+cos(20)-200)/400
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

}
