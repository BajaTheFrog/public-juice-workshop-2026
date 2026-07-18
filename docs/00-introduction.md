# Introduction

Welcome to reading the docs for the workshop!

We've got everything. 
You can see it all in our state-of-the-art **[Table of Contents](00-contents.md)**!

## The game

We have a very simple sample game where you play as a **lemon** (_LeMon James_) avoiding and shooting down Fruit Bats ™ trying to hurt (eat?) you.
<br>
Survive as long as you can. 

- Move left and right
- Jump
- Use the mouse to aim and shoot
- Jump directly over Bats to reload your "gun". 
- You hit a Bat, sadly, you die!

### Mechanically, everything works but...
It's not super fun? I mean maybe that's because the design itself isn't great. 
But we're not going to focus on game design or mechanics today - those will go unchanged. 

This workshop is all about _**JUICE**_. 
A magical somewhat catch-all word that means a lot of different things to a lot of diferrent people. 

We're gonna bring this game to life a little more by **juicing** it to hell and back. 

## What is "juice"?

> [!IMPORTANT]
>
> I will preface this section by saying: I spent a _lot_ of time trying to find a clever metaphor that tied **Game Feel**, **Juice** and some other related concepts into a nice package.
> 
> But I found there are some messy overlapping ideas that I couldn't quite square in a way I liked. It was turning me into The Joker ™.
>
> So...it doesn't really matter! Here is how we are going to use the term for the purposes of this project and workshop...
>
> Okay thanks!


### **Juice**

**Juice** turns the players _input_ into _expressive output_ that communicates to the player what is happening in the game. Juice isn't just style without substance: _it's essential user interaction design_. Also, it's fun!

In this workshop we are going to break **Juice** down into 2 families (at the risk of everyone yelling at me):

- **KINETICS** — *how the world, time, entities and objects move.* 
  - **In other words: Do I like how this jump feels or not?**
  - The physics and input processing that change the
  motion itself: acceleration, gravity, knockback, hitstun, slow-motion, camera
  tracking etc. **Kinetics** changes how your game **feels**. 
  - **Kinetics** really need to be experienced first-hand (as a player) to be understood and can be felt with primative shapes and flat colors.
- **FEEDBACK** — *how actions, updates, changes and information are expressed.* 
  - **In other words: Does the jump look and sound engaging?**
  - The (mostly) audio-visual flourishes layered on
  top of an action: squash-and-stretch, muzzle flashes, hit flashes, screen shake,
  the death flash, sound. **Feedback** changes how an action **reads**.
  - **Feedback** can be seen in screenshots, gifs and videos. You can look at a clip and get a sense of what is going on without a controller in your hand. 

You can have a game that _feels_ great to move around in but is kind of a flat audio-visual experience. (Strong **Kinetics** but weak **Feedback**). 

Inversely you can have a game that _looks and sounds_ great but feels awkward or stilted to move around in. (Strong **Feedback** but weak **Kinetics**).

When we have strong **Kinetics** and strong **Feedback**, we have strong **Juice**!


## Reference

- **[Table of Contents](00-contents.md)** — the map of every page in this guide. Go
  here if you get lost.
- **[Appendix — The Juice Menu](19-appendix-juice-menu.md)** — the debug menu's
  features and how to use it.
- **[Appendix — Git Help & FAQ](25-appendix-git-help.md)** — in case you need a hand.
- **[Appendix — More Resources](26-appendix-more-resources.md)** — talks, a book, and docs to go deeper.
- **Final source files** — the complete, finished version of every file you edit if you get stuck or want to double check. 
  - [player_juice_box.gd](20-final-source-player-juice-box.md)
  - [bat_juice_box.gd](21-final-source-bat-juice-box.md)
  - [player_bullet_juice_box.gd](22-final-source-player-bullet-juice-box.md) 
  - [level_juice_box.gd](23-final-source-level-juice-box.md)
  - [sound_service.gd](24-final-source-sound-service.md)

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← 🍋 Your Game is a Lemon — JUICE IT 🍋](../README.md) | [Table of Contents](00-contents.md) | [Part 1 — Movement →](00.1-part-1-movement.md)
