import KinectPV2.*;

KinectPV2 kinect;

float minThresh;
float maxThresh;

PImage img;
 
void setup() {
  size(512, 424);

  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  //kinect.enablePointCloud(true);
  kinect.init();
  img = createImage(kinect.WIDTHDepth, kinect.HEIGHTDepth,RGB);
}

void draw() {
  background(0);
  
  img.loadPixels();
  
  
  minThresh = 500;
  maxThresh = 750;
  
  //minThresh = map(mouseX, 0, width, 0, 4500);
  //maxThresh = map(mouseY, 0, width, 0, 4500);
  
  
  PImage dImg = kinect.getDepthImage();
  
  //Get the raw depth 0-4500 as array of integers
  int[] depth = kinect.getRawDepthData();
  
  int record = 4500;
  int rx = 0;
  int ry = 0; 
  
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  
  for(int x = 0; x < kinect.WIDTHDepth; x++){
    for(int y = 0; y < kinect.HEIGHTDepth; y++){
      int offset = x + y * kinect.WIDTHDepth;
      int d = depth[offset];
      
      if(d > minThresh && d < maxThresh){
        img.pixels[offset] = color(137, 195, 235);
        
        if (d < record){
          record = d;
          rx = x;
          ry = y;
        }
        
      }else{
        //img.pixels[offset] = color(0);
        img.pixels[offset] = dImg.pixels[offset];
      }
    }
  }
  
  img.updatePixels();
  image(img, 0, 0);
  
  fill(112,88,163);
  stroke(231, 96, 158);
  strokeWeight(4);
  ellipse(rx, ry, 64, 64);
  
  
}
