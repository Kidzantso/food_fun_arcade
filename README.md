# 🏆 Food Fun Arcade
*A Flutter-based mini-game collection for restaurant apps (e.g., McDonald’s) where customers can play and earn points.*

---

## 🍔 Overview
**Food Fun Arcade** is a fun and simple mobile game experience designed for restaurant apps to engage customers of **all ages**.  
Players can enjoy quick, casual mini-games and earn reward points that can later be redeemed in the restaurant’s loyalty program.  

This project is built using **Flutter**, making it cross-platform (Android & iOS), lightweight, and easy to integrate into any existing restaurant app.

---

## 🎮 Game Collection (Planned)

| Game | Description | Status |
|------|--------------|--------|
| 🍟 **Catch the Food** | Catch falling burgers, fries, and drinks in a basket before time runs out! | ✅ Done |
| 🍔 **Build the Burger** | Stack ingredients correctly to make the perfect burger. | ⏳ Coming Soon |
| 🥤 **Memory Match** | Flip cards to find matching food pairs. | ✅ Completed (Visuals & Gameplay) |

---

## 📅 Development Log

### 🗓️ Day 1 – Catch the Food 

**Tasks Completed:**
- ✅ Set up the Flutter project structure.  
- ✅ Created the **main app structure** with total points tracking.  
- ✅ Built the **Home Screen** (entry point with navigation to mini-games).  
- ✅ Developed the **Catch the Food** game screen:
  - Implemented falling food items (burger, fries, drink).  
  - Created a movable basket controlled by drag gestures.  
  - Added **collision detection** for catching food.  
  - Designed **McDonald’s-style UI** (red, yellow, white theme).  
  - Implemented **timer and scoring system**.  
  - Ensured score never goes negative.  
  - Added **end-game popup** with score summary and a “Home” button.  
- 🧠 Prepared app for adding multiple mini-games in the future.

### 🗓️ Day 2 – Memory Match Game

**Tasks Completed:**
- ✅ Created the **Memory Match** game screen with full gameplay logic:
  - Implemented randomized food emoji pairs.  
  - Added card flipping animation and matching logic.  
  - Added **score and timer system** similar to Catch Food.   
- ✅ Designed the UI to **match the Catch Food screen’s visuals**, including:
  - Red background and yellow-themed cards.  
  - Matching fonts, layout, and McDonald’s-style color scheme.  
  - Consistent score/time bar at the top.  
- ✅ Recreated the **end-game popup dialog**:
  - Same layout and visual theme as Catch Food.  
  - Rounded yellow box with a red “Back to Home” button.  
- 🧠 Ensured code reusability for future games with the same design structure.

---

## 🧱 Project Structure

```

food_fun_arcade/
│
├── assets/
│   ├── burger.png
│   ├── fries.png
│   └── drink.png
│   └── happy_meal_box.png
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── catch_food_screen.dart
│   │   └── memory_match_screen.dart
│
└── pubspec.yaml

````

---

## 🚀 How to Run

1. Clone the repository  
   ```bash
   git clone https://github.com/yourusername/food_fun_arcade.git
   cd food_fun_arcade

2. Get dependencies

   ```bash
   flutter pub get
   ```

3. Run the app

   ```bash
   flutter run
   ```

4. Enjoy playing 🎮

---

## 💡 Future Plans

* Add more mini-games with different difficulty levels.
* Integrate with restaurant’s **loyalty system** (points/rewards).
* Add animations, sound effects, and leaderboard.


