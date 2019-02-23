PShape lightningBolt;
PShape[] lightningBorders;
boolean active = true;
float branchAngleRange = PI/16;
float branchLength = 8;
color boltColor = color(219, 237, 255);
float boltWidth = 3;
color borderColor = color(125, 249, 255);
float borderTransparency = 120;
float borderWidth = 100;
int borderSections = 20;

void setup()
{
  size(500, 500);
  background(0);
  frameRate(20);
  lightningBorders = new PShape[borderSections];
}

void draw()
{
  background(0);
  callLightning(width/2, height/2, PI/2);
}

void keyPressed()
{
  if (key == ' ')
    background(0);
}

void callLightning(float x, float y, float a)
{
  active = true;
  lightningBolt = createShape();
  lightningBolt.beginShape();

  lightningBolt.noFill();
  lightningBolt.stroke(boltColor);
  lightningBolt.strokeWeight(3);

  lightningBolt.vertex(x, y);

  for (int i = 0; i < lightningBorders.length; i++)
  {
    lightningBorders[i] = createShape();
    lightningBorders[i].beginShape();

    lightningBorders[i].noFill();
    lightningBorders[i].stroke(borderColor, borderTransparency / lightningBorders.length);
    lightningBorders[i].strokeWeight(i * (borderWidth / lightningBorders.length) + 1);

    lightningBorders[i].vertex(x, y);
  }

  createBranch(x, y, a);

  for (int i = 0; i < lightningBorders.length; i++)
  {
    lightningBorders[i].endShape();
    shape(lightningBorders[i]);
  }

  lightningBolt.endShape();
  shape(lightningBolt);
}

void createBranch(float x, float y, float a)
{
  if (!active) 
    return;

  float nextA = a + random(-branchAngleRange, branchAngleRange);
  float nextX = x + (cos(nextA) * branchLength);
  float nextY = y + (sin(nextA) * branchLength);

  lightningBolt.vertex(nextX, nextY);

  for (int i = 0; i < lightningBorders.length; i++)
    lightningBorders[i].vertex(nextX, nextY);

  if (nextX > width || nextX < 0 || nextY > height || nextY < 0)
    active = false;

  createBranch(nextX, nextY, nextA);
}
