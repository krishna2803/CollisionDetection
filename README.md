# CollisionDetection
Convex Polygon to Convex Polygon detection (in (processing)[https://processing.org/], a java library) using cartesian coordinates and basic co-ordinate geometry.

### Algorithm:
1. Divide `n-vertices polygon` into `n-2 triangles`. *(n >= 3)*
2. For each vertex of `polygon A`, check if any of its vertex lie inside/on any of triangles of `polygon B`.
3. For each vertex of `polygon B`, check if any of its vertex lie inside/on any of triangles of `polygon A`.

### Point inside triangle:
1. Given `triangle ABC`, `point P`.
2. Check if `ar(PAB) + ar(PBC) + ar(PAC) = ar(ABC)`.

#### Footnotes
coded by - **@krishna2803**
