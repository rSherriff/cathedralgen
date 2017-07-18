

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_chapter_house(PVector origin, int sides, float radius, int door_side)
{
  strokeCap(SQUARE);
  strokeWeight(pillar_width);
  
  float current_angle = PI;
  
  PVector current_line_pos = new PVector(origin.x + (radius / 2), origin.y );  
  int number_to_offset;
  
  int[] side_sample = {0,0,0,0,0,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10};  
  number_to_offset = side_sample[sides];
  
  PVector temp_pos = new PVector(current_line_pos.x, current_line_pos.y); 
  for(int i = 0; i < number_to_offset; i++)
  {  
      PVector next_pos = find_point_on_circle(temp_pos, radius, current_angle);           
      current_angle += radians(360 / sides);    
      temp_pos = next_pos;

  }
  float center_y_offset = abs( current_line_pos.y - temp_pos.y) / 2;
  current_line_pos.y += center_y_offset;
  
  PVector original_line_pos = new PVector(current_line_pos.x, current_line_pos.y); 

  //Central pier
  draw_random_pier(origin, int(random(10,25)));
  
  //Vaulting
  draw_chapter_house_vaulting(origin, sides, original_line_pos, radius, center_y_offset);
  
  //Buttresses
  draw_chapter_house_buttress(origin, sides, original_line_pos, radius, door_side);
  
  PVector entrance_pos = new PVector(0,0);
  
  //Walls
  draw_chapter_house_walls(sides, original_line_pos, radius, door_side, entrance_pos );
  
  //Entrance
  draw_chapter_house_entrance(entrance_pos, radius);

}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_chapter_house_vaulting(PVector origin, int sides, PVector original_line_pos, float radius, float center_y_offset )
{    
  int vault__types = 4;
  int type_percentage = 100 / (vault__types );
  float vault_chance = random(0,100);  
  int boss_number = 0;
  
    
   PVector[] bosses = new PVector[100];

  strokeWeight(1);
  if(vault_chance < type_percentage)
  {
    float y_offset  = random(radius * 0.5, radius * 0.6 );
      
    float current_angle = HALF_PI;
    bosses = new PVector[sides];
    for(int i = 0; i < sides; i++)
    {
      bosses[i] = find_point_on_circle(origin, y_offset, current_angle);
      boss_number++;
      current_angle += radians(360 / sides);
    }

    current_angle = PI;
    PVector current_line_pos = original_line_pos;
    
    for(int i = 0; i < sides; i++)
    {  
      line(origin.x, origin.y,  bosses[i].x,  bosses[i].y);
      
      PVector next_pos = find_point_on_circle(current_line_pos, radius, current_angle);
      line(current_line_pos.x, current_line_pos.y, origin.x, origin.y);
      
      line(current_line_pos.x, current_line_pos.y, bosses[i].x, bosses[i].y);
      
      if(i > 0)
      {
        line(current_line_pos.x, current_line_pos.y, bosses[i - 1].x, bosses[i - 1].y);
      }
      else
      {
        line(current_line_pos.x, current_line_pos.y, bosses[sides - 1].x, bosses[sides - 1].y);
      }

      current_angle += radians(360 / sides);     
    
      current_line_pos = next_pos;
    }
  }
  else if (vault_chance  < type_percentage * 2)
  {    
    float y_offset = random(center_y_offset * 0.5, radius * 0.6 );
    float current_angle = HALF_PI;
    bosses = new PVector[sides];
    for(int i = 0; i < sides; i++)
    {
      bosses[i] = find_point_on_circle(origin, y_offset, current_angle);
      boss_number++;
      if(i == sides - 1)
      {
        line(bosses[i].x, bosses[i].y, bosses[i - 1].x, bosses[i - 1].y);
        line(bosses[i].x, bosses[i].y, bosses[0].x, bosses[0].y);
      }
      else if(i > 0)
      {
        line(bosses[i].x, bosses[i].y, bosses[i - 1].x, bosses[i - 1].y);
      }
      
      current_angle += radians(360 / sides);
    }
    
    current_angle = PI;
    PVector current_line_pos = original_line_pos;
    
    for(int i = 0; i < sides; i++)
    {              
      PVector next_pos = find_point_on_circle(current_line_pos, radius, current_angle);
      
      line(origin.x, origin.y,  bosses[i].x,  bosses[i].y);
      
      line(current_line_pos.x, current_line_pos.y,  bosses[i].x, bosses[i].y);      
      if(i > 0)
      {
        line(current_line_pos.x, current_line_pos.y,  bosses[i-1].x, bosses[i-1].y);
      }
      else
      {
        line(current_line_pos.x, current_line_pos.y,  bosses[sides - 1].x, bosses[sides - 1].y);
      }

      current_angle += radians(360 / sides);   
      current_line_pos = next_pos;
    }  
  }
  else if (vault_chance  < type_percentage * 3)
  {
    float y_offset = random(radius * 0.5, radius * 0.6 );
    float current_angle = HALF_PI + (radians(360 / sides) / 2); 

    for(int i = 0; i < sides; i++)
    {
      bosses[i] = find_point_on_circle(origin, y_offset, current_angle);
      boss_number++;
      if(i == sides - 1)
      {
        line(bosses[i].x, bosses[i].y, bosses[i - 1].x, bosses[i - 1].y);
        line(bosses[i].x, bosses[i].y, bosses[0].x, bosses[0].y);
      }
      else if(i > 0)
      {
        line(bosses[i].x, bosses[i].y, bosses[i - 1].x, bosses[i - 1].y);
      }
      
      
      current_angle += radians(360 / sides);
    }
    
    current_angle = PI;
    PVector current_line_pos = original_line_pos;
    
    for(int i = 0; i < sides; i++)
    {              
      PVector next_pos = find_point_on_circle(current_line_pos, radius, current_angle);
      
      line(origin.x, origin.y,  bosses[i].x,  bosses[i].y);
         
      if(i > 0)
      {
        line(current_line_pos.x, current_line_pos.y,  bosses[i-1].x, bosses[i-1].y);
      }
      else
      {
        line(current_line_pos.x, current_line_pos.y,  bosses[sides - 1].x, bosses[sides - 1].y);
      }
      
      current_line_pos = move_towards(new PVector(current_line_pos.x, current_line_pos.y), next_pos, radius / 2);

      if(i > 0)
      {
        line(current_line_pos.x, current_line_pos.y,  bosses[i-1].x, bosses[i-1].y);
        line(current_line_pos.x, current_line_pos.y,  bosses[i].x, bosses[i].y);
      }
      else
      {
        line(current_line_pos.x, current_line_pos.y,  bosses[sides - 1].x, bosses[sides - 1].y);
        line(current_line_pos.x, current_line_pos.y,  bosses[0].x, bosses[0].y);
      }
      
      current_angle += radians(360 / sides);   
      current_line_pos = next_pos;
    }  
  }
  else if (vault_chance < type_percentage * 4)
  {
    float current_angle = HALF_PI; 

    int count = 0;
    for(int i = 0; i < (sides * 2); i++)
    {
      if(i % 2 != 0)
      {
        println(boss_number);
        bosses[count] = find_point_on_circle(origin, center_y_offset / 2, current_angle);
        boss_number++;
        line(bosses[count].x, bosses[count].y, origin.x, origin.y);
         
         if(count == sides - 1)
          {
            line(bosses[count].x, bosses[count].y, bosses[count - 1].x, bosses[count - 1].y);
            line(bosses[count].x, bosses[count].y, bosses[0].x, bosses[0].y);
          }
          else if(count > 0)
          {
            line(bosses[count].x, bosses[count].y, bosses[count - 1].x, bosses[count - 1].y);
          }
          count++;
      }
      else
      {
        PVector edge_point = find_point_on_circle(origin, center_y_offset, current_angle);
        line(edge_point.x, edge_point.y, origin.x, origin.y);
      }      

      current_angle += radians(360 / sides) / 2;
    }
    
    current_angle = PI;
    PVector current_line_pos = original_line_pos;
    for(int i = 0; i < sides; i++)
    {              
      PVector next_pos = find_point_on_circle(current_line_pos, radius, current_angle);
      current_line_pos = move_towards( new PVector(current_line_pos.x, current_line_pos.y), next_pos, radius / 2);
      
      line(current_line_pos.x, current_line_pos.y,  bosses[i ].x,  bosses[i ].y); 
      if(i > 0)
      {
        line(current_line_pos.x, current_line_pos.y,  bosses[i - 1].x,  bosses[i - 1].y);        
      }
      else
      {
        line(current_line_pos.x, current_line_pos.y,  bosses[boss_number - 1].x,  bosses[boss_number - 1].y);
      }
      
      current_angle += radians(360 / sides);   
      current_line_pos = next_pos;
    }  
  }
  
    float boss_radius = random(5,10);
    println(boss_number);
    for(int i = 0; i < boss_number; i++)
    {
      println(i);
      draw_boss(bosses[i], boss_radius);
    }
    
    strokeWeight(pillar_width);
  }

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_chapter_house_buttress(PVector origin, int sides, PVector original_line_pos, float radius, int door_side )
{
  float current_angle = PI;
  PVector current_line_pos = original_line_pos;
  float buttress_length = random(30,60);
  int buttress_pier_width = int(random(10,12));
  int buttress_pier_type = int(random(0,num_pier_types));
  strokeCap(PROJECT);
  for(int i = 0; i < sides; i++)
  {  
      PVector next_pos = find_point_on_circle(current_line_pos, radius, current_angle);      
      PVector buttress_pos = move_towards(new PVector(current_line_pos.x, current_line_pos.y), origin, -buttress_length);  
      PVector buttress_start = new PVector(current_line_pos.x, current_line_pos.y);
      
      if(i != door_side && i != door_side + 1)
      {              
        draw_pier(buttress_start, buttress_pier_type, buttress_pier_width);
        line(buttress_start.x, buttress_start.y, buttress_pos.x,buttress_pos.y);

        strokeWeight(pillar_width / 2);
        buttress_pos = move_towards(new PVector(current_line_pos.x, current_line_pos.y), origin, (-buttress_length * 1.4));  
        line(buttress_start.x, buttress_start.y, buttress_pos.x,buttress_pos.y);
        strokeWeight(pillar_width);
      }
           
      current_angle += radians(360 / sides);
    
      current_line_pos = next_pos;
  }
  strokeCap(SQUARE);  
  
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_chapter_house_walls(int sides, PVector original_line_pos, float radius, int door_side, PVector entrance_pos )
{
  float current_angle = PI;
  PVector current_line_pos = original_line_pos;
  for(int i = 0; i < sides; i++)
  {   
    if(i == sides -1)
    {
      if(i == door_side)
      {
        strokeWeight(1);         
      }
      line(current_line_pos.x, current_line_pos.y, original_line_pos.x, original_line_pos.y);
      strokeWeight(pillar_width); 
      break;
    }
    
    PVector next_pos = find_point_on_circle(current_line_pos, radius, current_angle);   
    
    if(i == door_side)
    {
      strokeWeight(1);  
      entrance_pos.x = current_line_pos.x;
      entrance_pos.y = current_line_pos.y;
      entrance_pos.x -= (radius / 2);
    }
    line(current_line_pos.x, current_line_pos.y, next_pos.x, next_pos.y);
    strokeWeight(pillar_width); 
    current_angle += radians(360 / sides);
    
    current_line_pos = next_pos;
  }
  
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_chapter_house_entrance(PVector entrance_pos, float radius)
{
  strokeWeight(1);    
  strokeCap(ROUND);
  
  //Entrance Vault
  int number_of_vaults = int(random(1,4));
  float entrance_vault_height = random(70,150);
  
  entrance_pos.y += entrance_vault_height / 2;
  for(int i = 0; i < number_of_vaults; i++)
  {
    draw_vault(entrance_pos, radius, entrance_vault_height, 0,0,0);
    entrance_pos.y += entrance_vault_height;
  }
}