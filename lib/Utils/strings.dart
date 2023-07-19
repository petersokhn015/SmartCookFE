class StringSet {
  static const String welcomeTitle = "Smart Cook";
  static const String welcomeDescription = "Better food, better experience";
  static const String getStartedText = "Get Started";

  static const String createAccountTitle = "Create Account";
  static const String usernameText = "Username";
  static const String emailText = "Email";
  static const String passwordText = "Password";
  static const String continueText = "Continue";
  static const String loginSwitchText = "Already have an account? ";

  static const String verifyInformationTitle = "Verify Information";
  static const String verifyInformationDescription =
      "Make sure that everything about you is correct";
  static const String byTappingText =
      "By Tapping “Create Account”, you agree to our ";
  static const String createAccountText = "Create Account";

  static const String yourPreferencesTitle = "Your Preferences";
  static const String yourPreferencesDescription =
      "Everything you will experience next is based on it.";
  static const String dietTitle = "Do you follow any specific diet?";
  static const String glutenFreeText = "Gluten Free";
  static const String ketogenicText = "Ketogenic";
  static const String vegetarianText = "Vegetarian";
  static const String paleoText = "Paleo";
  static const String veganText = "Vegan";
  static const String cuisineTypeTitle = "Any cuisines you prefer?";
  static const String americanText = "American";
  static const String chineseText = "Chinese";
  static const String japaneseText = "Japanese";
  static const String indianText = "Indian";
  static const String frenchText = "French";
  static const String italianText = "Italian";
  static const String middleEasternText = "Middle Eastern";
  static const String mexicanText = "Mexican";
  static const String thaiText = "Thai";
  static const String intoleranceTitle =
      "Any intolerance we should be aware of?";
  static const String dairyText = "Dairy";
  static const String eggText = "Egg";
  static const String glutenText = "Gluten";
  static const String grainText = "Grain";
  static const String peanutText = "Peanut";
  static const String seafoodText = "Seafood";
  static const String sesameText = "Sesame";
  static const String shellfishText = "Shellfish";
  static const String soyText = "Soy";
  static const String sulfiteText = "Sulfite";
  static const String treeNutText = "Tree Nut";
  static const String wheatText = "Wheat";
  static const finishText = "Finish";

  static const String loginTitle = "Login";
  static const String continueWithGoogleText = "Continue with Google";
  static const String orText = "Or";
  static const String registerSwitchText = "Don't have an account?   ";
  static const String signUpText = "Sign Up";

  static const String homeTitle = "Hi, ";
  static const String homeDescription =
      "We're so glad you're here. Let's get cooking!";
  static const String whatYouMightLikeTitle = "What you might like";
  static const String howAreYouFeelingTitle = "How are you feeling";
  static const String viewMoreText = "View more";

  static const String ingredientsTitle = "Ingredients";
  static const String instructionsTitle = "Instructions";
  static const String goARText = "Go AR";

  static const String discoverTitle = "Discover";
  static const String discoverDescription =
      "You can discover new recipes in a traditional way or using your camera.";
  static const String searchRecipesIngredientsText = "Recipes, Ingredients";
  static const String searchByMealTitle = "Search by Meal";
  static const String breakfastText = "Breakfast";
  static const String lunchText = "Lunch";
  static const String dinnerText = "Dinner";
  static const String dessertText = "Dessert";
  static const String searchByCuisineTitle = "Search by Cuisine";

  static const String editYourProfileText = "Edit Your Profile";
  static const String myFoodPreferencesTitle = "My Food Preferences";
  static const String myFoodPreferencesDescription =
      "Meal Type, Cuisine Type, and Intolerance";
  static const String myFavoriteRecipesTitle = "My Favorite Recipes";
  static const String myFavoriteRecipesDescription =
      "Check out your favorite recipes";
  static const String generalSettingsTitle = "General Settings";
  static const String aboutSmartCookTitle = "About SmartCook";
  static const String logoutTitle = "Logout";
}

class ImageUrls {
  static const String americanURL = "assets/Images/american.png";
  static const String arLogoURL = "assets/Images/arLogo.png";
  static const String breakfastURL = "assets/Images/breakfast.png";
  static const String chineseURL = "assets/Images/chinese.png";
  static const String dessertURL = "assets/Images/dessert.png";
  static const String dinnerURL = "assets/Images/dinner.png";
  static const String googleURL = "assets/Images/google.png";
  static const String indianURL = "assets/Images/indian.png";
  static const String italianURL = "assets/Images/italian.png";
  static const String japaneseURL = "assets/Images/japanese.png";
  static const String loginURL = "assets/Images/login.png";
  static const String logoURL = "assets/Images/logo.png";
  static const String lunchURL = "assets/Images/lunch.png";
  static const String mexicanURL = "assets/Images/mexican.png";
  static const String middleEastURL = "assets/Images/middleEastern.png";
  static const String notFoundURL = "assets/Images/notFound.png";
  static const String pandaSittingURL = "assets/Images/PandaSitting.png";
  static const String placeHolderURL = "assets/Images/placeHolder.png";
  static const String registerURL = "assets/Images/register.png";
  static const String thaiURL = "assets/Images/thai.png";
}

class TfliteURLs {
  static const String tfliteModelURL = "assets/ssd_mobilenet.tflite";
  static const String tfliteLabelsURL = "assets/ssd_mobilenet.txt";
}

class APIEndpoints {
  static const String baseUrl = "http://192.168.1.107:5000/api/";
  static const String getRandomRecipesURL =
      "${baseUrl}SpoonacularRecipes/GetRandomRecipes";
  static const String getRecipeDetails =
      "${baseUrl}SpoonacularRecipes/GetRecipeDetails?recipeId=";
  static const String getRecommendedRecipesURL =
      "${baseUrl}SpoonacularRecipes/GetRecommendedRecipes";
  static const String getRecipeByCuisineType =
      "${baseUrl}SpoonacularRecipes/GetRecipeByCuisineType?cuisineType=";
  static const String searchRecipe =
      "${baseUrl}SpoonacularRecipes/SearchRecipe";
  static const String searchRecipeByCuisineType =
      "${baseUrl}SpoonacularRecipes/SearchRecipeByCuisineType?cuisineType=";
  static const String registerUser = "${baseUrl}Authentication/Register";
  static const String loginUser = "${baseUrl}Authentication/Login";
  static const String updateUserInfo = "${baseUrl}User/UpdateUserInfo";
  static const String getUserByEmail = "${baseUrl}User/GetUserByEmail";
  static const String ModifyPreferences =
      "${baseUrl}Preferences/ModifyUserPreferences";
  static const String GetUserPreferences =
      "${baseUrl}Preferences/GetUserPreferences";
  static const String AddFavoriteRecipe =
      "${baseUrl}DBRecipes/AddFavoriteRecipe?email=";
  static const String RemoveFavoriteRecipe =
      "${baseUrl}DBRecipes/RemoveFavoriteRecipe?email=";
  static const String GetFavoriteRecipe =
      "${baseUrl}DBRecipes/GetUserFavoriteRecipes?email=";
}
