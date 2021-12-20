class Meal{


  final String mealName, mealTimeHour, mealTimeName, imagePath, recipe, mealCode;
  final List ingredients;

  Meal(this.mealName, this.mealTimeHour,this.mealTimeName, this.imagePath, this.ingredients, this.recipe, [this.mealCode]);

  Map<String, dynamic> toJson() => {
    'mealName': mealName,
    'mealTimeHour': mealTimeHour,
    'mealTimeName': mealTimeName,
    'imagePath': imagePath,
    'ingredients': ingredients,
    'mealCode': mealCode,
  };

  getMealCode(){
    return mealCode;
  }
}

printMeal(Meal m){
  print(m.mealName);
}
