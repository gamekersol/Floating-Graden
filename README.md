# 🌸 Floating-Garden

**Floating-Garden** is a relaxing casual farm simulator game built with Flutter & Dart. Grow unique plants on a hexagonal platform, collect rare seeds, and expand your floating garden in a soothing, minimalistic pastel atmosphere.

### ⚠️ Project Status
**Current State:** MVP (Minimum Viable Product). 
**Development Status:** Active development is currently **stopped**. 

---

## 📸 Showcase

<div align="center">
  <img src="growing_on/assets/screenshotsgarden.png" alt="Main Garden View" width="200"/>
  <img src="growing_on/assets/screenshotsplanting.png" alt="Planting Mechanics" width="200"/>
  <img src="growing_on/assets/screenshotsinventory.png" alt="Inventory Management" width="200"/>
  <img src="growing_on/assets/screenshotsshop.png" alt="In-game Shop" width="200"/>
  <img src="growing_on/assets/screenshotsgambling.png" alt="Seed Gacha System" width="200"/>
  <img src="growing_on/assets/screenshotsclicker.png" alt="Clicker Minigame" width="200"/>
  <img src="growing_on/assets/screenshotsclose-zoom.png" alt="Close-up View" width="200"/>
</div>

---

## 🎮 Game Mechanics

* **Hexagon Grid:** Plant seeds on a hex-based grid platform with related movement and zooming. Also, you can expand your grid by spending in-game currency.
* **Gacha Seed System:** Buy seed bags from the store. The system relies on gambling mechanics where you roll for rare seeds to plant from your inventory.
* **Harvesting:** Plant seeds, wait for them to grow, and harvest them for rewards.
* **3-Currency Ecosystem:** A balanced economic system utilizing three distinct currencies. One of these currencies can *only* be earned by playing minigames.
* **Minigames:** Currently features an integrated clicker minigame to earn the exclusive currency.

## 🌿 Plant Species & Rarity Weight

The game features a weighted rarity system for the seeds you get from bags. The lower the weight, the harder it is to obtain!

| Rarity Level | Weight |
| :--- | :--- |
| **The Only One** | 1 |
| **Forgotten** | 2 |
| **Mythical** | 4 |
| **Vanished** | 8 |
| **Divided** | 16 |
| **Super Rare** | 32 |
| **Rare** | 64 |
| **Uncommon** | 128 |
| **Common** | 256 |

**Currently Implemented Species:**
* 🌾 `Cogongrass`
* 🌿 `Urtica-dioica`
* 🌸 `Veronika-prostrata`

---

## 🎨 Design & Audio
* **Graphics:** Minimalistic pastel-colored user interface featuring beautiful vector flowers.
* **Audio:** Relaxing soundscapes and sound effects powered by the `audioplayers` package.

---

## 🛠 Tech Stack & Architecture

This project was built to demonstrate proficiency in Flutter by creating a non-standard, game-like UI and managing complex interconnected states without heavily relying on third-party state management libraries.

* **Architecture:** The project follows a clear separation of concerns. Game logic, economic calculations, and timing systems are isolated in the `lib/data/` services, keeping the UI components (`lib/panels/`) clean and strictly responsible for rendering.
* **State Management:** Deliberately built using Flutter's native `ValueNotifier` and `ValueListenableBuilder`. This lightweight approach ensures highly performant, targeted widget rebuilds for the game loop and UI overlays without the overhead of external packages like BLoC or Riverpod.
* **Custom UI (Hex Grid):** The core gameplay area features a dynamically expanding hexagonal grid implemented using precise mathematical coordinate mapping and Stack widgets.
* **Data Persistence:** User progress, inventory, and garden state are serialized into JSON, meanwhile currencys stored via `shared_preferences`.

**Core Dependencies:**
* `shared_preferences` — local save system.
* `audioplayers` — handling concurrent sound effects and background music.
* `flutter_svg` & `cupertino_icons` — vector assets and iconography.

**Core Dependencies:**
* `cupertino_icons`: ^1.0.8
* `flutter_svg`: ^2.0.0
* `infinite_carousel`: ^1.1.1
* `audioplayers`: ^6.6.0
* `auto_size_text`: ^3.0.0
* `shared_preferences`: ^2.5.5
