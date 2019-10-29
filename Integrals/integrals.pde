float a=0;
float b=1;
public float y(float x){
    return (float)Math.pow(Math.sin(Math.sqrt(100*x)),2);
}
public float trapezoidArea(float x, float h){
  return (y(x)+y(x+h))*h/2;
}
public float trapezoidalSum(int n){
  float h=(b-a)/n;
  float sum=0;
  for(int i=0;i<n;i++){
    sum+=trapezoidArea(a+h*i,h);
  }
  return sum;
}

public float adaptiveTrapezoidalSum(float accuracy){
  int n=2;
  float sum=trapezoidalSum(n);
  for(int i=0;i<10;i++){
     n*=2;
     float h=(b-a)/n;
     float newSum=0;
     for(int j=0;j<n;j++){
       if(j%2==1){
         newSum+=y(a+j*h);
       }
     }
     
     sum=newSum*h+0.5*sum;
     //println(sum);
     
  }
  return sum;
}
public float romberg(float accuracy){
  int n=2;
  float[] layer=new float[]{trapezoidalSum(n)};
  for(int i=1;i<10;i++){
    n*=2;
    float[] newLayer=new float[layer.length+1];
    newLayer[0]=trapezoidalSum(n);
    for(int m=1;m<newLayer.length;m++){
      //this is a little messy because i have to subtract 1 from m when indexing but not when using 
      newLayer[m]=newLayer[m-1]+1/((float)Math.pow(4,m)-1)*(newLayer[m-1]-layer[m-1]);
      
    }
    layer=newLayer;
  }
  return layer[layer.length-1];
}
void setup(){
  println(trapezoidalSum(32));
  println(romberg(100));
}
