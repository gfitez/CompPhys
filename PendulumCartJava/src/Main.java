
import java.io.IOException;

public class Main {
    public static final int threads =  10*10;
    public static void main(String[] args) throws IOException{


        ChaosTestRange c1 = new ChaosTestRange(new Motion(1.0/3, -25, 0, -25), new Motion(2.5, 25, 0, 25), 0.0025*4*100);
        c1.run();




    }
}
