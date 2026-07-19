# Step 16 · 3.2.2 — 📺 Death Screenshake

_**Part 3: Camera & Time · Feedback · 3.2.2 — 📺 Death Screenshake**_

We're going to use screenshake _again_ but this time for a different purpose. Like our squash and stretch, you can use it in many ways but you want to make sure to be mindful of where and when you are using it and how they contrast with each other. 

In this case, we are shaking the screen from dying super hard. We want no ambiguity about what happened. 

LeMon is dead and you killed him. 
You should make the player really sit with that. 

## Step Changes

> [!TIP]
> 
> Search `[STEP-3.2.2]` to find comments tied to this step. 

### FIRST: Enable `DEATH_SHAKE` support

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip **`DEATH_SHAKE`** from `false` → `true`
```gdscript
	var _supported: Dictionary = {
		...
		DEATH_SHAKE: true,       # [STEP-3.2.2]
		...
	}
```

### SECOND: Shake the screen on death, big time
- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `on_hit()`

Same shape of change as the last module but 10x the shake and 2x the duration.

The method should now read:

```gdscript
	func on_hit() -> void:
		Game.services.sound.play_sfx(_box.hurt_sound)

		if not Steps.check(_box, Steps.DEATH_SHAKE):
			return

		# [STEP-3.2.2]: Shake the camera on death
		var shake_amplitude: float = 80.0
		var shake_time: float = 0.5

		Game.services.camera.add_shake(shake_amplitude, shake_time)
```


## Try it

1. Press **J** for the Juice menu.
2. Toggle **📺 Death Screenshake** off and on.
3. Die.
<br>
<br>

> [!TIP]  
>
> Git command to auto-complete this step: `git checkout step-3.2.2`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 15 · 3.2.1 — 📺 Gun Screenshake](15-gun-screenshake.md) | [Table of Contents](00-contents.md) | [Step 17 · 3.2.3 — 📺 Death Flash →](17-death-flash.md)
