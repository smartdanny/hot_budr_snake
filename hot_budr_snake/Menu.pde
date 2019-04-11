class Menu {
  public int diff = 0;
  public boolean start = false;
  private boolean reset = false;
  private float diff0X = width/2.5, diff0Y = height/2, 
    diff1X = width/2, diff1Y = height/2, 
    diff2X = width - width/2.5, diff2Y = height/2, 
    diffDiam = 40, hoverDiam = 30, 
    startX = width/2, startY = height/3, startW = 240, startH = 100, 
    startTextX = width/2, startTextY = height/3 + 20, startTextSize = 60,
    quitX = width/2, quitY = height - height/5, quitW = 80, quitH = 40,
    quitTextX = width/2, quitTextY = height - height/5 + 7, quitTextSize = 20,
    easyX = width/2.5, easyY = height/2 + 50, 
    mediumX = width/2, mediumY = height/2 + 50, 
    hardX = width - width/2.5, hardY = height/2 + 50,
    diffTextSize = 20;
  public Menu() {
    menuSound.play();
    rectMode(CENTER);
    //start
    reset();
    reset = true;
  }

  void fillDiff() {
    stroke(0);
    strokeWeight(3);
    fill(blue);
    ellipse(diff1X, diff1Y, diffDiam, diffDiam);
    ellipse(diff0X, diff0Y, diffDiam, diffDiam);
    ellipse(diff2X, diff2Y, diffDiam, diffDiam);

    fill(yellow);
    if (diff == 0) {
      ellipse(diff0X, diff0Y, hoverDiam, hoverDiam);
    } else if (diff == 1) {
      ellipse(diff1X, diff1Y, hoverDiam, hoverDiam);
    } else {
      ellipse(diff2X, diff2Y, hoverDiam, hoverDiam);
    }
  }

  void hoverDiff(int h) {
    reset = false;
    stroke(0);
    strokeWeight(3);
    fill(blue);
    ellipse(diff1X, diff1Y, diffDiam, diffDiam);
    ellipse(diff0X, diff0Y, diffDiam, diffDiam);
    ellipse(diff2X, diff2Y, diffDiam, diffDiam);

    fill(yellow_hover);
    if (h == 0) {
      ellipse(diff0X, diff0Y, hoverDiam, hoverDiam);
    } else if (h == 1) {
      ellipse(diff1X, diff1Y, hoverDiam, hoverDiam);
    } else {
      ellipse(diff2X, diff2Y, hoverDiam, hoverDiam);
    }
    fill(yellow);
    if (diff == 0) {
      ellipse(diff0X, diff0Y, hoverDiam, hoverDiam);
    } else if (diff == 1) {
      ellipse(diff1X, diff1Y, hoverDiam, hoverDiam);
    } else {
      ellipse(diff2X, diff2Y, hoverDiam, hoverDiam);
    }
  }


  void clicked(int x, int y) {
    println(x + ", " + y);
    if (x >= startX-startW/2 && x <=startX+startW/2 && y >=startY-startH/2 && y <= startY+startH/2) {
      start = true;
      menuSound.stop();
      println("start");
      //start
    } else if (x >= quitX-quitW/2 && x <=quitX+quitW/2 && y >=quitY-quitH/2 && y <= quitY+quitH/2) {
      println("quit");
      exit();
      //start
    } else if (distance(x, y, (int)diff0X, (int)diff0Y ) <= diffDiam/2) {
      diff = 0;
      fillDiff();
      println("0");
    } else if (distance(x, y, (int)diff1X, (int)diff1Y ) <= diffDiam/2) {
      diff = 1;
      fillDiff();
      println("1");
    } else if (distance(x, y, (int)diff2X, (int)diff2Y ) <= diffDiam/2) {
      diff = 2;
      fillDiff();
      println("2");
    }
  }

  void mouseHover(int x, int y) {
    if (x >= startX-startW/2 && x <=startX+startW/2 && y >=startY-startH/2 && y <= startY+startH/2) {
      reset = false;
      fill(255);
      strokeWeight(3);
      rect(startX, startY, startW, startH);
      fill(yellow_hover);
      rect(startX, startY, startW, startH);
      fill(0);
      textAlign(CENTER);
      textSize(startTextSize);
      text("START", startTextX, startTextY);
      println("start");
      //start
    } else if (x >= quitX-quitW/2 && x <=quitX+quitW/2 && y >=quitY-quitH/2 && y <= quitY+quitH/2) {
      reset = false;
      fill(255);
      strokeWeight(3);
      rect(quitX, quitY, quitW, quitH);
      fill(yellow_hover);
      rect(quitX, quitY, quitW, quitH);
      fill(0);
      textAlign(CENTER);
      textSize(quitTextSize);
      text("QUIT", quitTextX, quitTextY);
      println("quit");
      //start
    } else if (distance(x, y, (int)diff0X, (int)diff0Y ) <= diffDiam/2) {
      hoverDiff(0);
      println("0");
    } else if (distance(x, y, (int)diff1X, (int)diff1Y ) <= diffDiam/2) {
      hoverDiff(1);
      println("1");
    } else if (distance(x, y, (int)diff2X, (int)diff2Y ) <= diffDiam/2) {
      hoverDiff(2);
      println("2");
    } else {
      if (!reset) {
        println("reseting");
        reset();
        reset = true;
      }
    }
  }

  void reset() {
    fill(yellow);
    strokeWeight(3);
    rect(startX, startY, startW, startH);
    fill(0);
    textAlign(CENTER);
    textSize(startTextSize);
    text("START", startTextX, startTextY);

    //diff
    stroke(0);
    strokeWeight(3);
    fill(blue);
    ellipse(diff1X, diff1Y, diffDiam, diffDiam);
    ellipse(diff0X, diff0Y, diffDiam, diffDiam);
    ellipse(diff2X, diff2Y, diffDiam, diffDiam);

    //labels
    textSize(diffTextSize);
    fill(0);
    text("Medium", mediumX, mediumY );
    text("Easy", easyX, easyY );
    text("Hard", hardX, hardY);

    //quit
    fill(yellow);
    strokeWeight(3);
    rect(quitX, quitY, quitW, quitH);
    fill(0);
    textAlign(CENTER);
    textSize(quitTextSize);
    text("QUIT", quitTextX, quitTextY);

    fillDiff();
  }

  float distance(int x1, int y1, int x2, int y2) {
    return sqrt( (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) );
  }
}
