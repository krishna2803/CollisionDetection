Shape polygon;
Shape triangle;

PVector mouse;

void setup() {
    size(800, 600);

    //polygon = new Polygon();
    //polygon.randomize(new PVector(width/2, height/2), 4, height/4f, height/32, PI/12f);
    //polygon.debug = true;


    triangle = new Triangle();
    triangle.randomize(new PVector(width/2, height/2), height/4f, height/32, random(-PI, PI));

    //PVector vertices[] = {
    //    new PVector(0, 0), 
    //    new PVector(width, 0), 
    //    new PVector(width, height), 
    //    new PVector(0, height)
    //};
    //polygon = new Polygon();
    //polygon.randomize(new PVector(width/2, height/2), 7, height/4f, height/16f, PI/4f);
    //polygon.debug = true;


    mouse = new PVector(width/2, height/2);
}

void draw() {
    background(51);

    if (triangle.testPoint(mouse)) {
        fill(255, 25, 25, 255/2);
        stroke(255, 0, 0);
    } else {
        fill(25, 255, 25, 255/2);
        stroke(100, 200, 100);
    }
    //noStroke();
    //polygon.show();
    triangle.show();


    mouse.set(mouseX, mouseY);

    //triangle.twitch(i, mouse);
    //polygon.twitch(i, mouse);

    //fill(0);
    //textAlign(CENTER);
    //text(triangle.getArea(), width/2, height/2);
    //text(polygon.getArea(), width/2, height/2);
}

void keyPressed() {
    if (key == 'd') {
        triangle.debug = !triangle.debug;
    }
}

void mouseWheel(MouseEvent e) {
    //polygon.rotate(radians(2 * e.getCount()));
    triangle.rotate(radians(1.5f * e.getCount()));
}
