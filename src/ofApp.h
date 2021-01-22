/*
 * Copyright (c) 2011 Dan Wilcox <danomatika@gmail.com>
 *
 * BSD Simplified License.
 * For information on usage and redistribution, and for a DISCLAIMER OF ALL
 * WARRANTIES, see the file, "LICENSE.txt," in this distribution.
 *
 * See https://github.com/danomatika/ofxPd for documentation
 *
 */
#pragma once

#include "ofMain.h"

#include "ofxPd.h"
#include "Slider.h"
#include "toggle.h"
#include "knob.h"
#include "xy.h"
#include "pad.hpp"


// a namespace for the Pd types
using namespace pd;

// inherit pd receivers to receive message and midi events
class ofApp : public ofBaseApp, public PdReceiver, public PdMidiReceiver{

    public:

        // main
        void setup();
        void update();
        void draw();
        void exit();

        // do something
        void playTone(int pitch);
        
        // input callbacks
        void keyPressed(int key);
        
        // audio callbacks
        void audioReceived(float * input, int bufferSize, int nChannels);
        void audioRequested(float * output, int bufferSize, int nChannels);
        
        // pd message receiver callbacks
        void print(const std::string& message);
        
        void receiveBang(const std::string& dest);
        void receiveFloat(const std::string& dest, float value);
        void receiveSymbol(const std::string& dest, const std::string& symbol);
        void receiveList(const std::string& dest, const List& list);
        void receiveMessage(const std::string& dest, const std::string& msg, const List& list);
        
        // pd midi receiver callbacks
        void receiveNoteOn(const int channel, const int pitch, const int velocity);
        void receiveControlChange(const int channel, const int controller, const int value);
        void receiveProgramChange(const int channel, const int value);
        void receivePitchBend(const int channel, const int value);
        void receiveAftertouch(const int channel, const int value);
        void receivePolyAftertouch(const int channel, const int pitch, const int value);
    
        void receiveMidiByte(const int port, const int byte);
        
        ofxPd pd;
        vector<float> scopeArray;
        vector<Patch> instances;
        vector<float> array1, array2, array3, array4;
        
        int midiChan;
        float t, val, size;
        int c;
        float filtermap, chord1, chord2, chord3, chord4, bass1, bass2, bass3, bass4, bass5, bass6, bass7;
        float drum1, drum2, drum3, drum4, drum5, drum6, drum7, drum8, rando;
        
       
        int timerA;
        int timerB;
        int timerC;
        int channel;
        
        int note,chan,vel, p;
        bool yep;
        knob knobA, knobB, knobC, knobD, knobE, knobF;
        
        ofImage bg; 
       
     
        toggle toggleA, toggleB, toggleC, toggleD, toggleE, toggleF, hatA, hatB, hatC;
       // knob knobA, knobB, knobC, knobD;
   
       // ofShader shader;
    
   
   // Slider slideA, slideB, slideC, slideD, slideE;
    pad padA,padB;
    
    
};



