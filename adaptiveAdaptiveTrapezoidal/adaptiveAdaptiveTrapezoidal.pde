final double a=0.025;
final double b=0.2;
final double yScale=50;
ArrayList<Double> samplePoints=new ArrayList<Double>();

double f(double x){
  return Math.sin(1/x); 
}
void drawFunction(){
  double pixel=(b-a)/width;
  beginShape();
  for(int i=0;i<width;i++){
    float x=(float)(a+i*pixel);  
    vertex(i,height/2-(float)(f(x)*yScale));
  }
  endShape();
}
void drawSamples(){
  float oldX=0;
  float oldY=height/2-(float)(f(0)*yScale);
  
  for(int i=1;i<samplePoints.size();i++){
    float x=(float)((samplePoints.get(i)-a)/(b-a)*width);  
    float y=height/2-(float)(f(samplePoints.get(i))*yScale);
    if(i%2==0)fill(255,0,0,30);
    else fill(0,0,255,30);
    noStroke();
    rect(oldX,0,x-oldX,height);
    stroke(0,255,0);
    //line(oldX,oldY,x,y);
    oldX=x;
    oldY=y;
  }
}

double adaptiveAdaptiveTrapezoidal(double error){
    return computeSlice(a,b,error);
}

double computeSlice(double a, double b, double maxError){
    double oneSlice=(f(a)+f(b))/2*(b-a);
    double twoSlice=(f(a)+2*f(a+(b-a)/2)+f(b))/4*(b-a);
    double error=1.0/3*(twoSlice-oneSlice);
    if(Math.abs(error)<maxError*(b-a)/(this.b-this.a)){
      samplePoints.add(b);
      return twoSlice;
    }
    else return computeSlice(a,a+(b-a)/2,maxError)+computeSlice(a+(b-a)/2,b,maxError);

}

void setup(){
  size(1000,500);
  noLoop();
}
void draw(){
  background(255);
 drawFunction(); 
 println(adaptiveAdaptiveTrapezoidal(0.0005));
 drawSamples();
}
