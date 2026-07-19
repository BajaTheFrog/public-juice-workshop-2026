# Step 07 · 2.1.2 — 👹 Hitstun

_**Part 2: Interactions · Kinetics · 2.1.2 — 👹 Hitstun**_

Same idea as the last module, but for the enemy. Helping the player understand when their attacks are landing or missing is super important to making the player understand the action and rules of the world. 

## Step Changes

> [!TIP]
> 
> Search `[STEP-2.1.2]` to find comments tied to this step. 

### FIRST: Enable `BAT_HITSTOP` support

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip **`BAT_HITSTOP`** from `false` → `true`
```gdscript
	var _supported: Dictionary = {
		...
		BAT_HITSTOP: true,       # [STEP-2.1.2]
		...
	}
```

### SECOND: Freeze time very quickly when a bat is hit
- **FILE**: `game/content/entities/bat_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `async_hitstop()`

Virtually the same. We choose a much shorter hitstop here because we want to keep the action moving, we want to stop _just_ enough to register the impact. 

The method should now read:

```gdscript
	func async_hitstop() -> void:
		if not Steps.check(_box, Steps.BAT_HITSTOP):
			return

		# [STEP-2.1.2]: Briefly freeze the whole world to emphasize hit contact
		var hitstop_time: float = 0.05
		await Game.async_stop(hitstop_time)
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **👹 Hitstun** off and on.
3. Shoot a bat with the toggle on and off and see if you can sense the subtle difference.
<br>
<br>

> [!TIP]  
>
> Git command to auto-complete this step: `git checkout step-2.1.2`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 06 · 2.1.1 — 🍋 Hitstun](06-player-hitstun.md) | [Table of Contents](00-contents.md) | [Step 08 · 2.1.3 — 🍋 Gun Knockback →](08-gun-knockback.md)
