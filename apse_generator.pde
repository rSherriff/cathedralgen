
//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_apse(PVector origin)
{ 
  float apse_type = random(0,100);
  
  if(apse_type < 50)
  {
    draw_circular_apse(origin, 7, vault_height);
  }
  else if(apse_type < 100)
  {
    draw_rectangular_apse(origin);
  }
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_circular_apse(PVector origin, int number_of_vaults, float apse_radius)
{ 
  PVector center_point = new PVector(origin.x, origin.y);
  center_point.x += apse_radius * 0.2;
  fill(255);
        
  //Ellipse at center for the boss
  float boss_radius = vault_width * 0.05;
  fill(0);
  ellipse(center_point.x, center_point.y, boss_radius, boss_radius);
  noFill();
  
  float radians_to_progress = PI / number_of_vaults;
  float current_angle;
  
  PVector[][] last_loop_pillars = new PVector [number_of_choir_aisles + 1][number_of_vaults + 2];
  
  int num_circles = (number_of_choir_aisles / 2) + 1;

  for(int aisle = 1; aisle <= num_circles; aisle++)
  {    
    current_angle = radians(270);
    
    PVector current_point = find_point_on_circle(origin, apse_radius, current_angle);

    line(origin.x, origin.y, current_point.x, current_point.y);
    
    for (int i = 0; i < number_of_vaults + 2; i++)
    {
      if(i > 1)
      {
        draw_pier(new PVector(current_point.x, current_point.y), 0, pillar_width);
      }
       
      PVector next_point = find_point_on_circle(origin, apse_radius, current_angle);
      
      if(aisle == num_circles && i < number_of_vaults + 1)
      {        
        if(i > 0)
        {
          PVector y_axis = new PVector(1,0);
          
          PVector side_chapel_origin = new PVector((current_point.x + next_point.x) / 2, (current_point.y + next_point.y) / 2);
          float side_chapel_radius = PVector.dist(current_point, next_point);
          float angle = PVector.angleBetween( PVector.sub(current_point, next_point), y_axis);
          
          if(random(0,100) > ambalatory_side_chapel_chance)
          {
            draw_circular_side_chapel(side_chapel_origin, radians(194 - degrees(radians_to_progress)) + (i * radians_to_progress), side_chapel_radius /2);
          }
          else
          {
            strokeWeight(7);
            line(current_point.x, current_point.y, next_point.x, next_point.y);
            strokeWeight(1);
          }
        }
        
        line(current_point.x, current_point.y, next_point.x,  next_point.y);
      }
      else if (i < number_of_vaults + 1)
      {
        line(current_point.x, current_point.y, next_point.x, next_point.y);
      }     
      
      if(aisle == 1 )
      {
          line(current_point.x, current_point.y, center_point.x, center_point.y);
          last_loop_pillars[aisle][i] = current_point;       
      }
      else
      {        
        if(i > 1)
        {
          PVector vault_center = new PVector(0,0);
          vault_center.x = (current_point.x + last_loop_pillars[aisle][i - 1].x + last_loop_pillars[aisle - 1][i].x + last_loop_pillars[aisle - 1][i - 1].x) / 4;
          vault_center.y = (current_point.y + last_loop_pillars[aisle][i - 1].y + last_loop_pillars[aisle - 1][i].y + last_loop_pillars[aisle - 1][i - 1].y) / 4;
  
          float internal_vault_offset = -0.1;
  
          PVector direction_to_center = PVector.sub(last_loop_pillars[aisle][i - 1], vault_center);
          PVector vault_top_left = PVector.add(last_loop_pillars[aisle][i - 1], direction_to_center.mult(internal_vault_offset));
          
          direction_to_center = PVector.sub(current_point, vault_center);
          PVector vault_top_right = PVector.add(current_point, direction_to_center.mult(internal_vault_offset));
          
          direction_to_center = PVector.sub(last_loop_pillars[aisle - 1][i - 1], vault_center);
          PVector vault_bottom_left = PVector.add(last_loop_pillars[aisle - 1][i - 1], direction_to_center.mult(internal_vault_offset));
          
          direction_to_center = PVector.sub(last_loop_pillars[aisle - 1][i], vault_center);
          PVector vault_bottom_right = PVector.add(last_loop_pillars[aisle - 1][i], direction_to_center.mult(internal_vault_offset));
          
          quad(vault_top_left.x, vault_top_left.y, vault_top_right.x, vault_top_right.y, vault_bottom_right.x, vault_bottom_right.y, vault_bottom_left.x, vault_bottom_left.y); 
          
          //Vaulting
          line(current_point.x, current_point.y, vault_center.x, vault_center.y);
          line(last_loop_pillars[aisle][i - 1].x, last_loop_pillars[aisle][i - 1].y, vault_center.x, vault_center.y);
          line(last_loop_pillars[aisle - 1][i].x, last_loop_pillars[aisle - 1][i].y, vault_center.x, vault_center.y);
          line(last_loop_pillars[aisle - 1][i - 1].x, last_loop_pillars[aisle - 1][i - 1].y, vault_center.x, vault_center.y);
          
          //Ellipse at center for the boss
          fill(0);
          ellipse(vault_center.x, vault_center.y, boss_radius, boss_radius);
          noFill();
        }
        
        line(current_point.x, current_point.y, last_loop_pillars[aisle-1][i].x, last_loop_pillars[aisle-1][i].y);
        last_loop_pillars[aisle][i] = current_point;
      }
      
      current_point = next_point;
      current_angle += radians_to_progress;    
    }
        
    apse_radius += vault_height;
  }
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_rectangular_apse(PVector origin)
{ 
  int number_of_apse_aisles = number_of_choir_aisles - (2 * int(random(1,2)));
  
  if(number_of_apse_aisles == 1)
    return;
  
  int mid_apse_aisle = array_aisle_list[number_of_apse_aisles];
  int number_apse_vaults = int(random(1,4));
  float apse_width =vault_width * number_apse_vaults;
  
  origin.x += vault_width /2;
  
  if(number_of_apse_aisles > 1)
  {
    origin.y -= (vault_height * ((number_of_apse_aisles) / 2)) +(vault_height / 2);
  }
  
  draw_nave(origin, apse_width, vault_height, number_apse_vaults, number_of_apse_aisles, mid_apse_aisle);
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_circular_side_chapel(PVector origin, float starting_angle, float radius)
{
    float radians_to_progress = PI / number_of_vaults;
    float current_angle = starting_angle;
    
    PVector center_point = find_point_on_circle(origin, radius * 0.2, starting_angle + HALF_PI);
  
    PVector current_point = find_point_on_circle(origin, radius, current_angle);
    for (int i = 0; i < number_of_vaults + 2; i++)
    {      
      //draw_pier(new PVector(current_point.x, current_point.y), 0, pillar_width);
      
      PVector next_point = find_point_on_circle(origin, radius, current_angle);
  
      if(i < number_of_vaults + 1)
      {
        strokeWeight(7);
        line(current_point.x, current_point.y, next_point.x, next_point.y);
        strokeWeight(1);
      }
      
      line(center_point.x, center_point.y, current_point.x, current_point.y);
      
      current_point = next_point;
      current_angle += radians_to_progress;    
    }
}