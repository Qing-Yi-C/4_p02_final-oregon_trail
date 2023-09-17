class Choices {

  //instance variables
  StringList choices;
  int displayx;
  int displayy;

  //methods

  Choices() {
    choices = new StringList();
    displayx = 250;
    displayy = 320;
  }//constructor

  StringList makeIntroChoices() {
    choices.clear();
    choices.append("Travel the trail");
    choices.append("Learn about the trail");
    choices.append("End");
    return choices;
  }//makeIntroChoices

  StringList makeShopChoices() {
    choices.clear();
    choices.append("Buy 5 Food ($1 p/food)");
    choices.append("Buy 1 Ox ($50 p/ox)");
    choices.append("Exit Shop");
    return choices;
  }//makeIntroChoices

  StringList makeTrailChoices() {
    choices.clear();
    choices.append("Continue on the trail");
    choices.append("Take a rest");
    choices.append("Change food rations");
    choices.append("Change speed");
    if (atFort == true) {
      choices.append("Open shop");
    }
    return choices;
  }//makeIntroChoices

  StringList makeRiverChoices() {
    choices.clear();
    choices.append("Ford the river");
    choices.append("Caulk the wagon");
    choices.append("Take the ferry");
    choices.append("Take a rest");
    return choices;
  }//makeIntroChoices

  void display(StringList list) {
    textAlign(LEFT);
    textFont(normalFont);
    textSize(20);
    text("You may:", displayx, displayy);
    int x = displayx + 50;
    int y = displayy + 50;
    for (int i = 0; i < list.size(); i ++) {
      text(i+1 + ". " + list.get(i), x, y);
      y+= 30;
    }
    textAlign(LEFT);
    text("What is your choice? (type)", displayx, y + 30);
  }//display
}//Choices
