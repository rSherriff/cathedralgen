
//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_nave(PVector origin, float n_width, float v_height, float num_vaults, int num_aisles, int m_aisle, int m_ribbing_type, int aisle_ribbing_type)
{    
  float current_nave_x = origin.x;
  float current_nave_y = origin.y;
  
  if(num_aisles > 1)
  {
    draw_outer_aisle(new PVector(current_nave_x, current_nave_y), n_width, v_height, num_vaults, 1, 1, false, ribbing_normal);
    for (int i = 0; i < num_aisles - 2; i++)
    {
      if(i == m_aisle)
      {
        current_nave_y += v_height * 1.5;
        draw_vault_arcade(new PVector(current_nave_x, current_nave_y), n_width, v_height * 2, num_vaults, false, m_ribbing_type);
  
        current_nave_y += v_height / 2;
      }
      else
      {
        current_nave_y += v_height;
        draw_vault_arcade(new PVector(current_nave_x, current_nave_y), n_width, v_height, num_vaults, false,aisle_ribbing_type);
      }
    }
    current_nave_y += v_height;
    draw_outer_aisle(new PVector(current_nave_x, current_nave_y), n_width, v_height, num_vaults, 8, 8, false, ribbing_normal);
  }
  else
  {
     draw_outer_aisle(new PVector(current_nave_x, current_nave_y), n_width, v_height * 2, num_vaults, 0, 9, false, m_ribbing_type);
  }

}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_vault(PVector origin, float vault_width, float vault_height, int pier_placement, int pier_width, int pier_type, int ribbing_type)
{
  float half_vault_width = vault_width / 2;
  float half_vault_height = vault_height / 2;
  float boss_radius = vault_width * 0.05;
  
  //Ellipse at center for the boss
  ellipse(origin.x, origin.y, boss_radius, boss_radius);

  //Container rectangles, outer, then inner
  rect(origin.x, origin.y, vault_width, vault_height);
  rect(origin.x, origin.y, vault_width - (inner_rectangle_inset_width * 2), vault_height - (inner_rectangle_inset_height * 2));

  draw_ribbing(ribbing_type, origin, vault_width, vault_height);
  
  //Piers
  //Pier placement is a bitmask. starts topleft and goes clockwise
  if ((pier_placement & 1) != 0)
  {
    draw_pier(new PVector(origin.x - half_vault_width, origin.y - half_vault_height), pier_type, pier_width);
  }
  if ((pier_placement & 2) != 0)
  {
    draw_pier(new PVector(origin.x + half_vault_width, origin.y - half_vault_height), pier_type, pier_width);
  }
  if ((pier_placement & 4) != 0)
  {
    draw_pier(new PVector(origin.x + half_vault_width, origin.y + half_vault_height), pier_type, pier_width);
  }
  if ((pier_placement & 8)!= 0)
  {
    draw_pier(new PVector(origin.x - half_vault_width, origin.y + half_vault_height), pier_type, pier_width);
  }
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_vault_arcade(PVector origin, float arcade_width, float arcade_height, float number_of_vaults, boolean vertical, int ribbing_type)
{
  float temp_vault_height;
  float temp_vault_width;
  int pier_type = circle_pier;
  int running_columns;
  int terminating_columns = 15;
  
  if(vertical)
  {
    temp_vault_height = arcade_height / number_of_vaults;
    temp_vault_width = arcade_width;
    running_columns = 3;
  }
  else
  {      
    temp_vault_width = arcade_width / number_of_vaults;
    temp_vault_height = arcade_height;
    running_columns = 9;
  }

  for (int i = 0; i < number_of_vaults - 1; i++)
  {
    draw_vault(origin, temp_vault_width, temp_vault_height, running_columns, pillar_width, pier_type, ribbing_type);
    if(vertical)
    {
      origin.y += temp_vault_height;
    }
    else
    {      
      origin.x += temp_vault_width;
    }
  }

  draw_vault(origin, temp_vault_width, temp_vault_height, terminating_columns, pillar_width, pier_type, ribbing_type);
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_crossing_arcade(PVector origin, float arcade_width, float arcade_height, float number_of_vaults, boolean vertical, boolean mid_vault, int m_ribbing_type, int aisle_ribbing_type)
{
  float temp_vault_height;
  float temp_vault_width;
  int pier_type; 
  if(mid_vault)
  {
    pier_type = crossing_pier;
  }
  else
  {
    pier_type = circle_pier;
  }
  
  int terminating_columns = 15;
  
  if(vertical)
  {
    temp_vault_height = arcade_height / number_of_vaults;
    temp_vault_width = arcade_width;
  }
  else
  {      
    temp_vault_width = arcade_width / number_of_vaults;
    temp_vault_height = arcade_height;
  }

  if(!mid_vault)
  {
    draw_vault(origin, temp_vault_width, temp_vault_height, terminating_columns, pillar_width, pier_type, m_ribbing_type);
  }
  else
  {
    if(temp_vault_width - temp_vault_height < 20 && temp_vault_width - temp_vault_height > -20)
    {
     draw_vault(origin, temp_vault_width, temp_vault_height, terminating_columns, pillar_width, pier_type, 4);
    }
    else
    {
      draw_vault(origin, temp_vault_width, temp_vault_height, terminating_columns, pillar_width, pier_type, m_ribbing_type);
    }
  }  
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_outer_aisle(PVector origin, float arcade_width, float arcade_height, float number_of_vaults, int pier_sides, int wall_sides, boolean vertical, int ribbing_type)
{

  float vault_width;
  float vault_height;  
  int pier_type = outer_buttress;
  
  int vault_wall_sides = 0;
  //Side Chapels!
  if(nave_side_chapels)
  {
    if(!vertical)
    {
      vault_wall_sides = 6;   
    }
  }
  
  if(vertical)
  {
    vault_height = arcade_height / number_of_vaults;
    vault_width = arcade_width;
  }
  else
  {      
    vault_width = arcade_width / number_of_vaults;
    vault_height = arcade_height;
  }
  
  for (int i = 0; i < number_of_vaults - 1; i++)
  {
    draw_walled_vault(origin, vault_width, vault_height, pier_sides, pillar_width, pier_type, vault_wall_sides, ribbing_type);
    if(vertical)
    {
      origin.y += vault_height;
    }
    else
    {      
      origin.x += vault_width;
    }
  }

  if (pier_sides == 1)
  {
    if(vertical)
    {
      draw_walled_vault(origin, vault_width, vault_height, 9, pillar_width, pier_type, vault_wall_sides, ribbing_type);
    }
    else
    {
      draw_walled_vault(origin, vault_width, vault_height, 3, pillar_width, pier_type, vault_wall_sides, ribbing_type);
    }
  } 
  else if (pier_sides == 8)
  {
    draw_walled_vault(origin, vault_width, vault_height, 12, pillar_width, pier_type, vault_wall_sides, ribbing_type);
  }
  else if (pier_sides == 2)
  {
    if(vertical)
    {
      draw_walled_vault(origin, vault_width, vault_height, 6, pillar_width, pier_type, vault_wall_sides, ribbing_type);
    }
  }
  else if(pier_sides == 0)
  {
    draw_walled_vault(origin, vault_width, vault_height, 0, pillar_width, pier_type, vault_wall_sides, ribbing_type);
  }
 //<>//
  fill(0);  
  if ((wall_sides & 1) != 0)
  {    
    draw_outisde_wall(new PVector(origin.x - (arcade_width / 2) + (vault_width / 2), origin.y - (vault_height / 2)), arcade_width, pillar_width, number_of_vaults, 1, false);
  }
  if ((wall_sides & 2) != 0)
  {
    draw_outisde_wall(new PVector(origin.x - (vault_width / 2), origin.y - (arcade_height / 2) + (vault_height / 2)), pillar_width, vault_height,number_of_vaults,2,true);
  }
  if ((wall_sides & 4) != 0)
  {
    draw_outisde_wall(new PVector(origin.x + (vault_width / 2), origin.y - (arcade_height / 2) + (vault_height / 2)), pillar_width, vault_height, number_of_vaults,4,true);
  }
  if ((wall_sides & 8)!= 0)
  {
    draw_outisde_wall(new PVector(origin.x - (arcade_width / 2) + (vault_width / 2), origin.y + (vault_height / 2)), arcade_width, pillar_width, number_of_vaults,8,false);
  }
  noFill();
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_walled_vault(PVector origin, float vault_width, float vault_height, int pier_placement, int pier_width, int pier_type, int wall_sides, int ribbing_type)
{
  if(wall_sides == 0)
  {
    draw_vault(origin, vault_width, vault_height, pier_placement, pier_width, pier_type, ribbing_type);
  }
  else
  {
    draw_vault(origin, vault_width, vault_height, pier_placement, pier_width, pier_type, ribbing_type);
  }
  
  fill(0);
  if ((wall_sides & 1) != 0)
  {    
    rect(origin.x - (vault_width / 2) + (interior_wall_width / 2), origin.y - (vault_height / 2), vault_width, interior_wall_width);
  }
  if ((wall_sides & 2) != 0)
  {
    rect(origin.x - (vault_width / 2), origin.y - (vault_height / 2) + (vault_height / 2), interior_wall_width, vault_height);
  }
  if ((wall_sides & 4) != 0)
  {
    rect(origin.x + (vault_width / 2), origin.y - (vault_height / 2) + (vault_height / 2), interior_wall_width, vault_height);
  }
  if ((wall_sides & 8)!= 0)
  {
    rect(origin.x - (vault_width / 2) + (vault_width / 2), origin.y + (vault_height / 2), vault_width, interior_wall_width);
  }
  noFill();
}


//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_cloister(PVector origin, int start_pos, float cloister_width, float cloister_height, float number_of_vaults_wide, float number_of_vaults_high )
{  
  int current_pos = start_pos;
  PVector current_vector = new PVector(origin.x, origin.y);
  for(int i = 0; i < 4; i++)
  {
    if(current_pos == 1)
    {
      if(start_pos != 1)
      {
        draw_ellipse(current_vector); 
      }
      draw_cloister_aisle(current_vector, cloister_width, vault_height, number_of_vaults_wide, 8, 1,  false, (cloister_height / number_of_vaults_high));
      current_vector.y += (vault_height) / 2;
    }
    else if (current_pos == 2)
    {
      if(start_pos != 2)
      {
        current_vector.y += (cloister_height /number_of_vaults_high) / 2;
      }

      draw_cloister_aisle(current_vector, vault_width, cloister_height,  number_of_vaults_high, 8, 4, true, (cloister_width / number_of_vaults_wide));
      current_vector.y += ((cloister_height / number_of_vaults_high) / 2) + (vault_height / 2);
    }
    else if(current_pos == 3)
    {
      if(start_pos != 3)
      {
        current_vector.x -= cloister_width - (cloister_width /number_of_vaults_wide);
      }
      draw_cloister_aisle(current_vector, cloister_width, vault_height, number_of_vaults_wide, 8, 8, false, (cloister_height / number_of_vaults_high));
      current_vector.y -= (vault_height) / 2;
      current_vector.x -= cloister_width - (cloister_width / number_of_vaults_wide);
    }
    else if (current_pos == 4)
    {      
      if(start_pos != 4)
      {
        current_vector.y -= cloister_height - ((cloister_height /number_of_vaults_high) / 2);
      }
      draw_cloister_aisle(current_vector, vault_width, cloister_height,  number_of_vaults_high, 8, 2, true, (cloister_width / number_of_vaults_wide));
      
    }
    
    if(current_pos == 4)
    {
      current_pos = 1;
    }
    else
    {
      current_pos++;
    }
  }
  
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_cloister_aisle(PVector origin, float arcade_width, float arcade_height, float number_of_vaults, int pier_sides, int wall_sides, boolean vertical, float perpendicular_aisle_offset)
{
  float vault_width;
  float vault_height;  
  int pier_type = outer_buttress;
  
  int vault_wall_sides = 0;
  
  if(vertical)
  {
    vault_height = arcade_height / number_of_vaults;
    vault_width = arcade_width;
  }
  else
  {      
    vault_width = arcade_width / number_of_vaults;
    vault_height = arcade_height;
  }
  
  for (int i = 0; i < number_of_vaults - 1; i++)
  {
    draw_walled_vault(origin, vault_width, vault_height, pier_sides, pillar_width, pier_type, vault_wall_sides, ribbing_normal);
    if(vertical)
    {
      origin.y += vault_height;
    }
    else
    {      
      origin.x += vault_width;
    }
  }

  if (pier_sides == 1)
  {
    if(vertical)
    {
      draw_walled_vault(origin, vault_width, vault_height, 16, pillar_width, pier_type, vault_wall_sides, ribbing_normal);
    }
    else
    {
      draw_walled_vault(origin, vault_width, vault_height, 16, pillar_width, pier_type, vault_wall_sides, ribbing_normal);
    }
  } 
  else if (pier_sides == 8)
  {
    draw_walled_vault(origin, vault_width, vault_height, 16, pillar_width, pier_type, vault_wall_sides, ribbing_normal);
  }
  else if (pier_sides == 2)
  {
    if(vertical)
    {
      draw_walled_vault(origin, vault_width, vault_height, 16, pillar_width, pier_type, vault_wall_sides, ribbing_normal);
    }
  }
  
  fill(0);  
  if ((wall_sides & 1) != 0)
  {    
    draw_outisde_wall(new PVector(origin.x - (arcade_width / 2) + (vault_width / 2), origin.y - (vault_height / 2)), arcade_width, pillar_width, number_of_vaults, wall_sides, false);
  }
  if ((wall_sides & 2) != 0)
  {
    PVector wall_origin = new PVector(origin.x - (vault_width / 2), origin.y - ((arcade_height / number_of_vaults) /2) * (number_of_vaults -1));
    draw_outisde_wall(wall_origin, pillar_width, arcade_height + (perpendicular_aisle_offset * 3),number_of_vaults,wall_sides,true);
  }
  if ((wall_sides & 4) != 0)
  {
     PVector wall_origin = new PVector(origin.x + (vault_width / 2), origin.y - ((arcade_height / number_of_vaults) /2) * (number_of_vaults -1));
     draw_outisde_wall(wall_origin, pillar_width, arcade_height + (perpendicular_aisle_offset * 3), number_of_vaults,wall_sides,true);
  }
  if ((wall_sides & 8)!= 0)
  {
    draw_outisde_wall(new PVector(origin.x - (arcade_width / 2) + (vault_width / 2), origin.y + (vault_height / 2)), arcade_width, pillar_width, number_of_vaults,wall_sides,false);
  }
  noFill();
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_boss(PVector origin, float radius)
{
  fill(bg_colour);

  ellipse(origin.x, origin.y, radius, radius);
  
  noFill();
}