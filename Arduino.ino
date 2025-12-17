const int trigPin = 10;
const int echoPin = 11;

long duration;
int distance;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  Serial.begin(9600);
}

void loop() {
  distance = calculateDistance();

  int densityLevel;
  int greenTime;

  if (distance > 60 || distance == 0) {
    densityLevel = 1;      // LOW
    greenTime = 5;
  } 
  else if (distance > 30) {
    densityLevel = 2;      // MEDIUM
    greenTime = 10;
  } 
  else {
    densityLevel = 3;      // HIGH
    greenTime = 15;
  }

  // Send data to Processing
  Serial.print(densityLevel);
  Serial.print(",");
  Serial.print(greenTime);
  Serial.print(".");

  delay(1000);
}

int calculateDistance() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH, 30000);
  if (duration == 0) return 0;

  return duration * 0.034 / 2;
}
