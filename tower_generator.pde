//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_west_end()
{    
  int west_end_types = 2;
  int type_percentage = 100 / (west_end_types );
  float west_end_chance = random(0,100); 
  PVector origin;
  
  if(number_of_aisles == 1)
  {
    draw_one_vault_end(new PVector(nave_origin.x - (west_end_vault_width / 2) - (vault_width / 2), halfway_y));
    return;
  }
  
  if(west_end_chance < type_percentage)
  {
    west_end_aisles = number_of_aisles - 2;
        
    if (west_end_aisles > 1)
    {
      origin = new PVector(nave_origin.x - (west_end_vault_width / 2) - (vault_width / 2), halfway_y - ((west_end_aisles * vault_height) /2));
    } 
    else
    {
      origin = new PVector(nave_origin.x - (west_end_vault_width / 2) - (vault_width / 2), halfway_y - ((west_end_aisles * vault_height) /2) + (vault_height / 2));
    } 

    draw_towered_west_end(origin);
  }
  else if(west_end_chance < type_percentage * 2)
  {
    west_end_aisles = number_of_aisles;
    
    if (west_end_aisles > 1)
    {
      origin = new PVector(nave_origin.x - (west_end_vault_width / 2) - (vault_width / 2), halfway_y - ((west_end_aisles * vault_height) /2) );
    } 
    else
    {
      origin = new PVector(nave_origin.x - (west_end_vault_width / 2) - (vault_width / 2), halfway_y - ((west_end_aisles * vault_height) /2) + (vault_height / 2));
    }
    
    draw_curtained_west_end(origin);
  }
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_towered_west_end(PVector origin)
{
  PVector north_tower_origin = new PVector(origin.x, origin.y);

  if (west_end_aisles > 1)
  {
    north_tower_origin.y -= west_end_vault_height - west_end_stick_out;
  } else
  {
    north_tower_origin.y -= west_end_vault_height * 1.5;
  }  
  draw_tower(north_tower_origin, west_end_vault_width, west_end_vault_height + (west_end_stick_out ), true);

  draw_nave(origin, west_end_vault_width, west_end_vault_height, 1, west_end_aisles, array_aisle_list[west_end_aisles] );  

  PVector south_tower_origin = new PVector(origin.x, origin.y);
  if (west_end_aisles > 1)
  {
    south_tower_origin.y += (west_end_vault_height * (west_end_aisles + 1));
  } 
  else
  {
    south_tower_origin.y += west_end_vault_height * 1.5;
  }  
  draw_tower(south_tower_origin, west_end_vault_width, west_end_vault_height, false);
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_one_vault_end(PVector origin)
{
   draw_tower(origin, vault_height * 2, vault_height * 2, true);
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_curtained_west_end(PVector origin)
{
  if(west_end_aisles == 3)
  {
    draw_nave_matching_west_end(origin);
  }
  else
  {
    draw_nave_non_matching_west_end(origin);
  }
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_nave_matching_west_end(PVector origin)
{
  float current_nave_x = origin.x;
  float current_nave_y = origin.y;
  int m_aisle = array_aisle_list[west_end_aisles];
  
  ArrayList<PVector> pier_points = new ArrayList<PVector>();
    
  if(west_end_aisles > 1)
  {
    draw_outer_aisle(new PVector(current_nave_x, current_nave_y - west_end_stick_out), west_end_vault_width, west_end_vault_height + (west_end_stick_out * 2), 1, 1, 1, false);
    pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y - ((west_end_vault_height + (west_end_stick_out * 2)) / 2) - west_end_stick_out));
    for (int i = 0; i < 1; i++)
    {
      if(i == m_aisle)
      {
        current_nave_y += west_end_vault_height * 1.5;
        draw_vault_arcade(new PVector(current_nave_x, current_nave_y), west_end_vault_width, west_end_vault_height * 2, 1, false);
  
        pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y + west_end_vault_height));
        pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y - west_end_vault_height));
        
        current_nave_y += west_end_vault_height / 2;
      }
      else
      {
        current_nave_y += west_end_vault_height;
        draw_vault_arcade(new PVector(current_nave_x, current_nave_y), west_end_vault_width, west_end_vault_height, 1, false);
        
        if(i > m_aisle)
        {
          pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y + (west_end_vault_height / 2)));
        }
        else
        {
          pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y - (west_end_vault_height / 2)));
        }
      }
    }
    current_nave_y += west_end_vault_height;
    draw_outer_aisle(new PVector(current_nave_x, current_nave_y + west_end_stick_out), west_end_vault_width, west_end_vault_height + (west_end_stick_out * 2), 1, 8, 8, false);
    pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y + ((west_end_vault_height + (west_end_stick_out * 2)) / 2) + west_end_stick_out));
  }
  else
  {
     draw_vault_arcade(new PVector(current_nave_x, current_nave_y), west_end_vault_width, west_end_vault_height * 2, 1, false);
     pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y + (west_end_vault_height / 2)));
     pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y - (west_end_vault_height / 2)));
  }
  
 draw_west_end_piers(pier_points);
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_nave_non_matching_west_end(PVector origin)
{
  west_end_stick_out =0;
  
  float current_nave_x = origin.x;
  float current_nave_y = origin.y;
  int m_aisle = array_aisle_list[west_end_aisles];
  
  ArrayList<PVector> pier_points = new ArrayList<PVector>();
  
  draw_outer_aisle(new PVector(current_nave_x, current_nave_y + (west_end_vault_height * 0.5)), west_end_vault_width, west_end_vault_height * 2, 1, 1, 1, false);
  pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y - ((west_end_vault_height + (west_end_stick_out * 2)) / 2) - west_end_stick_out));
 
  current_nave_y += west_end_vault_height  * 2.5;
  draw_vault_arcade(new PVector(current_nave_x, current_nave_y), west_end_vault_width, west_end_vault_height * 2, 1, false);

  pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y + west_end_vault_height));
  pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y - west_end_vault_height));
  
  current_nave_y += west_end_vault_height;
   
  current_nave_y += west_end_vault_height;
  draw_outer_aisle(new PVector(current_nave_x, current_nave_y + west_end_stick_out), west_end_vault_width, west_end_vault_height * 2, 1, 8, 8, false);
  pier_points.add(new PVector(current_nave_x - (west_end_vault_width / 2), current_nave_y + (west_end_vault_height / 2)));
  
  draw_west_end_piers(pier_points);
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_west_end_piers(ArrayList<PVector> piers)
{
  int mid_point = piers.size() / 2;
  int count = 1;
  for(int i = 0; i < piers.size(); i++)
  {
    if(count == 1)
    {
      draw_west_end_corner_pier(piers.get(i), piers.get(piers.size() - 1));
    }
    else if(count == mid_point)
    {
      draw_west_end_pier(piers.get(i), piers.get(i+1));
    }
    else if(count < mid_point)
    {
      draw_west_end_pier(piers.get(i), piers.get(piers.size() - 1 - i));
    }
    count++;
  }  
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_tower(PVector origin, float tower_width, float tower_height, boolean northern)
{
  float half_width = tower_width / 2;
  float half_height = tower_height /2;

  rect(origin.x, origin.y, tower_width, tower_height);
  rect(origin.x, origin.y, tower_width - (inner_rectangle_inset_width * 2), tower_height - (inner_rectangle_inset_height * 2));

  //Lines for vaulting
  line(origin.x - half_width, origin.y - half_height, origin.x, origin.y);
  line(origin.x + half_width, origin.y - half_height, origin.x, origin.y);
  line(origin.x + half_width, origin.y + half_height, origin.x, origin.y);
  line(origin.x - half_width, origin.y + half_height, origin.x, origin.y);

  fill(0);  

  float wall_thickness = 10;

  PVector top_left = new PVector(origin.x - half_width, origin.y - half_height);
  PVector top_right = new PVector(origin.x + half_width, origin.y - half_height);
  PVector bottom_left = new PVector(origin.x - half_width, origin.y + half_height );
  PVector bottom_right = new PVector(origin.x + half_width, origin.y + half_height );

  float pier_width = 35;

  draw_large_pier(bottom_left, pier_width);
  draw_large_pier(top_right, pier_width);
  draw_large_pier(top_left, pier_width);
  draw_large_pier(bottom_right, pier_width);

  draw_flat_large_pier(new PVector(top_left.x, top_left.y + half_height), pier_width, 4);

  if (northern)
  {      
    draw_flat_large_pier(new PVector(top_left.x + half_width, top_left.y), pier_width, 1);
    draw_flat_small_pier(new PVector(bottom_left.x + half_width, bottom_left.y), pier_width, 3);
  } else
  {      
    draw_flat_large_pier(new PVector(bottom_left.x + half_width, bottom_left.y), pier_width, 3);      
    draw_flat_small_pier(new PVector(top_left.x + half_width, top_left.y), pier_width, 1);
  }

  PVector mid_right = new PVector(top_right.x, top_right.y);
  mid_right.y += half_height;    
  rect(mid_right.x, mid_right.y, wall_thickness, tower_height);

  noFill();
}