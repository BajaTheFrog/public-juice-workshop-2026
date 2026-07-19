# Appendix — The Juice Menu

The **Juice menu** is the in-game debug panel that lets you turn every effect on and off
while the game runs. It's a great way to mix-and-match how different elements change the feel of the game!

## Exercises vs. effects

- The **guide** is organized into **7 exercises** (`1.1`, `1.2`, `2.1` … `4.1`).
- The **menu** lists **18 individual effects** and orders them _sequentially_ — every `A`, `B`, `C`... from those exercises, each with its own switch.
- The menu only shows effects you've **enabled support for**, so it starts empty and grows as you work. Finish an exercise and its effects appear together.

## Opening it

- Press **J** at any time during play to open or close the menu.
- Opening the menu **pauses** the game so you can read and toggle in peace. Closing it
  un-pauses — unless the game was already paused when you opened it, in which case it
  stays paused.

## What you're looking at

At the top:

- **JUICE: x/N** — how many of the `N` effects are currently on. 
- **All on** / **All off** buttons — flip the entire game juiced or bone-dry in one
  click. Toggling *everything* off is the fastest way to feel the clean slate you
  started from.

Each **row** is one effect:

- A **checkbox + label** (e.g. `☑️ 🍋 Acceleration`) — click to toggle that effect.
- A dim **source file** on the right (e.g. `player_juice_box.gd`) — tells you exactly
  which file that effect lives in. Handy when you're navigating the code.
- Rows that are **on** are yellow; rows that are **off** are not.

## The three tabs

Because this menu was too fun to stop twiddling with, there are three tabs which act as different ways of organizing the effects! 

| Tab | What it shows |
| --- | --- |
| **Sequence** | Every effect in workshop order, numbered `01 … 18`. This follows the order the exercises introduce them. |
| **By Type** | Effects grouped under **KINETICS** and **FEEDBACK**, each group with its own **on** / **off** buttons. Great for feeling an entire type of effect at once. |
| **By Moment** | Effects grouped by *when* they fire (🍋 Lifecycle, 👹 Lifecycle, 🌱 Lifecycle, Physics, Contact, Other), each group with **on** / **off**. |

## FYI

- **Your choices persist.** Toggle state is saved to `user://juice_steps.cfg` and
  restored next run, so the menu remembers how you left it.
- **The `[STEP-x.y.z]` tags never appear in the menu.** They're breadcrumbs for finding
  the code — the menu shows friendly labels instead.

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Credits & Thanks](07.2-credits.md) | [Table of Contents](00-contents.md) | [Final Source — `player_juice_box.gd` →](09-final-source-player-juice-box.md)
