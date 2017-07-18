 //<>//


//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
int circle_pier = 0;
int diamond_pier = 1;
int outer_buttress = 2;
int crossing_pier = 3;
int num_pier_types = 4;
void draw_pier(PVector origin, int pier_type, int pier_width)
{
  if (pier_type == circle_pier)
  {
    fill(0);
    ellipse(origin.x, origin.y, pier_width, pier_width);
    noFill();
  } else if (pier_type == diamond_pier)
  {
    fill(0);
    ellipse(origin.x, origin.y, pier_width, pier_width);
    noFill();
  } else if (pier_type == outer_buttress)
  {
    draw_crossing_pier(origin, pier_width);
  } else if (pier_type == crossing_pier)
  {
    draw_crossing_pier(origin, pier_width);
  }
}
void draw_random_pier(PVector origin, int pier_width)
{
  draw_pier(origin, int(random(0, num_pier_types)), pier_width);
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_large_pier(PVector origin, float pier_width)
{    
  rect(origin.x, origin.y, pier_width, pier_width / 3);
  rect(origin.x, origin.y, pier_width / 3, pier_width);
  rect(origin.x, origin.y, pier_width * 0.7, pier_width * 0.5);
  rect(origin.x, origin.y, pier_width * 0.5, pier_width * 0.7);
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
//Flat side = 1,2,3,4 starts top goes clockwise
void draw_flat_large_pier(PVector origin, float pier_width, int flat_side)
{
  float mod1 = 0;
  float mod2 = 0;
  float mod3 = 0;
  float mod4 = 0;
  switch(flat_side)
  {
  case 3:
  case 1:
    mod1 = 3;
    mod2 = 2;
    mod3 = 0.5;
    mod4 = 0.7;    
    rect(origin.x, origin.y, pier_width / mod1, pier_width / mod2);
    rect(origin.x, origin.y, pier_width, pier_width / mod1);
    break;
  case 2:
  case 4:
    mod1 = 2;
    mod2 = 3;
    mod3 = 0.7;
    mod4 = 0.5; 
    rect(origin.x, origin.y, pier_width / mod1, pier_width / mod2);
    rect(origin.x, origin.y, pier_width / mod2, pier_width);
    break;
  } 

  rect(origin.x, origin.y, pier_width * mod3, pier_width * mod4);
  rect(origin.x, origin.y, pier_width * mod4, pier_width * mod3);
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_flat_small_pier(PVector origin, float pier_width, int flat_side)
{
  switch(flat_side)
  {
  case 1:
    rect(origin.x, origin.y + pier_width / 9, pier_width / 2, pier_width / 3);
    rect(origin.x, origin.y, pier_width / 3, pier_width / 2);
    break;
  case 2: 
    break;
  case 3:
    rect(origin.x, origin.y - pier_width / 9, pier_width / 2, pier_width / 3);
    rect(origin.x, origin.y, pier_width / 3, pier_width / 2);
    break;
  case 4:
    break;
  }
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_outside_buttress(PVector origin, float pier_width, int flat_side)
{     
  strokeWeight(buttress_size);
  strokeCap(PROJECT);

  PVector buttress_end = new PVector(0, 0);
  PVector buttress_projection = new PVector(0, 0);    

  if ((flat_side & 1) != 0)
  {    
    buttress_end = find_point_on_circle(origin, buttress_length, PI + HALF_PI);
    buttress_projection = move_towards(new PVector(buttress_end.x, buttress_end.y), origin, -(buttress_length));
  }
  if ((flat_side & 2) != 0)
  {
    buttress_end = find_point_on_circle(origin, buttress_length, PI);
    buttress_projection = find_point_on_circle(origin, buttress_length + (buttress_length / 2), PI);
  }
  if ((flat_side & 4) != 0)
  {
    buttress_end = find_point_on_circle(origin, buttress_length, 0);
    buttress_projection = find_point_on_circle(origin, buttress_length + (buttress_length / 2), 0);
  }
  if ((flat_side & 8)!= 0)
  {
    buttress_end = find_point_on_circle(origin, buttress_length, HALF_PI);
    buttress_projection = find_point_on_circle(origin, buttress_length + (buttress_length), HALF_PI);
  }

  line(origin.x, origin.y, buttress_end.x, buttress_end.y);

  strokeWeight(buttress_size / 2);
  line(buttress_end.x, buttress_end.y, buttress_projection.x, buttress_projection.y);

  strokeCap(ROUND);
  strokeWeight(1);
}


//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_crossing_pier(PVector origin, int pier_width)
{      
  fill(0);

  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(45));
  rect(0, 0, pier_width, pier_width);
  popMatrix();

  rect(origin.x, origin.y, pier_width * 0.9, pier_width * 0.9);

  noFill();
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_west_end_pier(PVector top_pier, PVector bottom_pier)
{
  fill(0);

  int west_end_pier_types = 2;
  int type_percentage = 100 / (west_end_pier_types );
  float west_end_pier_chance = random(0, 100); 

  //NotreDame/Laon Style
  if (west_end_pier_chance < type_percentage)
  {
    float pier_height = random(25, 50);
    float base_width = random(10, 20);
    float triangle_width = random(25, 40);
    float buttress_chance = random(0, 100); 

    for (int j = 0; j <= 1; j++)
    {    
      PVector current_pier;
      if (j == 0)
      {
        current_pier = top_pier;
      } else
      {
        current_pier = bottom_pier;
      }

      rect(current_pier.x, current_pier.y, base_width, pier_height);

      PVector triangle_top = new PVector(current_pier.x - (base_width / 2), current_pier.y - (pier_height / 2));
      PVector triangle_meeting = new PVector(current_pier.x - triangle_width, current_pier.y );
      PVector triangle_bottom = new PVector(current_pier.x - (base_width / 2), current_pier.y + (pier_height / 2));
      triangle(triangle_top.x, triangle_top.y, triangle_meeting.x, triangle_meeting.y, triangle_bottom.x, triangle_bottom.y);

      int number_vaults = int(random(5, 8));
      PVector top_vault;
      PVector bottom_vault;
      float line_length = PVector.sub(triangle_top, triangle_meeting).mag();
      float move_radius = line_length / number_vaults;
      float vault_radius = move_radius * 0.8;
      for (int i = 0; i < number_vaults; i++)
      {
        top_vault = move_towards(triangle_top, triangle_meeting, move_radius );
        bottom_vault = move_towards(triangle_bottom, triangle_meeting, move_radius );
        ellipse(top_vault.x, top_vault.y, vault_radius, vault_radius);
        ellipse(bottom_vault.x, bottom_vault.y, vault_radius, vault_radius);
      }

      if (buttress_chance < 25)
      {
        float half_buttress_length = random((triangle_width / 2) * 0.5, triangle_width / 2);
        PVector butress_origin = new PVector(current_pier.x - triangle_width, current_pier.y);

        rect(butress_origin.x, butress_origin.y, half_buttress_length * 2, pier_height / 3);
      }
    }
  } else if (west_end_pier_chance < type_percentage * 2)
  {
    int num_images = 3;      
    int image_number = int(random(1, num_images+1));

    float dimensions = random(75, 90);

    for (int j = 0; j <= 1; j++)
    {    
      PVector current_pier;      
      PImage pier_image;

      pier_image = loadImage("west_end_pier_" + image_number + ".png");
      pushMatrix();

      if (j == 0)
      {
        current_pier = top_pier;
        translate(current_pier.x, current_pier.y);   
        image(pier_image, 0, 0, dimensions, dimensions);
      } else
      {
        current_pier = bottom_pier;
        scale(1, -1);
        translate(current_pier.x, -current_pier.y);    
        image(pier_image, 0, 0, dimensions, -dimensions);
      }  

      popMatrix();
    }
  }
  //Salisbury/Worchester Style
  else
  {
    int max_width_height = 50;
    int min_width_height = 40;

    float west_end_pier_width = random(min_width_height, max_width_height);
    float west_end_pier_height = random(min_width_height, max_width_height);
    int shape_count = int(random(1, 5));
    float master_current_width = random(min_width_height * 0.7, min_width_height);

    ArrayList<PVector> shape_origins = new ArrayList<PVector>();
    float[] shape_chances = new float[shape_count];
    for (int i = 0; i < shape_count; i++)
    {
      shape_chances[i] = random(0, 100);
      shape_origins.add(new PVector(random(-max_width_height + master_current_width, max_width_height - master_current_width), random(-max_width_height + master_current_width, max_width_height - master_current_width)));
    }

    for (int j = 0; j <= 1; j++)
    {    
      float current_width = master_current_width;
      int scaler;
      PVector current_pier;
      if (j == 0)
      {
        scaler = 1;
        current_pier = top_pier;
      } else
      {
        scaler = -1;
        current_pier = bottom_pier;
      }
      pushMatrix();
      translate(current_pier.x, current_pier.y);
      rect(0, 0, west_end_pier_width, 20);
      rect(0, 0, 20, west_end_pier_height);  


      int shape_number = 4;
      int shape_percentage = 100 / (shape_number );       

      for (int i = 0; i < shape_count; i++)
      {
        float shape_chance = shape_chances[i];

        PVector shape_origin = shape_origins.get(i);
        shape_origin.y *= scaler;

        if (shape_chance < shape_percentage)
        {
          rect(shape_origin.x, shape_origin.y, current_width, current_width * scaler);
        } else if (shape_chance < shape_percentage * 2)
        {
          ellipse(shape_origin.x, shape_origin.y, current_width, current_width* scaler);
        } else if (shape_chance < shape_percentage * 3)
        {
          rect(shape_origin.x, shape_origin.y, random(0, current_width), random(0, current_width)* scaler);
        } else if (shape_chance < shape_percentage * 4)
        {
          rect(shape_origin.x, shape_origin.y, current_width, current_width);
        }

        current_width *= 0.9;
      }    
      popMatrix();
    }
  }

  noFill();
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_west_end_corner_pier(PVector top_pier, PVector bottom_pier)
{
  fill(0);

  int west_end_pier_types = 2;
  int type_percentage = 100 / (west_end_pier_types );
  float west_end_pier_chance = random(0, 100); 

  //NotreDame/Laon Style
  if (west_end_pier_chance < 0)
  {
    float pier_height = random(25, 50);
    float base_width = random(10, 20);
    float triangle_width = random(25, 40);
    float buttress_chance = random(0, 100); 

    for (int j = 0; j <= 1; j++)
    {    
      PVector current_pier;
      if (j == 0)
      {
        current_pier = top_pier;
      } else
      {
        current_pier = bottom_pier;
      }

      rect(current_pier.x, current_pier.y, base_width, pier_height);

      PVector triangle_top = new PVector(current_pier.x - (base_width / 2), current_pier.y - (pier_height / 2));
      PVector triangle_meeting = new PVector(current_pier.x - triangle_width, current_pier.y );
      PVector triangle_bottom = new PVector(current_pier.x - (base_width / 2), current_pier.y + (pier_height / 2));
      triangle(triangle_top.x, triangle_top.y, triangle_meeting.x, triangle_meeting.y, triangle_bottom.x, triangle_bottom.y);

      int number_vaults = int(random(5, 8));
      PVector top_vault;
      PVector bottom_vault;
      float line_length = PVector.sub(triangle_top, triangle_meeting).mag();
      float move_radius = line_length / number_vaults;
      float vault_radius = move_radius * 0.8;
      for (int i = 0; i < number_vaults; i++)
      {
        top_vault = move_towards(triangle_top, triangle_meeting, move_radius );
        bottom_vault = move_towards(triangle_bottom, triangle_meeting, move_radius );
        ellipse(top_vault.x, top_vault.y, vault_radius, vault_radius);
        ellipse(bottom_vault.x, bottom_vault.y, vault_radius, vault_radius);
      }

      if (buttress_chance < 25)
      {
        float half_buttress_length = random((triangle_width / 2) * 0.5, triangle_width / 2);
        PVector butress_origin = new PVector(current_pier.x - triangle_width, current_pier.y);

        rect(butress_origin.x, butress_origin.y, half_buttress_length * 2, pier_height / 3);
      }
    }
  }
  //Salisbury/Worchester Style
  else if (west_end_pier_chance < type_percentage * 2)
  {
    int num_images = 2;      
    int image_number = int(random(1, num_images+1));

    float dimensions = random(100,150);

    for (int j = 0; j <= 1; j++)
    {    
      PVector current_pier;      
      PImage pier_image;

      pier_image = loadImage("west_end_corner_" + image_number + ".png");
      pushMatrix();

      if (j == 0)
      {
        current_pier = top_pier;
        translate(current_pier.x - (dimensions * 0.25), current_pier.y);   
        image(pier_image, 0, 0, dimensions, dimensions);
      } else
      {
        current_pier = bottom_pier;
        scale(1, -1);
        translate(current_pier.x - (dimensions * 0.25), -current_pier.y );    
        image(pier_image, 0, 0, dimensions, -dimensions);
      }  

      popMatrix();
    }
  }

  noFill();
}