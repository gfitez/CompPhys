
import java.io.IOException;

public class Main {
    public static final int threads =  10*10;
    public static void main(String[] args) throws IOException{


        ChaosTestRange c1 = new ChaosTestRange(new Motion(-0.5, 3.1, 0, 3.7), new Motion(0.5, 3.9, 0, 4.7), 0.0025*4);
        c1.run();


    }
}
