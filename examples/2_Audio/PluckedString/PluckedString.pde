
import ddf.minim.*;
import ddf.minim.ugens.*;
import peasy.*;

int baseFrameRate = 60;

int mouseDragged = 0;

int gridSpacing = 2;
int xOffset= 0;
int yOffset= 0;

float currAudio = 0;
float gainVal = 1.;


PeasyCam cam;

float percsize = 200;

Minim minim;
PhyUGen simUGen;
Gain gain;

AudioOutput out;
AudioRecorder recorder;


ModelRenderer renderer;


///////////////////////////////////////

void setup()
{
  //size(1000, 700, P3D);
  fullScreen(P3D,2);
    cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(2500);
  
  minim = new Minim(this);
  
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  
  recorder = minim.createRecorder(out, "myrecording.wav");
  
    // start the Gain at 0 dB, which means no change in amplitude
  gain = new Gain(0);
  
  // create a physicalModel UGEN
  simUGen = new PhyUGen(44100);
  // patch the Oscil to the output
  simUGen.patch(gain).patch(out);
  
  renderer = new ModelRenderer(this);
  
  renderer.setZoomVector(100,100,100);
  
  renderer.displayMats(true);
  renderer.setSize(matModuleType.Mass3D, 40);
  renderer.setColor(matModuleType.Mass3D, 140, 140, 40);
  renderer.setSize(matModuleType.Mass2DPlane, 10);
  renderer.setColor(matModuleType.Mass2DPlane, 120, 0, 140);
  renderer.setSize(matModuleType.Ground3D, 25);
  renderer.setColor(matModuleType.Ground3D, 30, 100, 100);
  
  renderer.setColor(linkModuleType.SpringDamper3D, 135, 70, 70, 255);
  renderer.setStrainGradient(linkModuleType.SpringDamper3D, true, 0.1);
  renderer.setStrainColor(linkModuleType.SpringDamper3D, 105, 100, 200, 255);
  
    cam.setDistance(500);  // distance from looked-at point
  
  frameRate(baseFrameRate);

}

void draw()
{
  background(0,0,25);

  directionalLight(126, 126, 126, 100, 0, -1);
  ambientLight(182, 182, 182);

  renderer.renderModel(simUGen.mdl);

  cam.beginHUD();
  stroke(125,125,255);
  strokeWeight(2);
  fill(0,0,60, 220);
  rect(0,0, 250, 50);
  textSize(16);
  fill(255, 255, 255);
  text("Curr Audio: " + currAudio, 10, 30);
  cam.endHUD();

}
