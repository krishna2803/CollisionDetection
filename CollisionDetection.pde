Shape polygon1;
Shape polygon2;
Shape triangle;
Shape circle1;
Shape circle2;

PVector mouse;

void setup() {
    size(1000, 700);
    
    mouse = new PVector(width/2, height/2);

    polygon1 = new Polygon();
    polygon1.randomize(new PVector(width/2, height/2), 5, height/4f, height/8f, PI/12f);
    
    polygon2 = new Polygon();
    polygon2.randomize(new PVector(width/2, height/2), 5, height/4f, height/8f, PI/12f);
    polygon2.setCenter(mouse);
    
    //circle1 = new Circle(width/2, height/2, 50);
    //circle1.setCenter(mouse);
}

void draw() {
    background(51);

    fill(25, 255, 25, 255/2);
    stroke(100, 200, 100);
    
    //if (!polygon.debug) {
    //    if (polygon.testPoint(mouseX, mouseY)) {
    //        fill(255, 25, 25, 255/2);
    //        stroke(255, 0, 0);
    //    }
    //}
    
    if (polygon1.colliding(polygon2)) {
        fill(255, 25, 25, 255/2);
        stroke(255, 0, 0);
    }

    polygon1.show();
    //circle1.show();
    polygon2.show();
    
    mouse.set(mouseX, mouseY);
}

void keyPressed() {
    if (key == 'd') {
        //triangle.debug = !triangle.debug;
        polygon1.debug = !polygon1.debug;
        polygon2.debug = !polygon2.debug;
    }
    if (key == 'r') {
        polygon1.randomize(new PVector(width/2, height/2), 5, height/4f, height/8f, PI/12f);
    }
    if (key == 't') {
        polygon2.randomize(new PVector(width/2, height/2), 5, height/4f, height/8f, PI/12f);
        polygon2.setCenter(mouse);
    }
}

void mouseWheel(MouseEvent e) {
    polygon2.rotate(radians(1.5 * e.getCount()));
    //triangle.rotate(radians(1.5f * e.getCount()));
}
