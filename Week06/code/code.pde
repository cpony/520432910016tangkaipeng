boolean playing=true;
PVector mouse;
Particle[]pts;
void setup(){  
 size(1280,720,P2D);

 pts=new Particle[10000];

 for(int i=0;i<pts.length;i++){
  pts[i]=new Particle();

 }
 mouse=new PVector(0,0);

}

int index=0;

void draw(){

 fill(0,20);

 stroke(0);

 rect(0,0,width,height);
 mouse.set(mouseX,mouseY);
 for(int i=0;i<pts.length;i++){
  pts[i].update();

 }
 index++;
 //saveFrame("E:/a/" +"0"+ index + ".png");
}

void keyPressed() {

 if (key==' ') {

  playing=!playing;

 }

 if (playing) {
  loop();
 } else {
  noLoop();
 }
 if (key=='r'||key=='R') {
  background(255);
 }

}
class Particle{

 PVector prevPos;

 PVector pos;

 PVector vel;  

 float factor=random(0.3, 1.5);  

 color col;

 Particle(){   

  pos=new PVector(random(width),random(height));

  prevPos=pos.copy();   

  vel=new PVector(0,0);

  col=color(random(88+cos(frameCount)*100),random(234+cos(frameCount)*100),255,30);

 }

 

 void update(){   

  col=color((102+100*cos(frameCount*0.03)),(200+50*cos(frameCount*0.03)),255,50+50*cos(frameCount*0.015));
  float d2m = PVector.dist(pos,mouse);

  d2m*=0.01;

 PVector dist_acc=PVector.sub(mouse,pos);//弹力加速度
    dist_acc.mult(factor*0.001);      //每个粒子弹力系数不同
    vel.add(dist_acc);  
        
    float noise_x=noise(pos.x*0.05,pos.y*0.05,frameCount*0.01)-0.5;
    float noise_y=noise(pos.x*0.05,pos.y*0.05+9999,frameCount*0.01)-0.5;
    PVector noise_acc=new PVector(noise_x,noise_y);    
    noise_acc.mult(1.8);    //noise 加速度
    vel.add(noise_acc);
    vel.mult(0.94);
      
    prevPos=pos.copy();  //记录旧坐标，方便连线轨迹
    prevPos.add(PVector.div(vel,3));
    pos.add(vel);
     
    stroke(col); 
    line(pos.x,pos.y,prevPos.x,prevPos.y);    
 }

}

 
