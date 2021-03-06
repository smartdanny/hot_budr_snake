//Kathryn Curley
//Daniel Gilbert
//Rebecca Loredo
//Daniel Shatz
// MAIN METHOD

// This is the root of our game
// setup is here as well as draw() function

// turn this to true to see where snake is looking for obstacles
boolean DEBUG = false;

// imports
import java.io.FileWriter;
import java.io.*;
import processing.sound.*;

// cool sounds
SoundFile menuSound;
SoundFile eatSound;
SoundFile hitSound;

// colors for use as the theme as well as obstacle/budr detection
PFont font; 
color blue = color(117, 207, 214); // theme blue
color yellow = color(252, 236, 151); // theme yellow
color fake_yellow = color(252, 236, 150);
color fake_yellow2 = color(249, 237, 149);
color yellow_hover = color(252, 236, 151, 100);

// obstacle border html is: e31837
color obstacle_border = color(227, 24, 55); // its red
color target_border = color(0, 0, 0); // black
color target_inside = color(252, 236, 151); // budr yellow

// instantiate things required for a lot of our classes, methods, and the like
Menu m ;
boolean dead = true;
boolean check = false;
PImage arrowKeys;

int lvl_speed = 1;
int size = 20;
Snake snake = new Snake();
boolean alive = true;
int diff_speed = 2;

PImage obstacleImg = new PImage();
Obstacle obstacle;

PImage budrImg = new PImage();
Budr budr;

int difficulty = 0;
int[] scores = new int[3];

// run initial setup
void setup() {
  font = createFont("Fonts/MODES.TTF", 32);
  menuSound = new SoundFile(this, "Sounds/menuSound.wav");
  eatSound = new SoundFile(this, "Sounds/eat.wav");
  hitSound = new SoundFile(this, "Sounds/obstacleHit.wav");
  textFont(font);
  size(800, 600);
  background(blue);
  m = new Menu();

  // Obstacles
  obstacle = new Obstacle();
  obstacleImg = loadImage("obstacle.png");
  obstacle.obstacleImage = obstacleImg;

  // Budr
  budr = new Budr();
  budrImg = loadImage("target.png"); 
  budr.budrImage = budrImg;

  String line;
  try {
    BufferedReader reader = createReader("data/highscore.txt");
    line = reader.readLine();
    int i = 0;
    while (line != null) {
      String[] pieces = split(line, "\n");
      scores[i] = int(pieces[0]);
      i++;
      line = reader.readLine();
    }

    for (int j = 0; j < scores.length; j++) {
      int score = scores[j];
      println(score);
    }
  }
  catch(IOException ioe) {
    System.out.println("Exception ");
    ioe.printStackTrace();
  }
}


// run draw loop
void draw() {
  if (!m.start) {
    //mouse hover
    m.mouseHover(mouseX, mouseY);
  }
  if (m.how) {
    arrowKeys = loadImage("Images/arrowKeys.png");
    background(blue);
    textAlign(CENTER);
    imageMode(CENTER);
    textSize(25);
    fill(255);
    text("HOW TO PLAY", width/2, height/4);
    image(arrowKeys, width/2, height/4+55, 120, 120);
    text("Using the arrow keys navigate the playing", width/2, height/4+130);
    text("field, collide with the hot_budr to grow ", width/2, height/4+160);
    text("your snake, avoid not_budr obstacles and", width/2, height/4+190);
    text("earn a highscore. Remember the more you ", width/2, height/4+220);
    text("the more the snake grows the faster it gets!", width/2, height/4+250);
    fill(yellow);
    strokeWeight(3); 
    rect(width/2, height - height/4, 80, 40);
    fill(0);
    textAlign(CENTER);
    text("BACK", width/2, height - height/4 + 9);

    m.mouseHover(mouseX, mouseY);
  }

  if (m.start) {
    //start
    background(blue);
    textAlign(LEFT);
    textSize(15);
    fill(255);
    text("Score: " + snake.len, 10, 20);

    snake.display();
    obstacle.calcObstacle();
    obstacle.display();
    budr.display();

    snake.update();
    gameState();
  }
}

void mouseClicked() {
  m.clicked(mouseX, mouseY);
}

//update velocity based on the key pressed
void keyPressed() { 
  //CANNOT move in the opposite direction (i.e. if going right can't go left)
  if (keyCode == LEFT && snake.moveX != 1) {
    snake.vel.x = -1;
    snake.vel.y = 0;
  } else if (keyCode == RIGHT && snake.moveX != -1) {
    snake.vel.x = 1;
    snake.vel.y = 0;
  } else if (keyCode == UP && snake.moveY != 1) {
    snake.vel.y = -1;
    snake.vel.x = 0;
  } else if (keyCode == DOWN && snake.moveY != -1) {
    snake.vel.y = 1;
    snake.vel.x = 0;
  }
}

// required to see if still alive, tally score, etc
void gameState() {
  if (!alive) {
    if (snake.len > scores[0] && !check) {
      scores[0] = snake.len;
      check = true;
    }
    if (snake.len > scores[1] && !check) {
      scores[1] = snake.len;
      check = true;
    } 
    if (snake.len > scores[2] && !check) {
      scores[2] = snake.len;
      check = true;
    }


    String newScores = scores[0] + "\n" + scores[1] + "\n" + scores[2];

    PrintWriter output1 = createWriter("data/highscore.txt"); 
    output1.println(newScores); // Writes the remaining data to the file
    output1.flush();
    output1.close(); 
    //pw.close();

    background(blue); 
    fill(yellow);
    textSize(50);
    text("Game Over!", 245, 160);
    text("Score: " + snake.len, 275, 210);
    textSize(30);
    if(scores[0] == snake.len){
      text("NEW HIGHSCORE!", 260, 280);
      text("Leaderboard", 280, 340);
      text("First: " + scores[0], 300, 370);
      text("Second: " + scores[1], 300, 400);
      text("Third: " + scores[2], 300, 430);
    }
    else if(scores[1] == snake.len){
      text("NEW HIGHSCORE!", 260, 280);
      text("Leaderboard", 280, 340);
      text("First: " + scores[0], 300, 370);
      text("Second: " + scores[1], 300, 400);
      text("Third: " + scores[2], 300, 430);
    }
    else if(scores[2] == snake.len){
      text("NEW HIGHSCORE!", 260, 280);
      text("Leaderboard", 280, 340);
      text("First: " + scores[0], 300, 370);
      text("Second: " + scores[1], 300, 400);
      text("Third: " + scores[2], 300, 430);
    }
    else {
      text("No highscore this time!", 200, 280);
      text("Leaderboard", 280, 340);
      text("First: " + scores[0], 300, 370);
      text("Second: " + scores[1], 300, 400);
      text("Third: " + scores[2], 300, 430);
    }
    if (mousePressed) {
      exit();
    }
  }
}
