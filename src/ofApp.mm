
#include "ofApp.h"
#include "ofMath.h"





void ofApp::setup() {
    bg.load("2.png");
    
    ofSetCircleResolution(100);
    ofSetOrientation(OF_ORIENTATION_DEFAULT);
   
    channel=1;


    ofSetFrameRate(60);
    ofSetVerticalSync(true);
    knobA.setup();
    knobB.setup();
    knobC.setup();
    knobD.setup();
    knobE.setup();
    knobF.setup();

    toggleA.setup();
    toggleB.setup();
    toggleC.setup();
    toggleD.setup();
    toggleE.setup();
    toggleF.setup();
    hatA.setup();
    hatB.setup();
    hatC.setup();
  
    
    
    padA.setup();
   

 
       
    
 
    c=10;
    

   
    //ofSetLogLevel("Pd", OF_LOG_VERBOSE); // see verbose info inside

    // double check where we are ...
    cout << ofFilePath::getCurrentWorkingDirectory() << endl;

    // the number of libpd ticks per buffer,
    // used to compute the audio buffer len: tpb * blocksize (always 64)
    #ifdef TARGET_LINUX_ARM
        // longer latency for Raspberry PI
        int ticksPerBuffer = 32; // 32 * 64 = buffer len of 2048
        int numInputs = 0; // no built in mic
    #else
        int ticksPerBuffer = 8; // 8 * 64 = buffer len of 512
        int numInputs = 1;
    #endif

    // setup OF sound stream
    ofSoundStreamSettings settings;
    settings.numInputChannels = 2;
    settings.numOutputChannels = 2;
    settings.sampleRate = 44100;
    settings.bufferSize = ofxPd::blockSize() * ticksPerBuffer;
    settings.setInListener(this);
    settings.setOutListener(this);
    ofSoundStreamSetup(settings);

    // setup Pd
    //
    // set 4th arg to true for queued message passing using an internal ringbuffer,
    // this is useful if you need to control where and when the message callbacks
    // happen (ie. within a GUI thread)
    //
    // note: you won't see any message prints until update() is called since
    // the queued messages are processed there, this is normal
    //
    if(!pd.init(2, numInputs, 44100, ticksPerBuffer, false)) {
        OF_EXIT_APP(1);
    }

    midiChan = 1; // midi channels are 1-16

    // subscribe to receive source names
    pd.subscribe("toOF");
    pd.subscribe("env");

    // add message receiver, required if you want to recieve messages
    pd.addReceiver(*this); // automatically receives from all subscribed sources
    pd.ignoreSource(*this, "env");        // don't receive from "env"
    //pd.ignoreSource(*this);             // ignore all sources
    //pd.receiveSource(*this, "toOF");      // receive only from "toOF"

    // add midi receiver, required if you want to recieve midi messages
    pd.addMidiReceiver(*this); // automatically receives from all channels
    //pd.ignoreMidiChannel(*this, 1);     // ignore midi channel 1
    //pd.ignoreMidiChannel(*this);        // ignore all channels
    //pd.receiveMidiChannel(*this, 1);    // receive only from channel 1

    // add the data/pd folder to the search path
    pd.addToSearchPath("pd/abs");

    // audio processing on
    pd.start();

    // -----------------------------------------------------
    cout << endl << "BEGIN Patch Test" << endl;

    // open patch
    Patch patch = pd.openPatch("pd/gennifer.pd");
    cout << patch << endl;

    // close patch
    pd.closePatch(patch);
    cout << patch << endl;

    // open patch again
    patch = pd.openPatch(patch);
    cout << patch << endl;
    
 
    
  
}

//--------------------------------------------------------------

void ofApp::update() {
    

    
     

    // since this is a test and we don't know if init() was called with
    // queued = true or not, we check it here
    if(pd.isQueued()) {
        // process any received messages, if you're using the queue and *do not*
        // call these, you won't receieve any messages or midi!
        pd.receiveMessages();
        pd.receiveMidi();
    }
   
    
}

//--------------------------------------------------------------

void ofApp::draw() {
    cout << ofGetHeight()<<"height";
    cout << ofGetWidth()<<"width";
   
    
    ofBackground(214, 205, 201);
    ofPushMatrix();
    ofSetColor(255,255,255);
    bg.draw(0, 0, ofGetWidth(), ofGetHeight());
    ofPopMatrix();
    t = t+1;
    size=2;
    
    toggleA.draw();
    toggleA.base=180;
    toggleA.xPos=140;
    
    toggleB.draw();
    toggleB.base=350;
    toggleB.xPos=140;
    
    if(toggleB.value == true){
        drum1 = 1;
    }else{drum1=0;}
    
    toggleC.draw();
    toggleC.base=350;
    toggleC.xPos=340;
    
    if(toggleC.value == true){
          drum2 = 1;
      }else{drum2=0;}
      
    toggleD.draw();
    toggleD.base=350;
    toggleD.xPos=540;
    
    if(toggleD.value == true){
            drum3 = 1;
        }else{drum3=0;}
    
    toggleE.draw();
    toggleE.base=350;
    toggleE.xPos=740;
    
    if(toggleE.value == true){
            drum4 = 1;
        }else{drum4=0;}
      
    toggleF.draw();
    toggleF.base=350;
    toggleF.xPos=940;
    
    if(toggleF.value == true){
             drum5 = 1;
         }else{drum5=0;}
    
    hatA.draw();
    hatA.base=550;
    hatA.xPos=340;
    
    if(hatA.value == true){
               drum6 = 0;
           }else{drum6=1;}
    
    hatB.draw();
    hatB.base=550;
    hatB.xPos=540;
    
    if(hatB.value == true){
                drum7 = 0;
            }else{drum7=1;}
    
    hatC.draw();
    hatC.base=550;
    hatC.xPos=740;
    
    if(hatC.value == true){
                drum8 = 0;
            }else{drum8=1;}
    
  
    //knobA.draw(230, 1200, 1000);
    knobB.draw(ofGetWidth()/2, 1200, 1000);
   // knobC.draw(ofGetWidth()-230, 1200, 8);
    knobD.draw(230, 1600, 1);
    knobE.draw(ofGetWidth()/2, 1600, .5);
    knobF.draw(ofGetWidth()-230, 1600, 1);
    
    padA.draw();
    padA.xPos = ofGetWidth()/2-110;
    padA.base = ofGetHeight()/3+100;
   
 
    if(padA.value==true){
        chord1 =  floor((ofRandom(1000, 3000)));
        chord2 =  floor((ofRandom(1000, 3000)));
        chord3 =  floor((ofRandom(1000, 3000)));
        chord4 =  floor((ofRandom(1000, 3000)));
        bass1  = floor((ofRandom(0, 7000)));
        bass2  = floor((ofRandom(0, 7000)));
        bass3  = floor((ofRandom(0, 7000)));
        bass4  = floor((ofRandom(0, 7000)));
        bass5  = floor((ofRandom(0, 7000)));
        bass6  = floor((ofRandom(0, 7000)));
        bass7  = floor((ofRandom(0, 7000)));
        rando = floor((ofRandom(200, 700)));
    }
   
 
    std::vector<float> array1;
    pd.readArray("array1", array1);    // sets array to correct size
    cout << "array1 ";
    for(int i = 0; i < array1.size(); ++i)
        cout << array1[i] << " ";
    cout << endl;
    
    array1[0]=chord1;
    array1[1]=chord2;
    array1[2]=chord3;
    array1[3]=chord4;

    
    pd.writeArray("array1",array1);
    
    std::vector<float> array2;
    pd.readArray("array2", array2);    // sets array to correct size
    cout << "array2 ";
    for(int i = 0; i < array2.size(); ++i)
        cout << array2[i] << " ";
    cout << endl;
    
    array2[0]= drum1;
    array2[1]= drum2;
    array2[2]= drum3;
    array2[3]= drum4;
    array2[4]= drum5;

    
    pd.writeArray("array2",array2);
    
    std::vector<float> array3;
    pd.readArray("array3", array3);    // sets array to correct size
    cout << "array3 ";
    for(int i = 0; i < array3.size(); ++i)
        cout << array3[i] << " ";
    cout << endl;
    
    array3[0]= drum6;
    array3[1]= drum7;
    array3[2]= drum8;


    
    pd.writeArray("array3",array3);
    

    std::vector<float> array4;
    pd.readArray("array4", array4);    // sets array to correct size
    cout << "array4 ";
    for(int i = 0; i < array4.size(); ++i)
        cout << array4[i] << " ";
    cout << endl;
      
    array4[0]= bass1;
    array4[1]= bass2;
    array4[2]= bass3;
    array4[3]= bass4;
    array4[4]= bass5;
    array4[5]= bass6;
    array4[6]= bass7;
  


      
    pd.writeArray("array4",array4);
        
      
   // ofDrawBitmapString("drohm", 30, 250);
  //  ofDrawBitmapString("///////////////////////////", 30, 270);
   // filtermap = ofMap(knobB.value, 0, 7, 500, 8000);
    pd.sendFloat("rate", knobB.value);
    pd.sendFloat("rate2", knobB.value/2);
    pd.sendFloat("rando", rando);
    pd.sendFloat("drums", knobD.value);
    pd.sendFloat("chords", knobE.value);
    pd.sendFloat("bass", knobF.value);


    
  
    
    if (toggleA.value == true){
        
        pd.sendFloat("sup", 1);
    }
    else( pd.sendFloat("sup", 0));
    
    
  
   
    
  
    
}

//--------------------------------------------------------------
void ofApp::exit() {

    // cleanup

   
    ofSoundStreamStop();
}
//------------------------------------------------------------

//--------------------------------------------------------------
void ofApp::playTone(int pitch) {
    pd << StartMessage() << "pitch" << pitch << FinishList("tone") << Bang("tone");
}

//--------------------------------------------------------------
void ofApp::keyPressed (int key) {
    
 

    switch(key) {
        
        // musical keyboard
        case 'a':
            p=12;
            break;
        case 'w':
            p=13;
            break;
        case 's':
            p=14;
            break;
        case 'e':
            p=15;
            break;
        case 'd':
            p=16;
            break;
        case 'f':
            p=17;
            break;
        case 't':
            p=18;
            break;
        case 'g':
            p=19;
            break;
        case 'y':
            p=20;
            break;
        case 'h':
            p=21;
            break;
        case 'u':
            p=22;
            break;
        case 'j':
            p=23;
            break;
        case 'k':
            p=24;
            break;

        case ' ':
            if(pd.isReceivingSource(*this, "env")) {
                pd.ignoreSource(*this, "env");
                cout << "ignoring env" << endl;
            }
            else {
                pd.receiveSource(*this, "env");
                cout << "receiving from env" << endl;
            }
            break;

        default:
            break;
    }
}

//--------------------------------------------------------------
void ofApp::audioReceived(float * input, int bufferSize, int nChannels) {
    pd.audioIn(input, bufferSize, nChannels);
}

//--------------------------------------------------------------
void ofApp::audioRequested(float * output, int bufferSize, int nChannels) {
    pd.audioOut(output, bufferSize, nChannels);
}

//--------------------------------------------------------------
void ofApp::print(const std::string& message) {
    cout << message << endl;
}

//--------------------------------------------------------------
void ofApp::receiveBang(const std::string& dest) {
    cout << "OF: bang " << dest << endl;
    

    
}

void ofApp::receiveFloat(const std::string& dest, float value) {
    cout << "OF: float " << dest << ": " << value << endl;
}

void ofApp::receiveSymbol(const std::string& dest, const std::string& symbol) {
    cout << "OF: symbol " << dest << ": " << symbol << endl;
}

void ofApp::receiveList(const std::string& dest, const List& list) {
    cout << "OF: list " << dest << ": ";

    // step through the list
    for(int i = 0; i < list.len(); ++i) {
        if(list.isFloat(i))
            cout << list.getFloat(i) << " ";
        else if(list.isSymbol(i))
            cout << list.getSymbol(i) << " ";
    }

    // you can also use the built in toString function or simply stream it out
    // cout << list.toString();
    // cout << list;

    // print an OSC-style type string
    cout << list.types() << endl;
}

void ofApp::receiveMessage(const std::string& dest, const std::string& msg, const List& list) {
    cout << "OF: message " << dest << ": " << msg << " " << list.toString() << list.types() << endl;
}

//--------------------------------------------------------------
void ofApp::receiveNoteOn(const int channel, const int pitch, const int velocity) {
    cout << "OF MIDI: note on: " << channel << " " << pitch << " " << velocity << endl;
   
    chan=channel;
    note=pitch;
    vel=velocity;
 
    
}

void ofApp::receiveControlChange(const int channel, const int controller, const int value) {
    cout << "OF MIDI: control change: " << channel << " " << controller << " " << value << endl;
}

// note: pgm nums are 1-128 to match pd
void ofApp::receiveProgramChange(const int channel, const int value) {
    cout << "OF MIDI: program change: " << channel << " " << value << endl;
}

void ofApp::receivePitchBend(const int channel, const int value) {
    cout << "OF MIDI: pitch bend: " << channel << " " << value << endl;
}

void ofApp::receiveAftertouch(const int channel, const int value) {
    cout << "OF MIDI: aftertouch: " << channel << " " << value << endl;
}

void ofApp::receivePolyAftertouch(const int channel, const int pitch, const int value) {
    cout << "OF MIDI: poly aftertouch: " << channel << " " << pitch << " " << value << endl;
}

// note: pd adds +2 to the port num, so sending to port 3 in pd to [midiout],
//       shows up at port 1 in ofxPd
void ofApp::receiveMidiByte(const int port, const int byte) {
    cout << "OF MIDI: midi byte: " << port << " " << byte << endl;
}


