final double g=9.8;
final float scale=250;

double time=0;


class DPMotion{
  double theta1, omega1, theta2, omega2;
  public DPMotion(double theta1, double omega1, double theta2, double omega2){
    this.theta1=theta1;
    this.omega1=omega1;
    this.theta2=theta2;
    this.omega2=omega2;
  }
}
public DPMotion add(DPMotion m1, DPMotion m2){
  return new DPMotion(m1.theta1+m2.theta1, m1.omega1+m2.omega1, m1.theta2+m2.theta2, m1.omega2+m2.omega2);
}
public DPMotion mult(DPMotion m, double h){
  return new DPMotion(m.theta1*h, m.omega1*h, m.theta2*h, m.omega2*h);
}


class HistoryPoint{
  float x,y;
  color c;
  public HistoryPoint(float x,float y,color c){
    this.x=x;
    this.y=y;
    this.c=c;
  }
}

class DoublePendulum{
  double x,y;
  DPMotion m;
  double r1, r2;
  double mass1, mass2;
  float vMax;
  ArrayList<HistoryPoint> history;
  public DoublePendulum(double x, double y){
    this.x=x; this.y=y;
    r1=0.3; r2=r1;
    mass1=10; mass2=10;
    m=new DPMotion(-PI+0.0001,0,PI/8,0);
    history=new ArrayList<HistoryPoint>();
  }
  public void draw(){
    drawHistory();
    
    float p1x=(float)(x+r1*cos((float)m.theta1+PI/2));
    float p1y=(float)(y+r1*sin((float)m.theta1+PI/2));
    
    float p2x=(float)(p1x+r2*cos((float)m.theta2+PI/2));
    float p2y=(float)(p1y+r2*sin((float)m.theta2+PI/2));
    
    stroke(0);
    fill(0);
    strokeWeight(0.01);
    
    pushMatrix();
    //translate((float)x,(float)y);
    scale(scale);

    
    line((float)x,(float)y,p1x,p1y);
    circle(p1x,p1y,0.05);
    line(p1x,p1y,p2x,p2y);
    circle(p2x,p2y,0.05);
    popMatrix();
    
  }
  public DPMotion f(DPMotion m){
    double dtheta1=m.omega1;
    double dtheta2=m.omega2;
    
    //double numerator=-g*(2*mass1+mass2)*Math.sin(m.theta1)-mass2*g*
    //Math.sin(m.theta1-2*m.theta2)-2*Math.sin(m.theta1-m.theta2)*mass2*
    //(Math.pow(m.omega2,2)*r2+Math.pow(m.omega1,2)*r1*Math.cos(m.theta1-m.theta2));
    //double dalpha1=numerator/(r1*(2*mass1+mass2-mass2*Math.cos(2*m.theta1-2*m.theta2)));
    
    //numerator=2*Math.sin(m.theta1-m.theta2)*(Math.pow(m.omega1,2)*r1*(mass1+mass2)
    //+g*(mass1+mass2)*Math.cos(m.theta1)+Math.pow(m.omega2,2)*r2*mass2*
    //Math.cos(m.theta1-m.theta2));
    //double dalpha2=numerator/(r2*(2*mass1+mass2-mass2*Math.cos(2*m.theta1-2*m.theta2)));
    double numerator=-g*(2*mass1+mass2)*Math.sin(m.theta1)-mass2*g*Math.sin(m.theta1-2*m.theta2)-2*Math.sin(m.theta1-m.theta2)*mass2*(Math.pow(m.omega2,2)*r2+Math.pow(m.omega1,2)*r1*Math.cos(m.theta1-m.theta2));
    double domega1=numerator/(r1*(2*mass1+mass2-mass2*Math.cos(2*m.theta1-2*m.theta2)));
    
    numerator=2*Math.sin(m.theta1-m.theta2)*(Math.pow(m.omega1,2)*r1*(mass1+mass2)+g*(mass1+mass2)*Math.cos(m.theta1)+Math.pow(m.omega2,2)*r2*mass2*Math.cos(m.theta1-m.theta2));
    double domega2=numerator/(r2*(2*mass1+mass2-mass2*Math.cos(2*m.theta1-2*m.theta2)));
    
    return new DPMotion(dtheta1, domega1, dtheta2, domega2);
  }
  public void euler(){
    double h=0.001;
    m=add(this.m, mult(f(this.m),h));
    time+=h;
  }
  public void rk4(){
    double h=0.001;//0.0007;
    DPMotion k1=mult(f(m),h);
    DPMotion k2=mult(f(add(m,mult(k1,0.5))),h);
    DPMotion k3=mult(f(add(m,mult(k2,0.5))),h);
    DPMotion k4=mult(f(add(m,k3)),h);
  
    m= add(m, mult(add(add(add(k1,mult(k2,2)),mult(k3,2)),k4),1.0/6));
    
    time+=h;
    
    if((time/5)%h<0.0001)addHistoryPoint();
    
  }
  public void addHistoryPoint(){
    
    colorMode(HSB,255);
    double vt=Math.sqrt(Math.pow(Math.cos(m.theta1)*m.omega1*r1+Math.cos(m.theta2)*m.omega2*r1,2)+Math.pow(Math.sin(m.theta1)*m.omega1*r1+Math.sin(m.theta2)*m.omega2*r2,2));
    vMax=max((float)vt,vMax);
    int c=color(map(abs((float)vt),0,5,255,0),255,255);
    
    float p1x=(float)(x+r1*cos((float)m.theta1+PI/2));
    float p1y=(float)(y+r1*sin((float)m.theta1+PI/2));
    float p2x=(float)(p1x+r2*cos((float)m.theta2+PI/2));
    float p2y=(float)(p1y+r2*sin((float)m.theta2+PI/2));
    
    history.add(new HistoryPoint((float)p2x,(float)p2y,c));
    colorMode(RGB,255);
    if(history.size()>300)history.remove(0);
    
  }
  public void drawHistory(){
    
    pushMatrix();
    scale(scale);
    strokeWeight(0.01);
    for(int i=1;i<history.size();i+=1){
      stroke(history.get(i).c,i);
      line(history.get(i-1).x,history.get(i-1).y,history.get(i).x,history.get(i).y);
    }
    popMatrix();
    
  }
  public double KE(){
    //http://scienceworld.wolfram.com/physics/DoublePendulum.html
    //return 0.5*((mass1+mass2)*Math.pow(r1,2)*Math.pow(m.omega1,2)+2*r1*r2*Math.cos(m.theta1-m.theta2)*m.omega1*m.omega2+mass2*Math.pow(r2,2)*Math.pow(m.omega2,2));

    return 0.5*mass1*Math.pow(r1,2)*Math.pow(m.omega1,2)+0.5*mass2*(Math.pow(r1,2)*Math.pow(m.omega1,2)+Math.pow(r2,2)*Math.pow(m.omega2,2)+2*r1*r2*m.omega1*m.omega2*Math.cos(m.theta1-m.theta2));
  }
  public double PE(){
    double p1y=y+r1*Math.sin(m.theta1+PI/2);
   
    double p2y=p1y+r2*Math.sin(m.theta2+PI/2);
    
    return mass1*(y-p1y)*g+mass2*(y-p2y)*g;
  }
  public double E(){
    return KE()+PE();
  }
  
}

int n=3;
DoublePendulum[] dps;

void setup(){
  size(1000,1000);
  strokeWeight(0.002);
  frameRate(100000);
  dps=new DoublePendulum[n*n];
  for(int i=0;i<n;i++){
    for(int j=0;j<n;j++){
      dps[j*n+i]=new DoublePendulum(0.6+i*1.4,0.4+j*1.4);
      dps[j*n+i].m.theta1+=(j*n+i)*0.0001*0;
    }
  }

}
int i=0;
void draw(){
  background(255);
  for(DoublePendulum dp : dps){
    dp.draw();
    for(int i=0;i<10;i++)dp.rk4();
  }
  
  //saveFrame("frames/#######.png");
  text(Double.toString(dps[0].E()),10,10);
  i++;
  println(i);
  
}
