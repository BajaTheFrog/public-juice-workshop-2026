# Step 11 · 2.2.2 — 🍋 Muzzle Flash

_**Part 2: Interactions · Feedback · 2.2.2 — 🍋 Muzzle Flash**_

A muzzle flash punctuates and confirms to the player that the gun fired and their input was successful. It helps give feedback that would exist IRL but is lost due to the digital nature of the game. 

(This is also where haptics are a great solution!)

## Step Changes

> [!TIP]
> 
> Search `[STEP-2.2.2]` to find comments tied to this step. 

### FIRST: Enable `MUZZLE_FLASH` support

- **FILE**: `game/members/steps.gd`
- **DICTIONARY**: `_supported`

Flip **`MUZZLE_FLASH`** from `false` → `true`
```gdscript
	var _supported: Dictionary = {
		...
		MUZZLE_FLASH: true,      # [STEP-2.2.2]
		...
	}
```

### SECOND: Add a muzzle flash on firing
- **FILE**: `game/content/objects/player_bullet_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `_async_muzzle_flash()`

Another gem of advice from _Art of the Screenshake_, you can get a very cheap muzzle flash effect but just including it in with the bullet sprite and very quickly turning it on before disabling it. 

If nothing else it is a great place to start. 

We'll apply the same rational as we did for the bullet spread and randomize our muzzle flash a bit so it feels more chaotic and dynamic. 

The method should now read:

```gdscript
	func _async_muzzle_flash() -> void:
		if not Steps.check(_box, Steps.MUZZLE_FLASH):
			return

		# [STEP-2.2.2]: Add muzzle flash to communicate bullet (seed) exit
		var muzzle_flash_time: float = 0.05
		var random_x_scale = Random.randf_range(0.7, 1.2)
		var random_y_scale = Random.randf_range(0.5, 1.1)

		_box.muzzle_sprite.scale = Vector2(random_x_scale, random_y_scale)

		await _async_flash(_box, _box.muzzle_sprite, muzzle_flash_time)
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Muzzle Flash** off and on.
3. Hold down **Left Mouse Button** and aim wherever and check it out!
<br>
<br>

> [!TIP]  
>
> Git command to auto-complete this step: `git checkout step-2.2.2`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 10 · 2.2.1 — 🍋 Bigger Bullets](10-bigger-bullets.md) | [Table of Contents](00-contents.md) | [Step 12 · 2.2.3 — 👹 Hitflash →](12-bat-hitflash.md)
