 //<>//
float window_width = 300;
float window_height = 250;
float main_arch_height = 200; 

float my_width = 1700;
float my_height = 1000;
float halfway_x = my_width / 2;
float halfway_y = my_height /2;

int bg_colour = 200;

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void setup() 
{
  imageMode(CENTER);
  rectMode(CENTER);
  size(1700, 1100);
  stroke(0);
  noFill();

  //draw_pier(new PVector(100, halfway_y), 2, 1000);
  //draw_vault(new PVector(100, halfway_y), 100, 100,  8, 15, 0);
  //draw_cloister(new PVector(300,300), 1, vault_width * cloister_vaults, vault_width * cloister_vaults, cloister_vaults, cloister_vaults - 2);
  //draw_chapter_house(new PVector(width/2, height/2), 8, 100, 0);

  setup_cathedral();
  draw_cathedral();
}

int[] array_aisle_list = {0, 0, 0, 0, 0, 1, 0, 2,2,2,2};
int num_possible_aisles = 2;
int[] possible_aisles = {1, 3, 5};

int num_possible_choir_aisles = 2;
int[] possible_choir_aisles = {1, 3, 5, 7};

int[] transept_aisle_list = {0, 0, 0, 1,0,2};
int[] possible_transepts = {1,3,5};
int num_possible_transepts = 2;

int number_of_aisles;
int mid_aisle;

int number_of_choir_aisles;  
int mid_choir_aisle;

float nave_height = number_of_aisles * 100;
float nave_width = 350;

float choir_width = nave_width / 2;

int inner_rectangle_inset_width = 5;
int inner_rectangle_inset_height = 5;

float number_of_vaults = 0;
float vault_height = nave_height / (number_of_aisles +1);
float vault_width = nave_width / number_of_vaults;

int pillar_width = inner_rectangle_inset_height * 3;
float buttress_size = 0;
float buttress_length = 0;

int number_of_choir_vaults;

int number_transpet_vault = int(random(1, 3)) + (min(number_of_aisles, number_of_choir_aisles) / 2);
int vaults_wide_transpet ;
int vaults_high_crossing ;
int mid_transept_aisle ;

float west_end_height = nave_height;
float west_end_vault_height = vault_height;
float west_end_vault_width = vault_width;  
float west_end_stick_out = random(10,35);

float ambalatory_side_chapel_chance = 50;
float aisle_side_chapel_chance = 50;

PVector nave_origin;
PVector cloister_origin;
PVector crossing_origin;
PVector choir_origin;
PVector apse_origin;  
PVector north_transept_origin;
PVector south_transept_origin;

int transept_number_chance;
int transept_number;

int interior_wall_width = 8;

int west_end_aisles;

float cloister_vaults;

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void setup_cathedral()
{
  transept_number_chance = int(random(0, 100));  
  if (transept_number_chance < 50)
  {
    transept_number = 1;
  } 
  else if (transept_number_chance < 100)
  {
    transept_number = 2;
  } 

  number_of_aisles = possible_aisles[int(random(0, num_possible_aisles))];
  mid_aisle = array_aisle_list[number_of_aisles];

  while( number_of_choir_aisles < number_of_aisles)
  {
    number_of_choir_aisles = possible_choir_aisles[int(random(0, num_possible_choir_aisles))];   
    mid_choir_aisle = array_aisle_list[number_of_choir_aisles];
  }

  number_of_vaults = int(random(3, 8));

  nave_height = number_of_aisles * 100;
  nave_width = number_of_vaults * 60;  

  vault_height = nave_height / (number_of_aisles +1);
  vault_width = nave_width / number_of_vaults;

  pillar_width = inner_rectangle_inset_height * 3;
  buttress_size = random(12, 35);
  buttress_length = 500/buttress_size;

  number_of_choir_vaults = int(number_of_vaults /2);
  choir_width = vault_width * number_of_choir_vaults;

  number_transpet_vault = int(random(1, 3)) + (min(number_of_aisles, number_of_choir_aisles) / 2);
  vaults_wide_transpet = possible_transepts[int(random(0, num_possible_transepts))];
  vaults_high_crossing = vaults_wide_transpet;
  mid_transept_aisle = transept_aisle_list[vaults_wide_transpet];

  west_end_height = nave_height;
  west_end_vault_height = vault_height;
  west_end_vault_width = vault_width * 2;  
  west_end_stick_out = random(10,35);

  ambalatory_side_chapel_chance = 50;
  aisle_side_chapel_chance = 0;

  if(number_of_aisles > 1)
  {
    nave_origin = new PVector(250, halfway_y - ((number_of_aisles * vault_height) /2) );
  }
  else
  {
     nave_origin = new PVector(250, halfway_y);
  }
  
  cloister_origin = new PVector(nave_origin.x, nave_origin.y + nave_height + vault_height);  
  crossing_origin= new PVector((nave_origin.x + nave_width) + ((vaults_wide_transpet * vault_width) / 2), halfway_y);  
  choir_origin= new PVector(crossing_origin.x + (((vaults_wide_transpet) * vault_width) / 2) + vault_width, halfway_y - ((number_of_choir_aisles * vault_height) /2));
  apse_origin= new PVector(choir_origin.x +  ( (number_of_choir_vaults) * vault_width), crossing_origin.y);

  if(vaults_wide_transpet > 1)
  {
    north_transept_origin = new PVector((nave_origin.x + number_of_vaults * vault_width), crossing_origin.y - ((vaults_high_crossing * vault_height)  / 2) - (number_transpet_vault * vault_height));
  }
  else
  {
    north_transept_origin = new PVector((nave_origin.x + (number_of_vaults * vault_width) + (vault_width / 2) ), crossing_origin.y - ((vaults_high_crossing * vault_height)  / 2) - (number_transpet_vault * vault_height));
  }
  south_transept_origin = new PVector(north_transept_origin.x, crossing_origin.y + ((vaults_high_crossing * vault_height)  / 2) + (number_transpet_vault * vault_height));

  cloister_vaults = number_of_vaults - 1;
}

void draw() 
{ 
  // keep draw() here to continue looping while waiting for keys
}
int sides = 5;
//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void keyPressed() 
{
  if (key == 10)
  { 
    background(bg_colour);
    setup_cathedral();
    draw_cathedral();

    //pushMatrix();
    //translate(0,  0);
    //translate(width/2,  height/2);
    //rotate(radians(int(random(0,360))));
    //draw_chapter_house(new PVector(0,0), int(random(6, 10)), 100, 0);
    //popMatrix();
  }
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_cathedral()
{ 
  println("nave_height:  " + nave_height);
  println("vault_height: " + vault_height);
  println("west_end_vault_height: " + west_end_vault_height);
  println("vault_width: " + vault_width );
  println("number_of_aisles: " + number_of_aisles );
  println("mid_aisle: " + mid_aisle );
  println("number_transpet_vault: " + number_transpet_vault );
  println("number_of_choir_vaults: " + number_of_choir_vaults );

  //West End
  draw_west_end();
  
  //Nave
  draw_nave(nave_origin, nave_width, vault_height, number_of_vaults, number_of_aisles, mid_aisle);

  for (int i = 1; i <= transept_number; i++)
  {
    north_transept_origin.y = crossing_origin.y - ((vaults_high_crossing * vault_height)  / 2) - (number_transpet_vault * vault_height);
    south_transept_origin.y = crossing_origin.y + ((vaults_high_crossing * vault_height)  / 2) + (number_transpet_vault * vault_height);

    PVector extra_nave_origin;
    if(number_of_aisles > 1)
    {
      extra_nave_origin = new PVector(choir_origin.x, halfway_y - ((number_of_aisles * vault_height) /2));
    }
    else
    {
       extra_nave_origin = new PVector(choir_origin.x, halfway_y);
    }

    //Cloister
    if (cloister_vaults >= 3)
    {
      //draw_cloister(cloister_origin, 1, vault_width * cloister_vaults, vault_width * cloister_vaults, cloister_vaults, cloister_vaults - 2);
    }

    //Crossing
    draw_crossing(crossing_origin);

    boolean final_transpet = i == transept_number; 

    //North Transept  
    draw_north_transept(north_transept_origin, final_transpet);

    //South Transept
    draw_south_transept(south_transept_origin, final_transpet); 

    if (i == transept_number)
    {            
      //Choir
      draw_nave(choir_origin, choir_width, vault_height, number_of_choir_vaults, number_of_choir_aisles, mid_choir_aisle );
      apse_origin.x = choir_origin.x + ( (number_of_choir_vaults - 0.5) * vault_width);
      break;
    } 
    else
    {
      //Another nave
      int this_nave_vaults = int(random(2, 4));
      float this_nave_width = vault_width * this_nave_vaults;
      draw_nave(extra_nave_origin, this_nave_width, vault_height, this_nave_vaults, number_of_aisles, mid_aisle );

      north_transept_origin.x += (vaults_wide_transpet * vault_width)+ this_nave_width + vault_width;
      south_transept_origin.x += (vaults_wide_transpet * vault_width)+ this_nave_width + vault_width;
      crossing_origin.x += (vaults_wide_transpet * vault_width)+ this_nave_width + vault_width;
      choir_origin.x += (vaults_wide_transpet * vault_width)+ this_nave_width + vault_width;
      apse_origin.x = (vaults_wide_transpet * vault_width)+ this_nave_width + vault_width;
      extra_nave_origin.x += (vaults_wide_transpet * vault_width)+ this_nave_width + vault_width;
    }

    number_transpet_vault += 1;
  }

  //Ambulatory
  draw_apse(apse_origin);
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_crossing(PVector crossing_origin)
{
  PVector current_crossing_point = new PVector (crossing_origin.x, crossing_origin.y);  
    
  if(vaults_high_crossing > 1)
  {
    current_crossing_point.x = crossing_origin.x - (vaults_high_crossing /2) * vault_width;
    current_crossing_point.x -= vault_width / 2;
  }

  for (int j = 0; j < vaults_high_crossing; j++)
  {
    if(vaults_high_crossing > 1)
    {
      current_crossing_point.y = crossing_origin.y - (vaults_high_crossing / 2) * vault_height;
      current_crossing_point.y -= vault_height / 2;
    }

    float transept_vault_width;
    if (j == mid_transept_aisle)
    {
      transept_vault_width = vault_width * 2;
    } 
    else
    {
      transept_vault_width = vault_width;
    }

    for (int i = 0; i < vaults_wide_transpet; i++)
    {
      if (i == mid_transept_aisle)
      {
        boolean mid_vault = j == mid_transept_aisle;
        draw_crossing_arcade(current_crossing_point, transept_vault_width, vault_height * 2, 1, false, mid_vault );
        current_crossing_point.y += vault_height * 1.5;
      } else
      {
        draw_vault_arcade(current_crossing_point, transept_vault_width, vault_height, 1, false);

        if ( (i + 1) == mid_transept_aisle)
        {
          current_crossing_point.y += vault_height * 1.5;
        } else
        {
          current_crossing_point.y += vault_height;
        }
      }
    }

    if ( (j + 1) == mid_transept_aisle)
    {
      current_crossing_point.x += transept_vault_width * 1.5;
    } else if ( j == mid_transept_aisle)
    {
      current_crossing_point.x += transept_vault_width * 0.75;
    } else
    {
      current_crossing_point.x += transept_vault_width;
    }
  }
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
void draw_arch(PVector origin, float win_width, float win_height, float arch_height)
{  
  PVector right_vertical_origin = new PVector(origin.x + win_width, origin.y );  

  line(origin.x, origin.y, origin.x, origin.y + win_height);  
  line(right_vertical_origin.x, right_vertical_origin.y, right_vertical_origin.x, right_vertical_origin.y + win_height);

  float right_arch_angle = atan((win_width *0.86)  / (win_width /2));

  arc(origin.x, origin.y, win_width* 2.0, arch_height, TWO_PI - right_arch_angle, TWO_PI);
  arc(right_vertical_origin.x, right_vertical_origin.y, win_width* 2.0, arch_height, PI, PI+right_arch_angle );

  line(origin.x, origin.y+ win_height, origin.x + win_width, origin.y+ win_height);

  //line(origin.x + (win_width/2), origin.y - arch_height, origin.x+(win_width/2), origin.y + win_height);
  //line(origin.x, origin.y, origin.x + win_width, origin.y);
}


//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
//Foils real width is 2(passed value) + 2(15.1)
void draw_quatrefoil(PVector origin, int foil_width)
{ 
  arc(origin.x - foil_width, origin.y, foil_width * 1.51, foil_width * 1.51, HALF_PI - (QUARTER_PI / 2), PI + HALF_PI + (QUARTER_PI / 2));
  arc(origin.x + foil_width, origin.y, foil_width * 1.51, foil_width * 1.51, PI + HALF_PI - (QUARTER_PI / 2), TWO_PI + HALF_PI + (QUARTER_PI / 2));
  arc(origin.x, origin.y - foil_width, foil_width * 1.51, foil_width * 1.51, PI - (QUARTER_PI / 2), TWO_PI + (QUARTER_PI / 2));
  arc(origin.x, origin.y + foil_width, foil_width * 1.51, foil_width * 1.51, 0 - (QUARTER_PI / 2), PI + (QUARTER_PI / 2));
}

//-------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------
//Foils real width is passed value + 2(passed value * 1.51)
void draw_trefoil(PVector origin, int foil_width)
{
  arc(origin.x - ( foil_width / 2), origin.y + foil_width, foil_width * 1.51, foil_width * 1.51, HALF_PI - (QUARTER_PI), PI + HALF_PI);
  arc(origin.x + (foil_width /2), origin.y + foil_width, foil_width * 1.51, foil_width * 1.51, PI + HALF_PI, TWO_PI + HALF_PI + (QUARTER_PI ));
  arc(origin.x, origin.y - (foil_width / 4), foil_width * 1.51, foil_width * 1.51, PI - (QUARTER_PI ), TWO_PI + (QUARTER_PI ));
}