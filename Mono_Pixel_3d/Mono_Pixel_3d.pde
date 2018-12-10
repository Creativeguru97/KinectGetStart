/*
Thomas Sanchez Lengeling.
http://codigogenerativo.com/

KinectPV2, Kinect for Windows v2 library for processing

Simple HD Color test
*/
import KinectPV2.*;

KinectPV2 kinect;

void setup() {
  size(1920, 1080, P3D);

  kinect = new KinectPV2(this);
  kinect.enableColorImg(true);

  kinect.init();
  
}

void draw() {
  background(0);
  
  //int ImgWidth = 1920;
  //int ImgHeight = 1080;
  
  //obtain the color image from the kinect v2
  //image(kinect.getColorImage(), 0, 0, ImgWidth, ImgHeight);
  PImage img = kinect.getColorImage();
  //image(img, 0, 0);
  
  
  int skip = 10;
  for(int x = 0; x < img.width; x+=skip){
    for(int y = 0; y < img.height; y+=skip){
      int index = x + y * img.width;
      float b = brightness(img.pixels[index]);
      float z=map(b, 0, 255, 150, -150);
      fill(255-b);
      pushMatrix();
      translate(x, y, z);
      rect(0,0,skip/2,skip/2);
      popMatrix();
    }
  }
  
  
  fill(255, 0, 0);
  text(frameRate, 50, 50);
}
