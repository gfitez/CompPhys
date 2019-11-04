import java.io.FileNotFoundException;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class main {

    public void run() throws IOException {




        // If the file doesn't exists, create and write to it
        // If the file exists, truncate (remove all content) and write to it
        FileWriter writer = new FileWriter("app.tsv");
             BufferedWriter output = new BufferedWriter(writer);




        for(double xDot0=-5;xDot0<5;xDot0+=0.1)
            for(double thetaDot0=-5; thetaDot0<5;thetaDot0+=0.1)
                for(double x0=-5; x0<5; x0+=0.1)
                    for(double theta0=-5; theta0<5; theta0+=0.1){
                        //println(thetaDot0);
                    }



        for(double xDot0=-10;xDot0<10;xDot0+=0.025){
            for(double thetaDot0=-10; thetaDot0<10; thetaDot0+=0.025){
                output.write(xDot0+", "+thetaDot0+", "+chaosTest(0,0,xDot0,thetaDot0)+"\n");

                System.out.println(xDot0+", "+thetaDot0);

            }
            output.flush();

        }
        output.flush(); // Writes the remaining data to the file
        output.close(); // Finishes the file

    }
    public double chaosTest(double x, double theta, double xDot, double thetaDot){//measure how chaotic a certain area of the system is in 4d space (x,theta,xDot,thetaDot)
        double range=0.000001;//difference between sample points
        Motion[] results=new Motion[16];
        int index=0;
        for(double x0=x-range/2; x0<=x+range/2+range/10; x0+=range)
            for(double theta0=theta-range/2; theta0<=theta+range/2+range/10; theta0+=range)
                for(double xDot0=xDot-range/2; xDot0<=xDot+range/2+range/10; xDot0+=range)
                    for(double thetaDot0=thetaDot-range/2; thetaDot0<=thetaDot+range/2+range/10; thetaDot0+=range){
                        CartSystem s=new CartSystem();
                        s.mot.x=x0;
                        s.mot.theta=theta0;
                        s.mot.xDot=xDot0;
                        s.mot.thetaDot=thetaDot0;
                        while(s.time<2){s.rk4();}//run system for certain amount of time
                        results[index]=s.mot;
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
}
