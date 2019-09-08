public class Main {
    public static void main(String[] args) {
        Integrator i=new Integrator();
        System.out.println(i.riemannSum(100));
        System.out.println(i.trapezoidalSum(100));
        System.out.println(i.adaptiveTrapezoidalSum(10));
        System.out.println(i.romberg(10));
        System.out.println(i.gaussianQuadrature(64));
        System.out.println(i.answer);
    }
}
