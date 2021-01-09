public class Shape {

    protected PVector[] vertices;
    protected Triangle[] triangles;
    PVector centroid;

    protected float area;

    boolean debug;

    public boolean colliding(Shape shape) {
        return false;
    }

    public void show() {
    }

    public void randomize() {
    }

    public void randomize(PVector centroid, int len, float radius, float dr, float dTheta) {
    }

    public void randomize(PVector centroid, float radius, float dr, float dTheta) {
    }

    public void rotate(float dTheta) {
    }

    public void sortVertices() {
    }

    protected void calculateCentroid() {
    }

    protected void calculateTriangles() {
    }

    public float calculateArea () {
        return 0f;
    }

    public float getArea() {
        return this.area;
    }

    public void twitch(int i, PVector v) {
        if (i < 0 || i >= this.vertices.length) return;
        this.vertices[i].set(v.x, v.y);
        this.area = this.calculateArea();

        //if (this instanceof Polygon) {
        //    this.calculateTriangles();
        //}

        fill(0);
        noStroke();
        circle(v.x, v.y, 5);
    }

    public boolean testPoint(PVector point) {
        return this.testPoint(point.x, point.y);
    }
    public boolean testPoint(float x, float y) {
        return false;
    }
}

//=============================================================================================================================================

public class Line {
    PVector A;
    PVector B;

    public Line(float x1, float y1, float x2, float y2) {
        this.A = new PVector(x1, y1);
        this.B = new PVector(x2, y2);
    }

    public void show() {
        line(this.A.x, this.A.y, this.B.x, this.B.y);
    }
}

//=============================================================================================================================================

public class Polygon extends Shape {
    public Polygon() {
    }
    public Polygon(PVector[] vertices) {
        this.vertices = vertices.clone();
        this.calculateTriangles();
        this.area = this.calculateArea();
    }

    @Override
        public void randomize() {
        this.randomize(new PVector(width/2, height/2), floor(random(5, 10)), random(height/4, height/3), height/16, random(PI/4));
    }

    @Override
        public void randomize(PVector centroid, int len, float radius, float dr, float dTheta) {
        this.vertices = new PVector[len];
        this.centroid = centroid;
        for (int i=0; i<len; i++) {
            float theta = (float) i / len * TWO_PI + dTheta;
            float r = radius + random(-dr, dr);
            this.vertices[i] = new PVector(r * cos(theta), r * sin(theta));
            this.vertices[i].add(this.centroid);
        }
        this.area = this.calculateArea();
    }

    @Override
        public void rotate(float dTheta) {
        for (int i=0; i<vertices.length; i++) {
            this.vertices[i].sub(this.centroid);
            float mag = this.vertices[i].mag();
            float ang = this.vertices[i].heading() + dTheta;
            this.vertices[i].set(mag * cos(ang), mag * sin(ang));
            this.vertices[i].add(this.centroid);
        }
    }

    @Override
        public void show() {
        if (this.debug) {
            if (this.triangles != null) {
                stroke(0);
                strokeWeight(1);
                for (Triangle triangle : this.triangles) {
                    triangle.show();
                }
            }
        }
        beginShape();
        for (int i = 0; i < this.vertices.length; i++) {
            vertex(this.vertices[i].x, this.vertices[i].y);
        }
        endShape(CLOSE);
    }

    @Override
        protected void calculateCentroid() {
        float x = 0f, y = 0f;
        for (int i=0; i<this.vertices.length; i++) {
            x = vertices[i].x;
            y = vertices[i].y;
        }
        x /= (float) vertices.length;
        y /= (float) vertices.length;
        this.centroid = new PVector(x, y);
    }

    @Override
        protected void calculateTriangles () {
        this.triangles = new Triangle[this.vertices.length - 2];
        for (int i=0; i < this.vertices.length - 2; i++) {
            triangles[i] = new Triangle(this.vertices[0], this.vertices[i+1], this.vertices[i+2]);
        }
    }

    @Override
        public float calculateArea() {
        if (this.triangles == null) {
            this.calculateTriangles();
        }
        float area = 0f;
        for (int i=0; i<this.triangles.length; i++) {
            area += triangles[i].getArea();
        }
        return area;
    }
}

//=============================================================================================================================================

public class Triangle extends Polygon {
    public Triangle() {
    }

    public Triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
        this.vertices = new PVector[3];
        vertices[0] = new PVector(x1, y1);
        vertices[1] = new PVector(x2, y2);
        vertices[2] = new PVector(x3, y3);
        this.area = this.calculateArea();
    }

    public Triangle(PVector A, PVector B, PVector C) {
        //this(A.x, A.y, B.x, B.y, C.x, C.y);
        this.vertices = new PVector[3];
        this.vertices[0] = A;
        this.vertices[1] = B;
        this.vertices[2] = C;
        this.area = this.calculateArea();
    }

    @Override
        public void randomize() {
        this.randomize(new PVector(width/2, height/2), random(height/4, height/3), height/16, random(PI/4));
    }

    @Override
        public void randomize(PVector centroid, float radius, float dr, float dTheta) {
        this.randomize(centroid, 3, radius, dr, dTheta);
    } 

    @Override
        public float calculateArea () {
        // 20019.418
        return (this.vertices[0].x * (this.vertices[1].y - this.vertices[2].y)  +
            this.vertices[1].x * (this.vertices[2].y - this.vertices[0].y)  +
            this.vertices[2].x * (this.vertices[0].y - this.vertices[1].y)) / 2f;
        /*
        | x1       y1       1 |
         | x2 - x3  y2 - y3  0 |
         | x3 - x1  y3 - y1  0 |
         det = (x2 - x3) * (y3 - y1) - (x3 - x1) * (y2 - y3);
         */
        //return area(this.vertices[0], this.vertices[1], this.vertices[2]);
    }

    @Override
        public boolean testPoint(float x, float y) {
        PVector point = new PVector(x, y);
        float ar1 = area(vertices[0], point, vertices[1]);
        float ar2 = area(vertices[1], point, vertices[2]);
        float ar3 = area(vertices[0], point, vertices[2]);
        float absSum = abs(ar1) + abs(ar2) + abs(ar3);

        int approxArea = floor(abs(this.area));
        int approxSum  = floor(absSum);        

        if (debug) {
            fill(255);
            textSize(15);

            float w = .8*width;
            float h = 14;
            text(String.format("area = %.2f", this.area), w, h);
            text(String.format("\nar1  = %.2f", ar1), w, h);
            text(String.format("\n\nar2  = %.2f", ar2), w, h);
            text(String.format("\n\n\nar3  = %.2f", ar3), w, h);
            text(String.format("\n\n\n\nsum  = %.2f", absSum), w, h);

            stroke(255);
            strokeWeight(1.5f);
            line(x, y, vertices[0].x, vertices[0].y);
            line(x, y, vertices[1].x, vertices[1].y);
            line(x, y, vertices[2].x, vertices[2].y);

            text(String.format("\n\n\n\n\narap = %d", approxArea), w, h);
            text(String.format("\n\n\n\n\n\narap2= %d", approxSum), w, h);
        }
        return abs(approxArea - approxSum) <= EPSILON;
    }
}

public float area(PVector A, PVector B, PVector C) {
    return area(A.x, A.y, B.x, B.y, C.x, C.y);
}
//public float area(float x1, float y1, float x2, float y2, float x3, float y3) {
//    return (x1 * (y2 - y3)  +
//            x2 * (y3 - y1)  +
//            x3 * (y1 - y2)) / 2f;
//}

public float area(float x1, float y1, float x2, float y2, float x3, float y3) 
{ 
    return (x1*(y2-y3) + x2*(y3-y1)+ x3*(y1-y2)) / 2.0f;
} 

//=============================================================================================================================================


public class Circle extends Shape {
    public Circle(float x, float y, float radius) {
        this.centroid = new PVector(x, y, radius);
    }


    @Override
        void show() {
        float radius = centroid.z;
        ellipse(this.centroid.x, this.centroid.y, radius * 2, radius * 2);
    }
}
