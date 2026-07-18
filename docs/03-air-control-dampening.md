# Step 03 · 1.1.3 — 🍋 Air Control / Dampening

_**Part 1: Movement · Feedback · 1.1.3 — 🍋 Air Control / Dampening**_

While it will make sense for some games, we're going to change how in-air movement works. In our case, fully steering in mid-air feels unwieldy and also kind of removes the committment stakes from the jump. 

We're going to "dampen" our acceleration while in air so that you can nudge your position but not fly. 

## Where to go
- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `get_acceleration()`
- **COMMENT**: `# [STEP-1.1.3]`

### The Change
Close enough, welcome back `get_acceleration()`. 

This time we are going to take advantage of `is_in_air`. 

1. `value` gets set to `_player.speed` (as before)
2. Our changes from [1.1.1 — 🍋 Acceleration](01-acceleration.md) update the value with our acceleration value.
3. _Then_ we will _multiply_ that value by our `player.air_dampening_mult` value. This should be a number between `0.0` and `1.0` where the lower value means less air mobility. 


The method should now read:

```gdscript
	func get_acceleration(is_in_air: bool) -> float:
		var value := _player.speed

		if Steps.check(_box, Steps.ACCELERATION):
			# [STEP-1.1.1]: Ease into top speed so the ball carries weight
			value = _player.acceleration

		if Steps.check(_box, Steps.AIR_DAMPENING) and is_in_air:
			# [STEP-1.1.3]: Give up some control in the air
			value *= _player.air_dampening_mult

		return value
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Air Control / Dampening** off and on.
3. Jump with **W** and try to change direction mid-air: with it on, your steering is
   sluggish and you have to plan the jump; with it off, you can fly around freely.
<br>
<br>
> [!IMPORTANT]  
>
> Git command to auto-complete this step: `git checkout step-1.1.3`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 02 · 1.1.2 — 🍋 Jump / Fall Gravity](02-jump-fall-gravity.md) | [Table of Contents](00-contents.md) | [Step 04 · 1.2.1 — 🍋 Jump Squash + Stretch →](04-jump-squash-stretch.md)
