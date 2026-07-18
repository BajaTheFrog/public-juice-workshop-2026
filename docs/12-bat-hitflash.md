# Step 12 · 2.2.3 — 👹 Hitflash

_**Part 2: Interactions · Feedback · 2.2.3 — 👹 Hitflash**_

Pairing nicely with a hitstop is a _hitflash_. This is visual confirmation that our bullet hit and the enemy took damage. 

And like the muzzle flash, its as simple as turning on a sprite for a moment before turning it off again. 

## Where to go
- **FILE**: `game/content/entities/bat_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `async_on_hit()` (and add a new `_async_flash()` helper)
- **COMMENT**: `# [STEP-2.2.3]`

## The changes
For reasons lost to me, we're going to also implement the flash logic. Luckily - it is very simple. 

What is not captured in the code is that we can get the "full white sprite" effect by using a shader that fully colors a sprite one color. I'm not a shader head but there are lots of good examples out there and is very simple to implement!

This step has two parts.

### 1. Fill in `async_on_hit()`

Find the `# [STEP-2.2.3]` comment and **replace the `pass` beneath it** with:

```gdscript
	func async_on_hit() -> void:
		Game.services.sound.play_sfx(_box.hit_sound)

		if not Steps.check(_box, Steps.BAT_HIT_FLASH):
			return

		# [STEP-2.2.3]: Flash the entire bat to emphasize hit contact
		var hit_flash_time: float = 0.02
		await _async_flash(_box, _box.hit_flash_sprites, hit_flash_time)
```

### 2. Add the `_async_flash` helper

At the bottom of `class Feedback` (after `async_on_died()`), add a new method:

```gdscript
	func _async_flash(node: Node, sprites: Array[Sprite2D], duration: float) -> void:
		for sprite in sprites:
			sprite.visible = true

		await Wait.on(node, duration).timeout

		for sprite in sprites:
			sprite.visible = false
```

The whole `class Feedback` should now read:

```gdscript
class Feedback:
	var _box: BatJuiceBox

	func _init(box: BatJuiceBox) -> void:
		_box = box


	func async_on_hit() -> void:
		Game.services.sound.play_sfx(_box.hit_sound)

		if not Steps.check(_box, Steps.BAT_HIT_FLASH):
			return

		# [STEP-2.2.3]: Flash the entire bat to emphasize hit contact
		var hit_flash_time: float = 0.02
		await _async_flash(_box, _box.hit_flash_sprites, hit_flash_time)


	func async_on_died() -> void:
		pass


	func _async_flash(node: Node, sprites: Array[Sprite2D], duration: float) -> void:
		for sprite in sprites:
			sprite.visible = true

		await Wait.on(node, duration).timeout

		for sprite in sprites:
			sprite.visible = false
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **👹 Hitflash** off and on.
3. Shoot a bat **Left Mouse Button** and notice what happens when your shots connect!
<br>
<br>
> [!IMPORTANT]  
>
> Git command to auto-complete this step: `git checkout step-2.2.3`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 11 · 2.2.2 — 🍋 Muzzle Flash](11-muzzle-flash.md) | [Table of Contents](00-contents.md) | [Part 3 — Camera & Time →](12.1-part-3-camera-time.md)
