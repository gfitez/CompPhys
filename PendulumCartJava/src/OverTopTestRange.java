import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class OverTopTestRange /**extends Thread**/ {
    Motion min, max;
    double step;
    boolean runX, runXDot, runTheta, runThetaDot;
    public OverTopTestRange(Motion min, Motion max, double step){
        this.min=min;
        this.max=max;
        this.step=step;

        runX=(min.x-max.x)>step;
        runXDot=(min.xDot-max.xDot)>step;
        runTheta=(min.theta-max.theta)>step;
        runThetaDot=(min.thetaDot-max.thetaDot)>step;
    }
    public void run(){
        try {
            BufferedWriter bw;

            File file = new File("top "+min.x + " " + min.theta + " " + min.xDot + " " + min.thetaDot + ".txt");

            if (!file.exists()) {
                file.createNewFile();
            }

            FileWriter fw = new FileWriter(file);
            bw = new BufferedWriter(fw);



            for (double xDot0 = min.xDot; xDot0 < max.xDot + step / 2; xDot0 += step) {
                for (double thetaDot0 = min.thetaDot; thetaDot0 < max.thetaDot + step / 2; thetaDot0 += step) {
                    for (double x0 = min.x; x0 < max.x + step / 2; x0 += step) {

                        for (double theta0 = min.theta; theta0 < max.theta + step / 2; theta0 += step) {
                            //OverTopTest c = new OverTopTest(new Motion(x0, xDot0, theta0, thetaDot0));
                            Sys s=new Sys(new Motion(x0,xDot0,theta0,thetaDot0));
                            while(s.time<s.period*5)s.rk4();

                            bw.write(x0 + " " + xDot0 + " " + theta0 + " " + thetaDot0 + " " + s.overTop + "\n");
                        }


                    }

                }
                bw.flush();
                System.out.println(xDot0);
            }

        }catch( IOException e){
            System.out.println(e);
        }
    }
}
