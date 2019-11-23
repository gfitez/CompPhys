 
//x, xDot, theta, thetaDot, chaos
String[] lines;
float[][] data;

final float xDotMin=3.1;
final float xDotMax=3.9;
final float thetaDotMin=3.7;
final float thetaDotMax=4.7;
final float xMin=-0.5;
final float xMax=0.5;
final float resolution=0.01;
float chaosMax=0;

final float xDotLen=(xDotMax-xDotMin)/resolution+1;
final float thetaDotLen=(thetaDotMax-thetaDotMin)/resolution+1;




public float mapXDot(float xDot){
  return map(xDot,xDotMin,xDotMax,0,width);
}
public float mapThetaDot(float thetaDot){
  return map(thetaDot,thetaDotMin,thetaDotMax,0,height);
}
public float[][] getXLines(float x){
  float[][] lines=new float[(int)(xDotLen*thetaDotLen)][];

  int linesI=0;
  for(int i=0;i<data.length;i++){
    if(abs(data[i][0]-x)<resolution/10){
      lines[linesI]=data[i];
      linesI++;
    }
  }
  return lines;
}
public void displayFrame(float x){
  float[][] lines=getXLines(x);
  colorMode(HSB,255);
  for(int i=0;i<lines.length;i++){
    noStroke();
    fill(map(lines[i][4],0,chaosMax,50,255),255,255,50);
    rect(mapXDot(lines[i][1])-5,mapThetaDot(lines[i][3])-5,20,20);
  }
}
//for(float x=-0.5; x<=0.5;x+=0.01){
  
//       displayFrame(x);
//}
void setup(){
  lines = loadStrings("-0.5 0.0 3.1 3.7.txt");
  data=new float[lines.length][];
  
  for (int i = 0 ; i < lines.length; i++) {
    data[i]=new float[5];
    String[] temp=lines[i].split(" ");
    for(int j=0;j<temp.length;j++){
      data[i][j]=(float)(Float.valueOf(temp[j]));
      
    }
    data[i][4]=(data[i][4]);
    chaosMax=max(data[i][4],chaosMax);
  }
  //size((int)((xDotMax-xDotMin)/resolution), (int)((thetaDotMax-thetaDotMin)/resolution));
  //size((int)(xDotLen*10),(int)(thetaDotLen*10));
  size(800,1000);
  frameRate(10);
}
float x=-0.5;
void draw(){
  background(255);
  x+=resolution;
  displayFrame(x); 
  
  println(x);
  fill(0,0,0);
  textSize(30);
  text(("x="+(int)(x*10000)/10000.0),10,30);
  saveFrame();
  if(x>=xMax-resolution/2)exit();
}
