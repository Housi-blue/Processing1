import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

VerletPhysics2D physics;

ArrayList clusters;

boolean showPhysics=true;
boolean showParticles=true;

PFont f;

void setup(){
  size(640,360);
  f=createFont("Geogia",12,true);
  
  physics=new VerletPhysics2D();
  physics.setWorldBounds(new Rect(10,10,width-20,height-20));
  
  newGraph();
}

void newGraph(){
  physics.clear();
  
  clusters=new ArrayList();
  
  for(int i=0; i<8; i++){
    Vec2D center=new Vec2D(width/2,height/2);
    clusters.add(new Cluster((int) random(3,8),random(20,100),center));
  }
  
  for(int i=0; i<clusters.size(); i++){
    for(int j=i+1; j<clusters.size(); j++){
      Cluster ci=(Cluster) clusters.get(i);
      Cluster cj=(Cluster) clusters.get(j);
      ci.connect(cj);
    }
  }
}

void draw(){
  physics.update();
  
  background(255);
  
  if(showParticles){
    for(int i=0; i<clusters.size(); i++){
      Cluster c=(Cluster) clusters.get(i);
      c.display();
    }
  }
  
  if(showPhysics){
    for(int i=0; i<clusters.size(); i++){
      Cluster ci=(Cluster) clusters.get(i);
      ci.showConnections();
      
      for(int j=i+1; j<clusters.size(); j++){
        Cluster cj=(Cluster) clusters.get(j);
        ci.showConnections(cj);
      }
    }
  }
  
  fill(0);
  textFont(f);
  text("'p' to display or hide particles\n'c' to display or hide connections\n'n' for new graph",10,20);
}

void keyPressed(){
  if(key=='c'){
    showPhysics=!showPhysics;
    if(!showPhysics) showParticles=true;
  } 
  else if(key=='p'){
    showParticles=!showParticles;
    if(!showParticles) showPhysics=true;
  } 
  else if(key=='n'){
    newGraph();
  }
}
