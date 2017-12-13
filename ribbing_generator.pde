
//Ribbing types
int ribbing_normal = 1;
int ribbing_quadripartite = 2;
int ribbing_tierceron = 3;
int ribbing_lierne = 4;

void draw_ribbing(int type, PVector origin, float vault_width, float vault_height)
{
  if(type == ribbing_normal || type == 0)
  {
    draw_normal_ribbing( origin, vault_width, vault_height);
  }
  else if(type == ribbing_quadripartite)
  {
    draw_quadripartite_ribbing( origin, vault_width, vault_height);
  }
  else if(type == ribbing_tierceron)
  {
    draw_tierceron_ribbing( origin, vault_width, vault_height);
  }
  else if(type == ribbing_lierne)
  {
    draw_lierne_ribbing( origin, vault_width, vault_height);
  }
}

void draw_normal_ribbing( PVector origin, float vault_width, float vault_height)
{
  float half_vault_width = vault_width / 2;
  float half_vault_height = vault_height / 2;
  float boss_radius = vault_width * 0.05;
  
  PVector ne_line_terminus = find_point_on_circle(origin, boss_radius / 2, PI + QUARTER_PI);
  PVector nw_line_terminus = find_point_on_circle(origin, boss_radius / 2, PI + HALF_PI + QUARTER_PI);
  PVector se_line_terminus = find_point_on_circle(origin, boss_radius / 2, QUARTER_PI);
  PVector sw_line_terminus = find_point_on_circle(origin, boss_radius / 2, HALF_PI + QUARTER_PI);
  
  line(origin.x - half_vault_width, origin.y - half_vault_height, ne_line_terminus.x, ne_line_terminus.y);
  line(origin.x + half_vault_width, origin.y - half_vault_height, nw_line_terminus.x, nw_line_terminus.y);
  line(origin.x + half_vault_width, origin.y + half_vault_height, se_line_terminus.x, se_line_terminus.y);
  line(origin.x - half_vault_width, origin.y + half_vault_height, sw_line_terminus.x, sw_line_terminus.y);
}

void draw_quadripartite_ribbing( PVector origin, float vault_width, float vault_height)
{
  float half_vault_width = vault_width / 2;
  float half_vault_height = vault_height / 2;
  float boss_radius = vault_width * 0.05;
  PVector ne_line_terminus = find_point_on_circle(origin, boss_radius / 2, PI + QUARTER_PI);
  PVector nw_line_terminus = find_point_on_circle(origin, boss_radius / 2, PI + HALF_PI + QUARTER_PI);
  PVector se_line_terminus = find_point_on_circle(origin, boss_radius / 2, QUARTER_PI);
  PVector sw_line_terminus = find_point_on_circle(origin, boss_radius / 2, HALF_PI + QUARTER_PI);
  
  line(origin.x - half_vault_width, origin.y - half_vault_height, ne_line_terminus.x, ne_line_terminus.y);
  line(origin.x + half_vault_width, origin.y - half_vault_height, nw_line_terminus.x, nw_line_terminus.y);
  line(origin.x + half_vault_width, origin.y + half_vault_height, se_line_terminus.x, se_line_terminus.y);
  line(origin.x - half_vault_width, origin.y + half_vault_height, sw_line_terminus.x, sw_line_terminus.y);
  line(origin.x - half_vault_width, origin.y, origin.x + half_vault_width, origin.y);
  line(origin.x, origin.y + half_vault_height, origin.x, origin.y - half_vault_height);  
}

void draw_tierceron_ribbing( PVector origin, float vault_width, float vault_height)
{
  float half_vault_width = vault_width / 2;
  float half_vault_height = vault_height / 2;
  float boss_radius = vault_width * 0.05;  
  
  PVector ne_line_terminus = find_point_on_circle(origin, boss_radius / 2, PI + QUARTER_PI);
  PVector nw_line_terminus = find_point_on_circle(origin, boss_radius / 2, PI + HALF_PI + QUARTER_PI);
  PVector se_line_terminus = find_point_on_circle(origin, boss_radius / 2, QUARTER_PI);
  PVector sw_line_terminus = find_point_on_circle(origin, boss_radius / 2, HALF_PI + QUARTER_PI);
  
  //Cross ribs
    line(origin.x - half_vault_width, origin.y, origin.x + half_vault_width, origin.y);
    line(origin.x, origin.y + half_vault_height, origin.x, origin.y - half_vault_height);
    
    PVector[] top_bosses =  new PVector[2];
    PVector[] bottom_bosses =  new PVector[2];
    PVector[] left_bosses =  new PVector[2];
    PVector[] right_bosses =  new PVector[3];
    
    float vertical_rib_section_length = vault_height / 6;
    top_bosses[0] = new PVector(origin.x, origin.y - vertical_rib_section_length);
    top_bosses[1] = new PVector(origin.x, origin.y - (vertical_rib_section_length * 2));
      
    bottom_bosses[0] = new PVector(origin.x, origin.y + vertical_rib_section_length);
    bottom_bosses[1] = new PVector(origin.x, origin.y + (vertical_rib_section_length * 2));
      
    float horizontal_rib_section_length = vault_width / 4;
    left_bosses[0] = new PVector(origin.x - horizontal_rib_section_length, origin.y);
    left_bosses[1] = new PVector(origin.x - (horizontal_rib_section_length * 2), origin.y);
      
    right_bosses[0] = new PVector(origin.x + horizontal_rib_section_length, origin.y);
    right_bosses[1] = new PVector(origin.x + (horizontal_rib_section_length * 2), origin.y);
    
    for(int i = 0; i < 2; i++)
    {
      line(origin.x - half_vault_width, origin.y - half_vault_height, top_bosses[i].x, top_bosses[i].y);
      line(origin.x + half_vault_width, origin.y - half_vault_height, top_bosses[i].x, top_bosses[i].y);
      
      line(origin.x - half_vault_width, origin.y + half_vault_height, bottom_bosses[i].x, bottom_bosses[i].y);
      line(origin.x + half_vault_width, origin.y + half_vault_height, bottom_bosses[i].x, bottom_bosses[i].y);
      
      line(origin.x - half_vault_width, origin.y - half_vault_height, left_bosses[i].x, left_bosses[i].y);      
      line(origin.x - half_vault_width, origin.y + half_vault_height, left_bosses[i].x, left_bosses[i].y);
      
      line(origin.x + half_vault_width, origin.y - half_vault_height, right_bosses[i].x, right_bosses[i].y);      
      line(origin.x + half_vault_width, origin.y + half_vault_height, right_bosses[i].x, right_bosses[i].y);
      
      line(origin.x - half_vault_width, origin.y - half_vault_height, ne_line_terminus.x, ne_line_terminus.y);
      line(origin.x + half_vault_width, origin.y - half_vault_height, nw_line_terminus.x, nw_line_terminus.y);
      line(origin.x + half_vault_width, origin.y + half_vault_height, se_line_terminus.x, se_line_terminus.y);
      line(origin.x - half_vault_width, origin.y + half_vault_height, sw_line_terminus.x, sw_line_terminus.y);
      
      draw_boss(top_bosses[i], boss_radius);
      draw_boss(bottom_bosses[i], boss_radius);
      draw_boss(left_bosses[i], boss_radius);
      draw_boss(right_bosses[i], boss_radius);
    }
}

void draw_lierne_ribbing( PVector origin, float vault_width, float vault_height)
{
  float half_vault_width = vault_width / 2;
  float half_vault_height = vault_height / 2;
  float boss_radius = vault_width * 0.05;
  
  PVector ne_line_terminus = find_point_on_circle(origin, boss_radius / 2, PI + QUARTER_PI);
  PVector nw_line_terminus = find_point_on_circle(origin, boss_radius / 2, PI + HALF_PI + QUARTER_PI);
  PVector se_line_terminus = find_point_on_circle(origin, boss_radius / 2, QUARTER_PI);
  PVector sw_line_terminus = find_point_on_circle(origin, boss_radius / 2, HALF_PI + QUARTER_PI);
  
  line(origin.x - half_vault_width, origin.y - half_vault_height, ne_line_terminus.x, ne_line_terminus.y);
    line(origin.x + half_vault_width, origin.y - half_vault_height, nw_line_terminus.x, nw_line_terminus.y);
    line(origin.x + half_vault_width, origin.y + half_vault_height, se_line_terminus.x, se_line_terminus.y);
    line(origin.x - half_vault_width, origin.y + half_vault_height, sw_line_terminus.x, sw_line_terminus.y);
    line(origin.x - half_vault_width, origin.y, origin.x + half_vault_width, origin.y);
    line(origin.x, origin.y + half_vault_height, origin.x, origin.y - half_vault_height);
    
    float current_angle = 0;
    float adjust_angle = radians(360 / 8);
    PVector boss_point = find_point_on_circle(origin, vault_width/4, current_angle);
    current_angle += adjust_angle;
    draw_boss(boss_point, boss_radius);
    line(boss_point.x, boss_point.y, origin.x + half_vault_width, origin.y - half_vault_height);
    line(boss_point.x, boss_point.y, origin.x + half_vault_width, origin.y + half_vault_height);
    
    PVector new_boss_point = find_point_on_circle(origin, vault_width/4, current_angle);
    line(new_boss_point.x, new_boss_point.y, boss_point.x, boss_point.y);
    boss_point = new_boss_point;
    current_angle += adjust_angle;
    draw_boss(boss_point, boss_radius);
    
    new_boss_point = find_point_on_circle(origin, vault_width/4, current_angle);
    line(new_boss_point.x, new_boss_point.y, boss_point.x, boss_point.y);
    boss_point = new_boss_point;
    current_angle += adjust_angle;
    draw_boss(boss_point, boss_radius);
    line(boss_point.x, boss_point.y, origin.x + half_vault_width, origin.y + half_vault_height);
    line(boss_point.x, boss_point.y, origin.x - half_vault_width, origin.y + half_vault_height);
    
    new_boss_point = find_point_on_circle(origin, vault_width/4, current_angle);
    line(new_boss_point.x, new_boss_point.y, boss_point.x, boss_point.y);
    boss_point = new_boss_point;
    current_angle += adjust_angle;
    draw_boss(boss_point, boss_radius);
    
    new_boss_point = find_point_on_circle(origin, vault_width/4, current_angle);
    line(new_boss_point.x, new_boss_point.y, boss_point.x, boss_point.y);
    boss_point = new_boss_point;
    current_angle += adjust_angle;
    draw_boss(boss_point, boss_radius);
    line(boss_point.x, boss_point.y, origin.x - half_vault_width, origin.y + half_vault_height);
    line(boss_point.x, boss_point.y, origin.x - half_vault_width, origin.y - half_vault_height);
    
    new_boss_point = find_point_on_circle(origin, vault_width/4, current_angle);
    line(new_boss_point.x, new_boss_point.y, boss_point.x, boss_point.y);
    boss_point = new_boss_point;
    current_angle += adjust_angle;
    draw_boss(boss_point, boss_radius);
    
    new_boss_point = find_point_on_circle(origin, vault_width/4, current_angle);
    line(new_boss_point.x, new_boss_point.y, boss_point.x, boss_point.y);
    boss_point = new_boss_point;
    current_angle += adjust_angle;
    draw_boss(boss_point, boss_radius);
    line(boss_point.x, boss_point.y, origin.x - half_vault_width, origin.y - half_vault_height);
    line(boss_point.x, boss_point.y, origin.x + half_vault_width, origin.y - half_vault_height);
    
    new_boss_point = find_point_on_circle(origin, vault_width/4, current_angle);
    line(new_boss_point.x, new_boss_point.y, boss_point.x, boss_point.y);
    boss_point = new_boss_point;
    current_angle += adjust_angle;
    draw_boss(boss_point, boss_radius);
    
    new_boss_point = find_point_on_circle(origin, vault_width/4, current_angle);
    line(new_boss_point.x, new_boss_point.y, boss_point.x, boss_point.y);
    boss_point = new_boss_point;
    current_angle += adjust_angle;
    draw_boss(boss_point, boss_radius);
}