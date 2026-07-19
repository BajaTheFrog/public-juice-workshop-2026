# Step 01 · 1.1.1 — 🍋 Acceleration
_**Part 1: Movement · Kinetics · 1.1.1 — 🍋 Acceleration**_

To start, LeMon has a very _snappy_ movement. There is no acceleration so he can change directions instantaneously and stop on a dime. 

Sometimes - that _is_ actually what you want! It is not inherently wrong. In our case, or at least for the purposes of this workshop, we're going to opt to change that. 

We will introduce acceleration to create a feeling of weight and momentum.

## Step Changes

> [!TIP]
> 
> Search `[STEP-1.1.1]` to find comments tied to this step. 

### FIRST: Enable `ACCELERATION` support

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip **`ACCELERATION`** from `false` → `true`
```gdscript
	var _supported: Dictionary = {
		...
		ACCELERATION: true,      # [STEP-1.1.1]
		...
	}
```

### SECOND: Add acceleration to movement
- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `get_acceleration()`

1. `value` gets set to `_player.speed` which happens to be the _max speed_. So there is nothing to build up to, we are just already there. 
2. All we are going to do is overwrite `value` with the `_player.acceleration`. This is a lower value that will compound over time until we get to our max speed. 

The method should now read:

```gdscript
	func get_acceleration(is_in_air: bool) -> float:
		var value := _player.speed

		if Steps.check(_box, Steps.ACCELERATION):
			# [STEP-1.1.1]: Ease into top speed so the ball carries weight
			value = _player.acceleration

		if Steps.check(_box, Steps.AIR_DAMPENING) and is_in_air:
			# [STEP-1.1.3]: Give up some control in the air
			pass

		return value
```

## Try it

1. Run the game and press **J** to open the Juice menu.
2. Turn on and off the first step **🍋 Acceleration**. 
3. Try rolling with **A** / **D** when the setting is on and off. Feel the difference!
<br>
<br>
> [!IMPORTANT]  
>
> Git command to auto-complete this step: `git checkout step-1.1.1`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Part 1 — Movement](00.1-part-1-movement.md) | [Table of Contents](00-contents.md) | [Step 02 · 1.1.2 — 🍋 Jump / Fall Gravity →](02-jump-fall-gravity.md)
