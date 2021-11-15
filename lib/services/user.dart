class User{
  String chatCode, mealCode, name, photoLink, dailyGoal;

  List<Map<String, dynamic>> dayAndWeightMap; // day: timestamp , weight: number
  double goal;

  User(this.chatCode, this.mealCode, this.name, this.photoLink, this.dailyGoal, this.dayAndWeightMap, this.goal);

  goalRate(){
    if(dayAndWeightMap.isNotEmpty){
      var rate;
      try{
        rate = (dayAndWeightMap.first['weight'] - dayAndWeightMap.last['weight'] ) / dayAndWeightMap.first['weight'] - this.goal;
      }
      catch(e){
        rate = 0;
      }
      if(rate <= 0)
        return 0;
      else return rate;
    }
    else return 0;
  }

}