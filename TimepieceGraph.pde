int num = 185;
float radius = 120;
float[] ydata1 = new float[num];
float[] ydata2 = new float[num];
PFont font;
Calendar calendar;

void setup() {

	size(800,800);	
	ellipseMode(CENTER);
	noStroke();
	smooth();

	calendar = new Calendar(18,3,18,9);

	float t1 = 0; float dt1 = 0.03;
	float t2 = 0; float dt2 = 0.04;
	for (int i=0; i<num; i++) {
		t1 += dt1;
		t2 += dt2;
		ydata1[i]= 250*noise(t1)*random(0.8,1);
		ydata2[i]= 150*noise(t2)*random(0.8,1);
	}

	font = loadFont("Tahoma-48.vlw");
	textFont(font, 35);



	background(0);
	
	translate(width/2, height/2);

	plotCircleLine(ydata1, radius, color(0,100,255));
	plotCircleLine(ydata2, radius, color(255,50,50));

}

void draw() {
	

	translate(width/2, height/2);

	fill(0);
	stroke(0);
	ellipse(0,0,2*radius,2*radius);

	plotEvent(radians(30), "Osbourne rejects the pound");
	plotEvent(radians(120), "Merkel is a man");
	plotEvent(radians(190), "The SNP is run by fish");
	plotEvent(radians(300), "Scotland detaches and sails to Norway");

	drawTicker();
}

// Functions
void plotCircleLine(float[] ydata, float radius, color c) {

	stroke(c);
	strokeWeight(3);

	float drad = TWO_PI / (ydata.length);
	pushMatrix();
	// plot
	for (int i=0; i < ydata.length; i++) {
		line(0, -radius, 0,-radius-ydata[i]);
		rotate(drad);
	}
	popMatrix();
}

void drawTicker() {

	int dx = mouseX-width/2;
	int dy = mouseY-height/2;

	float angle = atan2(dx,dy);

	int lineX = (int)(radius*sin(angle));
	int lineY = (int)(radius*cos(angle));
	int xoffset =  (int)((3*radius/4)*sin(angle));
	int yoffset =  (int)((3*radius/4)*cos(angle));

	strokeWeight(2);
	stroke(255);
	line(xoffset,yoffset,lineX,lineY);

	fill(255);
	textAlign(CENTER, CENTER);
	rectMode(CORNERS);
	textFont(font, 22);
	// println("-1*(angle-PI): "+-1*(angle-PI));
	text(calendar.getDate(-1*(angle-PI)), -radius, -radius, radius, radius);

}

void plotCircleVertexSpike(float[] ydata, float radius, color c) {
	// radius provideds offset in x,y around a circle
	float drad = TWO_PI / (ydata.length);
	float angle = 0;

	fill(c);
	beginShape();
	for (int i=0; i<ydata.length; i++) {

		float dx = radius*sin(angle);
		float dy = radius*cos(angle);

		float x = (ydata[i]+radius)*sin(angle+drad/2);
		float y = (ydata[i]+radius)*cos(angle+drad/2);

		vertex(dx,-dy);
		vertex(x,-y);
		angle += drad;
	}
	endShape(CLOSE);
}

void plotEvent(float angle, String msg)
{

	int dx = 250;
	
	pushMatrix();

	rotate(angle-PI/2);

	strokeWeight(1);
	stroke(200);
	line(radius-20,0,radius+dx,0);

	rectMode(CORNERS);
	textFont(font, 14);

	if (degrees(angle) <= 180){
		textAlign(RIGHT, BOTTOM);
		fill(0); text(msg,radius,0,radius+dx,-25);	//Stop anti-aliasing alpha from building up
		fill(255); text(msg,radius,0,radius+dx,-25);
	} else {
		rotate(PI);
		textAlign(LEFT, BOTTOM);
		fill(0); text(msg,radius,0,-radius-dx,-25);
		fill(255); text(msg,radius,0,-radius-dx,-25);
	}

	popMatrix();
}