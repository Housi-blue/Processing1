class Cluster{
  
  ArrayList nodes;
  
  float diameter;
  
  Cluster(int n,float d,Vec2D center){
    
    nodes=new ArrayList();
    
    diameter=d;
    
    for(int i=0; i<n; i++){
      nodes.add(new Node(center.add(Vec2D.randomVector())));
    }
    
    for(int i=1; i<nodes.size(); i++){
      VerletParticle2D pi=(VerletParticle2D) nodes.get(i);
      for(int j=0; j<i; j++){
        VerletParticle2D pj=(VerletParticle2D) nodes.get(j);
      
        physics.addSpring(new VerletSpring2D(pi,pj,diameter,0.01));
      }
    }
  }
  
  void display(){
    for(int i=0; i<nodes.size(); i++){
      Node n=(Node) nodes.get(i);
      n.display();
    }
  }
  
  void connect(Cluster other){
    ArrayList otherNodes=other.getNodes();
    for(int i=0; i<nodes.size(); i++){
      VerletParticle2D pi=(VerletParticle2D) nodes.get(i);
      for(int j=0; j<otherNodes.size(); j++){
        VerletParticle2D pj=(VerletParticle2D) otherNodes.get(j);
      
       physics.addSpring(new VerletMinDistanceSpring2D(pi,pj,(diameter+other.diameter)*0.5,0.05));
      }
    }
  }
  
  void showConnections(){
    stroke(0,150);
    for(int i=0; i<nodes.size(); i++){
      VerletParticle2D pi=(VerletParticle2D) nodes.get(i);
      for(int j=i+1; j<nodes.size(); j++){
        VerletParticle2D pj=(VerletParticle2D) nodes.get(j);
        
        line(pi.x,pi.y,pj.x,pj.y);
      }
    }
  }
  
  void showConnections(Cluster other){
    stroke(0,50);
    strokeWeight(2);
    ArrayList otherNodes=other.getNodes();
    for(int i=0; i<nodes.size(); i++){
      VerletParticle2D pi=(VerletParticle2D) nodes.get(i);
      for(int j=0; j<otherNodes.size(); j++){
        VerletParticle2D pj=(VerletParticle2D) otherNodes.get(j);
        
        line(pi.x,pi.y,pj.x,pj.y);
      }
    }
  }
  
  ArrayList getNodes(){
    return nodes;
  }
}
      
      
