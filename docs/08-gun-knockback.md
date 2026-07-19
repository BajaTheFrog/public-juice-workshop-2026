# Step 08 · 2.1.3 — 🍋 Gun Knockback

_**Part 2: Interactions · Kinetics · 2.1.3 — 🍋 Gun Knockback**_

Kinetics is not just the movement you control, it is also how the world pushes _you_ around. 

We're going to give our gun(?) some knockback when we fire it. It makes it feel a _lot_ more powerful and adds some nuance to when the player should shoot or not. Now there is a reason to _not shoot_ just as much as there is a reason _to shoot_.

Also it unlocks some cool movement tech in the air.

## Step Changes

> [!TIP]
> 
> Search `[STEP-2.1.3]` to find comments tied to this step. 

### FIRST: Enable `SHOOT_KNOCKBACK` support

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip **`SHOOT_KNOCKBACK`** from `false` → `true`
```gdscript
	var _supported: Dictionary = {
		...
		SHOOT_KNOCKBACK: true,   # [STEP-2.1.3]
		...
	}
```

### SECOND: Apply knockback on gun firing
- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `apply_knockback()`

This is another area where we won't implement the details of the code but can take a look. 

The idea is simple though: we get the position of where the bullet is coming from and apply some velocity in the opposite direction. That velocity gets spun down over time so we can recover from it. 

The method should now read:

```gdscript
	func apply_knockback(gun: Launcher2D) -> void:
		if not Steps.check(_box, Steps.SHOOT_KNOCKBACK):
			return

		# [STEP-2.1.3]: Every shot shoves us off it
		_player.apply_knockback(gun.global_position, _player.knockback_amount)
```

Importantly, our `kinetics` lets `player` actually handle the subtleties of applying and adjusting the knockback over time. The `juice_box` just gets to decide _when_ we call it and with how much knockback. 

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Gun Knockback** off and on.
3. Hold down **Left Mouse Button** and aim wherever. You should be able to feel the knockback pretty clearly and see how it impacts movement. 
<br>
<br>

> [!TIP]  
>
> Git command to auto-complete this step: `git checkout step-2.1.3`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 07 · 2.1.2 — 👹 Hitstun](07-bat-hitstun.md) | [Table of Contents](00-contents.md) | [Step 09 · 2.1.4 — 🍋 Shoot Spread →](09-shoot-spread.md)
