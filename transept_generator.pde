
//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_north_transept(PVector origin, Boolean final_transept)
{
  float x_origin = origin.x;  
  float y_origin = origin.y;

  draw_north_transept_end(origin);
  
  y_origin += vault_height;
  
  
  int meet_nave_row = number_transpet_vault - ((number_of_aisles - 1) / 2);
  int meet_choir_row = number_transpet_vault - ((number_of_choir_aisles - 1) / 2);    
  
  if(vaults_wide_transpet == 1)
  {
    meet_nave_row--;
    meet_choir_row--;
  }
  
  if(!final_transept)
  {
    meet_choir_row = meet_nave_row;
  }
  
  for(int j = 0; j < number_transpet_vault - 1; j++)
  {
    for(int i = 0; i < vaults_wide_transpet; i++)
    {
      float transept_vault_width;
      if(i == mid_transept_aisle)
      {
        transept_vault_width = vault_width * 2;
      }
      else
      {
        transept_vault_width = vault_width;
      }
            
      int wall_sides =0;
     
      
      if(i == 0 && j < meet_nave_row)
      {
        wall_sides += 2;
      }
      
      if (i == vaults_wide_transpet - 1 && j < meet_choir_row)
      {
        wall_sides += 4;
      }
     
      
      draw_outer_aisle(new PVector(x_origin,y_origin), transept_vault_width, vault_height, 1, 1, wall_sides, true);
              
      if( (i + 1) == mid_transept_aisle)
      {
         x_origin +=  vault_width * 1.5;
      }
      else if ( i == mid_transept_aisle)
      {
         x_origin +=   vault_width *1.5;
      }
      else
      {
          x_origin += vault_width;
      }         
    }
    
    y_origin += vault_height;
    x_origin = origin.x;
  }
}



//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_south_transept(PVector origin, Boolean final_transept)
{
  float x_origin = origin.x;  
  float y_origin = origin.y;
  
  draw_south_transept_end(origin);
  
  y_origin -= vault_height;
  
  int meet_nave_row = number_transpet_vault - ((number_of_aisles - 1) / 2) ;
  int meet_choir_row = number_transpet_vault - ((number_of_choir_aisles - 1) / 2) ;  
  
  if(vaults_wide_transpet == 1)
  {
    meet_nave_row--;
    meet_choir_row--;
  }
  
  if(!final_transept)
  {
    meet_choir_row = meet_nave_row;
  }
  
  for(int j = 0; j < number_transpet_vault - 1; j++)
  {
    for(int i = 0; i < vaults_wide_transpet; i++)
    {
      float transept_vault_width;
      if(i == mid_transept_aisle)
      {
        transept_vault_width = vault_width * 2;
      }
      else
      {
        transept_vault_width = vault_width;
      }
            
      int wall_sides =0;      
      if(i == 0 && j < meet_nave_row)
      {
        wall_sides += 2;
      }
      
      if (i == vaults_wide_transpet - 1 && j < meet_choir_row)
      {
        wall_sides += 4;
      }
      
      draw_outer_aisle(new PVector(x_origin,y_origin), transept_vault_width, vault_height, 1, 1, wall_sides, true);
              
      if( (i + 1) == mid_transept_aisle)
      {
         x_origin +=  vault_width * 1.5;
      }
      else if ( i == mid_transept_aisle)
      {
         x_origin +=   vault_width *1.5;
      }
      else
      {
          x_origin += vault_width;
      }         
    }
    
    y_origin -= vault_height;
    x_origin = origin.x;
  }
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_north_transept_end(PVector origin)
{
    float x_origin = origin.x;  
  float y_origin = origin.y;
  for(int i = 0; i < vaults_wide_transpet; i++)
    {
      float transept_vault_width;
      if(i == mid_transept_aisle)
      {
        transept_vault_width = vault_width * 2;
      }
      else
      {
        transept_vault_width = vault_width;
      }
            
      int wall_sides = 1;
      if(i == 0)
      {
        wall_sides += 2;
      }
      
      if(i == vaults_wide_transpet - 1)
      {
        wall_sides += 4;
      }      
      
      draw_outer_aisle(new PVector(x_origin,y_origin), transept_vault_width, vault_height, 1, 1, wall_sides, true);
              
      if( (i + 1) == mid_transept_aisle)
      {
         x_origin +=  vault_width * 1.5;
      }
      else if ( i == mid_transept_aisle)
      {
         x_origin +=   vault_width *1.5;
      }
      else
      {
          x_origin += vault_width;
      }
    }
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_south_transept_end(PVector origin)
{
    float x_origin = origin.x;  
  float y_origin = origin.y;
  for(int i = 0; i < vaults_wide_transpet; i++)
    {
      float transept_vault_width;
      if(i == mid_transept_aisle)
      {
        transept_vault_width = vault_width * 2;
      }
      else
      {
        transept_vault_width = vault_width;
      }
            
      int wall_sides = 8;
      if(i == 0)
      {
        wall_sides += 2;
      }
      
      if(i == vaults_wide_transpet - 1)
      {
        wall_sides += 4;
      }      
      
      draw_outer_aisle(new PVector(x_origin,y_origin), transept_vault_width, vault_height, 1, 1, wall_sides, true);
              
      if( (i + 1) == mid_transept_aisle)
      {
         x_origin +=  vault_width * 1.5;
      }
      else if ( i == mid_transept_aisle)
      {
         x_origin +=   vault_width *1.5;
      }
      else
      {
          x_origin += vault_width;
      }
    }
}