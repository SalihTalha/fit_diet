class Meal{


  final String mealName, mealTimeHour, mealTimeName, imagePath, recipe;
  final List ingredients;

  Meal(this.mealName, this.mealTimeHour,this.mealTimeName, this.imagePath, this.ingredients, this.recipe);

}

printMeal(Meal m){
  print(m.mealName);
}
