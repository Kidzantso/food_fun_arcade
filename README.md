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
| 🍔 **Drink Tapper** | Tap on the food to get points. | ✅ Done |
| 🥤 **Memory Match** | Flip cards to find matching food pairs. | ✅ Done |

---

## 📅 Development Log

### 🗓️ Day 1 – Catch the Food 

**Tasks Completed:**
- ✅ Set up the Flutter project structure.  
- ✅ Created the **main app structure** with total points tracking.  
- ✅ Built the **Home Screen** (entry point with navigation to mini-games).
<img width="270" height="555" alt="Screenshot_1774926235" src="https://github.com/user-attachments/assets/08585e25-5c22-492a-bc4b-f466a9a8d17c" />

- ✅ Developed the **Catch the Food** game screen:
  - Implemented falling food items (burger, fries, drink).  
  - Created a movable basket controlled by drag gestures.  
  - Added **collision detection** for catching food.  
  - Designed **McDonald’s-style UI** (red, yellow, white theme).  
  - Implemented **timer and scoring system**.  
  - Ensured score never goes negative.  
  - Added **end-game popup** with score summary and a “Home” button.  
- 🧠 Prepared app for adding multiple mini-games in the future.
<img width="270" height="555" alt="Screenshot_1774926242" src="https://github.com/user-attachments/assets/9507e1f3-ca60-47c3-af73-d4ff71aed26c" />



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

<img width="270" height="555" alt="Screenshot_1774926286" src="https://github.com/user-attachments/assets/c7be7157-af2a-4d53-b5f0-1a9b0f2dee46" />

### 🗓️ Day 3 – Drink Tapper Game & UI Enhancements

**Tasks Completed:**

- ✅ **Replaced “Build the Burger”** with a new, more engaging and easier-to-play game: **Drink Tapper**.  
- ✅ Created the **Drink Tapper Screen**:
  - Drinks appear randomly on the screen and disappear after a short time.  
  - Players must **tap the drinks quickly** to earn points.  
  - The speed dynamically increases as the score rises.  
  - Ensured balance so the game becomes fast but not impossible.  
- ✅ Implemented **the same visual design** as the previous games:
  - Consistent McDonald’s-style UI (red, yellow, and white theme).  
  - Rounded yellow pop-up at the end with “Back to Home” button.  
- ✅ Integrated with **shared point system**:
  - Each game reports earned points back to the `HomeScreen`.  
  - Total score is updated seamlessly.  
- 🧠 Improved **gameplay feel and difficulty curve** to keep it fun and responsive.

<img width="270" height="555" alt="Screenshot_1774926248" src="https://github.com/user-attachments/assets/fd043736-d964-4575-8c33-a7597f9e18b5" />

### Victory and points screen
<img width="270" height="555" alt="Screenshot_1774926331" src="https://github.com/user-attachments/assets/873e2aa6-afbc-4a27-a1bd-abfd2aa2a9f6" />

---

## 🧱 Project Structure

```
food_fun_arcade/
│
├── assets/
│   ├── burger.png
│   ├── fries.png
│   ├── drink.png
│   └── happy_meal_box.png
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── catch_food_screen.dart
│   │   ├── memory_match_screen.dart
│   │   └── drink_tapper_screen.dart
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

* Add more mini-games with different difficulty levels. ✅ Done
* Integrate with restaurant’s **loyalty system** (points/rewards). (In taleb order repository)
* Add animations, sound effects.


