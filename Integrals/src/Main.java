public class Main {
    public static void main(String[] args) {
        Integrator i=new Integrator();
        System.out.println(i.riemannSum(10));
        System.out.println(i.trapezoidalSum(10));
        System.out.println(i.adaptiveTrapezoidalSum(1));
        System.out.println(i.romberg(1));

    }
}
