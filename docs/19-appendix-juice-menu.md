# Appendix — The Juice Menu

The **Juice menu** is the in-game debug panel that lets you turn every step on and off
while the game runs. It's a great way to mix-and-match how different elements change the feel of the game!

## Opening it

- Press **J** at any time during play to open or close the menu.
- Opening the menu **pauses** the game so you can read and toggle in peace. Closing it
  un-pauses — unless the game was already paused when you opened it, in which case it
  stays paused.

## What you're looking at

At the top:

- **JUICE: x/N** — how many of the `N` steps are currently on. 
- **All on** / **All off** buttons — flip the entire game juiced or bone-dry in one
  click. Toggling *everything* off is the fastest way to feel the clean slate you
  started from.

Each **row** is one step:

- A **checkbox + label** (e.g. `☑️ 🍋 Acceleration`) — click to toggle that step.
- A dim **source file** on the right (e.g. `player_juice_box.gd`) — tells you exactly
  which file that step lives in. Handy when you're navigating the code.
- Rows that are **on** are yellow; rows that are **off** are not.

## The three tabs

Because this menu was too fun to stop twiddling with, there are three tabs which act as different ways of organizing the effects! 

| Tab | What it shows |
| --- | --- |
| **Sequence** | Every step in workshop order, numbered `01 …`. This mirrors the order of the step files in this guide. |
| **By Type** | Steps grouped under **KINETICS** and **FEEDBACK**, each group with its own **on** / **off** buttons. Great for feeling an entire family at once. |
| **By Moment** | Steps grouped by *when* they fire (🍋 Lifecycle, 👹 Lifecycle, 🌱 Lifecycle, Physics, Contact, Other), each group with **on** / **off**. |

## FYI

- **Steps default to on.** The moment you write a step's code it works — so if you
  want to demo "before," you toggle it *off*.
- **Your choices persist.** Toggle state is saved to `user://juice_steps.cfg` and
  restored next run, so the menu remembers how you left it.

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Credits & Thanks](18.2-credits.md) | [Table of Contents](00-contents.md) | [Final Source — `player_juice_box.gd` →](20-final-source-player-juice-box.md)
