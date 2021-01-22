//
//  pad.cpp
//  smalldrum
//
//  Created by Mac on 10/16/20.
//

#include "pad.hpp"
pad::pad(){
    
}
void pad::setup(){
    
      c1 = 10;
    
    radiusM=180;
    radiusP=200;
    //com=true;
    value = false;
    xMax = xPos+220;
    bMax = base+220;
    
    

    
    
}
void pad::update(){

 
    
    
    
}

void pad::draw(){
  // ofDrawBitmapString("on", xPos-10, base-40);
   ofFill();
   c1--;
  // dist = ofDist(xPos, base, ofGetMouseX(), ofGetMouseY());
    
 
    //( = ! )//
    //   &  //
    // <--> //
    //  ?   //
   
    
    if(ofGetMousePressed()==true){
       
        
        if(ofGetMouseX()>xPos && ofGetMouseX()<xPos+xMax && ofGetMouseY()>base && ofGetMouseY()< base + bMax){
            if(c1<0){
            value=true;
            cout << "printing"<<endl;
            cout << value <<endl;
            c1 = 10;
           
            }}

    } else {value=false;}
      
   
    
    if (value == true){
           ofPushMatrix();
           ofSetColor(255, 255, 255);
          
           ofDrawRectRounded(xPos, base, xMax, bMax, 12);
        
           ofPopMatrix();
           
           
    }
       
       if (value == false){
           
           ofPushMatrix();
           ofSetColor(0, 0, 0);
          
           ofDrawRectRounded(xPos, base, xMax, bMax, 12);
         //  ofDrawBitmapString("off", xPos-10, base-20);
           ofPopMatrix();
             
    }
    
    
  
   
   
   


}


