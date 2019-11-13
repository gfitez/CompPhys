
import java.io.IOException;

public class Main {
    public static final int threads =  10*10;
    public static void main(String[] args) throws IOException{


        ChaosTestRange c1 = new ChaosTestRange(new Motion(0.0, 2, 0, 2), new Motion(0.0, 5, 0, 5), 0.0025);
        c1.run();


    }
}
