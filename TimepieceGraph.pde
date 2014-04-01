int num = 185;
float radius = 120;
float[] ydata1 = new float[num];
float[] ydata2 = new float[num];
int[] trans1 = new int[num];
int[] trans2 = new int[num];
// float ydata1[] = {153, 4467, 4137, 5175, 4974, 6886, 672, 4167, 3851, 3993, 3395, 2805, 3790, 3551, 2702, 2892, 3320};
// float ydata2[] = {65, 3204, 2325, 3119, 2942, 3842, 336, 2048, 1575, 1487, 1771, 1245, 1602, 1857, 1244, 1649, 2025};

PFont font;
Calendar calendar;

void setup() {

    size(800, 800);

    ellipseMode(CENTER);
    smooth(32);


    calendar = new Calendar(18, 3, 18, 9);

    float t1 = 0; float dt1 = 0.03;
    float t2 = 0; float dt2 = 0.04;
    for (int i = 0; i < num; i++) {
        t1 += dt1;
        t2 += dt2;
        ydata1[i] = 250 * noise(t1) * random(0.8, 1);
        ydata2[i] = 200 * noise(t2) * random(0.8, 1);
        trans1[i] = round(random(50, 225));
        trans2[i] = round(random(50, 225));
    }
    // float mx = max(max(ydata1), max(ydata2));
    // println("mx: " + mx);

    // for (int i = 0; i < ydata1.length; i++) ydata1[i] = 250 * ydata1[i] / mx;
    // for (int i = 0; i < ydata2.length; i++) ydata2[i] = 250 * ydata2[i] / mx;


    // font = loadFont("Tahoma-48.vlw");
    font = createFont("Helvetica", 22, true);
    textFont(font);



    background(0);
    noStroke();


    translate(width / 2, height / 2);


}

void draw() {

    background(0);

    translate(width / 2, height / 2);

    fill(0);

    plotTimeGraph(ydata1, radius, color(0, 100, 255), trans1);
    plotTimeGraph(ydata2, radius, color(255, 50, 50), trans2);

    stroke(0);
    ellipse(0, 0, 2 * radius, 2 * radius); // ticker circle

    plotEvent(radians(30), "Osbourne rejects the pound");
    plotEvent(radians(120), "Merkel is a man");
    plotEvent(radians(190), "The SNP is run by fish");
    plotEvent(radians(300), "Scotland detaches and sails to Norway");

    drawTicker();
    plotMarkers();
}

// Functions
void plotTimeGraph(float[] ydata, float radius, color c, int[] trans) {

    stroke(c);
    strokeWeight(4);

    float drad = TWO_PI / (ydata.length);
    pushMatrix();
    // plot
    for (int i = 0; i < ydata.length; i++) {
        stroke(c, trans[i]);
        line(0, -radius, 0, -radius - ydata[i]);
        rotate(drad);
    }
    popMatrix();
}

void drawTicker() {

    int dx = mouseX - width / 2;
    int dy = mouseY - height / 2;

    float angle = atan2(dx, dy);

    int lineX = (int)(radius * sin(angle));
    int lineY = (int)(radius * cos(angle));
    int xoffset =  (int)((3 * radius / 4) * sin(angle));
    int yoffset =  (int)((3 * radius / 4) * cos(angle));

    strokeWeight(2);
    stroke(255);
    line(xoffset, yoffset, lineX, lineY);

    fill(255);
    textAlign(CENTER, CENTER);
    rectMode(CORNERS);
    textFont(font, 22);
    // println("-1*(angle-PI): "+-1*(angle-PI));
    text(calendar.getDate(-1 * (angle - PI)), -radius, -radius, radius, radius);

}

// void plotCircleVertexSpike(float[] ydata, float radius, color c) {
//     // radius provideds offset in x,y around a circle
//     float drad = TWO_PI / (ydata.length);
//     float angle = 0;

//     fill(c);
//     beginShape();
//     for (int i = 0; i < ydata.length; i++) {

//         float dx = radius * sin(angle);
//         float dy = radius * cos(angle);

//         float x = (ydata[i] + radius) * sin(angle + drad / 2);
//         float y = (ydata[i] + radius) * cos(angle + drad / 2);

//         vertex(dx, -dy);
//         vertex(x, -y);
//         angle += drad;
//     }
//     endShape(CLOSE);
// }

void plotEvent(float angle, String msg) {

    int dx = 250;

    pushMatrix();

    rotate(angle - PI / 2);

    strokeWeight(1);
    stroke(255);
    line(radius - 20, 0, radius + dx, 0); // event line

    rectMode(CORNERS);
    textFont(font, 14);

    if (angle <= PI) {
        textAlign(RIGHT, BOTTOM);
        fill(0); text(msg, radius, 0, radius + dx, -25); //Stop anti-aliasing alpha from building up
        fill(255); text(msg, radius, 0, radius + dx, -25);
    } else {
        rotate(PI);
        textAlign(LEFT, BOTTOM);
        fill(0); text(msg, radius, 0, -radius - dx, -25);
        fill(255); text(msg, radius, 0, -radius - dx, -25);
    }

    popMatrix();
}



void plotMarkers() {

    strokeWeight(1);
    stroke(200, 100);
    int n = 32;
    float dz = 10;

    float angle = TWO_PI / n;
    pushMatrix();
    for (int i = 0; i < n; i++) {
        if ((i % 8) == 0) {
            dz = 20;
        } else {
            dz = 10;
        }
        line(radius, 0, radius - dz, 0); // event line
        rotate(angle);
    }
    popMatrix();
}