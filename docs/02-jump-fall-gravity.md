# Step 02 · 1.1.2 — 🍋 Jump / Fall Gravity

_**Part 1: Movement · Kinetics · 1.1.2 — 🍋 Jump / Fall Gravity**_

One of the clearest example of the importance of Kinetics is how a jump _feels_. If you are doing a lot of jumping in a game (such as a platformer), your jump better feel great!

It turns out that a jump that rises and falls with the same gravity feels floaty. So we're going to use a classic trick: fall faster than we go up!

## Where to go
- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `get_gravity_scale()`
- **COMMENT**: `# [STEP-1.1.2]`

### The Change
This is also a nice and easy change. 

1. Without our change, we always return a gravity scale of `1.0`, which means it is constant. 
2. However if we check that our `velocity_y` is _greater_ than `0.0`, that means we are falling and can increase the gravity scale with a different value (`_player.fall_gravity_mult`).	

The method should now read:

```gdscript
	func get_gravity_scale(velocity_y: float) -> float:
		if not Steps.check(_box, Steps.JUMP_GRAVITY):
			return 1.0

		# [STEP-1.1.2]: Fall faster than we rise
		return _player.fall_gravity_mult if velocity_y > 0 else 1.0
```

`velocity_y > 0` means the LeMon is falling (Godot's Y axis points down), so we
only boost gravity on the way *down*.

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Jump / Fall Gravity** off and on.
3. Jump with **W** and see how the drop feels when this change is turned on and off. 
<br>
<br>
> [!IMPORTANT HELP] 
>
> Git command to auto-complete this step: `git checkout step-1.1.2`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 01 · 1.1.1 — 🍋 Acceleration](01-acceleration.md) | [Table of Contents](00-contents.md) | [Step 03 · 1.1.3 — 🍋 Air Control / Dampening →](03-air-control-dampening.md)
