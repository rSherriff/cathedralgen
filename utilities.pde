
//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
PVector find_point_on_circle(PVector circle_origin, float radius, float angle)
{
  PVector result = new PVector(0, 0);

  result.y = circle_origin.y + radius * sin( angle );
  result.x = circle_origin.x + radius * cos( angle );

  return result;
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_line(float origin_x, float origin_y, float end_x, float end_y)
{    
    fill(210);
    strokeWeight(1);

    int offset = 5;

    beginShape();
    vertex(origin_x, origin_y);    

    vertex(end_x - offset, end_y - offset);
    
    vertex(end_x, end_y);
    vertex(origin_x + offset, origin_y + offset);
    endShape();    
}

void draw_ellipse(PVector origin)
{
  fill(255,0,0);
      ellipse(origin.x, origin.y, 10,10);
      noFill();
}

void draw_ellipse(PVector origin, int stroke_weight)
{
  strokeWeight(1);
  fill(255,0,0);
      ellipse(origin.x, origin.y, 10,10);
      noFill();
      strokeWeight(stroke_weight);
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
PVector move_towards(PVector start, PVector end, float distance)
{
  PVector direction = PVector.sub(end, start).normalize();

  return start.add(direction.mult(distance));
}