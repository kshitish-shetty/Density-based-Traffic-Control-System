import processing.serial.*;

Serial myPort;

String data = "";
int density = 0;
int greenTime = 0;

void setup() {
  size(600, 400);
  myPort = new Serial(this, "COM5", 9600);
  myPort.bufferUntil('.');
}

void draw() {
  background(30);

  drawTrafficLight();
  drawText();
}

void serialEvent(Serial myPort) {
  data = myPort.readStringUntil('.');
  if (data == null) return;

  data = data.substring(0, data.length() - 1);
  int index = data.indexOf(",");

  density = int(data.substring(0, index));
  greenTime = int(data.substring(index + 1));
}

void drawTrafficLight() {
  fill(60);
  rect(250, 50, 100, 250, 20);

  // Red
  fill(density == 1 ? 255 : 80, 0, 0);
  ellipse(300, 100, 50, 50);

  // Yellow
  fill(density == 2 ? 255 : 80, 255, 0);
  ellipse(300, 175, 50, 50);

  // Green
  fill(density == 3 ? 0 : 80, density == 3 ? 255 : 80, 0);
  ellipse(300, 250, 50, 50);
}

void drawText() {
  fill(255);
  textSize(20);

  String level = density == 1 ? "LOW" : density == 2 ? "MEDIUM" : "HIGH";

  text("Traffic Density: " + level, 50, 340);
  text("Green Time: " + greenTime + " sec", 350, 340);
}
