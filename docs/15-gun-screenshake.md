# Step 15 · 3.2.1 — 📺 Gun Screenshake

_**Part 3: Camera & Time · Feedback · 3.2.1 — 📺 Gun Screenshake**_

Once the only type of **Juice** the indie community seemed to know about, we finally get to the ever-effective _screenshake_. 

We're going to start by applying just a _touch_ of it on every player shot to further drive home the power of the gun and make players feel that action. 

## Step Changes

> [!TIP]
> 
> Search `[STEP-3.2.1]` to find comments tied to this step. 

### FIRST: Enable `SHOOT_SHAKE` support

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip **`SHOOT_SHAKE`** from `false` → `true`
```gdscript
	var _supported: Dictionary = {
		...
		SHOOT_SHAKE: true,       # [STEP-3.2.1]
		...
	}
```

### SECOND: Shake the screen on gun shot
- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `on_shot()`

As with handling time scaling, we have a special pre-defined manager for screenshake. But we pick an amplitude (how _much_ it shakes) and a time (how _long_ it shakes) and let it rip.

Choose modest values here to start, you don't want to make someone sick because they shot too much with a lot of shake!

The method should now read:

```gdscript
	func on_shot(gun: Launcher2D) -> void:
		if not Steps.check(_box, Steps.SHOOT_SHAKE):
			return

		# [STEP-3.2.1]: Make the "gun" feel more powerful with screenshake
		var shake_amplitude: float = 8.0
		var shake_time: float = 0.25
		Game.services.camera.add_shake(shake_amplitude, shake_time)
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **📺 Gun Screenshake** off and on.
3. Fire away! It should make the kickback of the gun feel real without being too distracting. 
<br>
<br>

> [!TIP]  
>
> Git command to auto-complete this step: `git checkout step-3.2.1`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 14 · 3.1.2 — ⏰ Danger Zone Slowmo](14-danger-zone-slowmo.md) | [Table of Contents](00-contents.md) | [Step 16 · 3.2.2 — 📺 Death Screenshake →](16-death-screenshake.md)
