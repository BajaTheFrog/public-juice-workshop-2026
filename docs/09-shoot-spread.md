# Step 09 · 2.1.4 — 🍋 Shoot Spread

_**Part 2: Interactions · Kinetics · 2.1.4 — 🍋 Shoot Spread**_

As with all of these changes - there is no one-size fits all. It depends on your game and your design goals. But one great way to add some _texture_ and _variety_ to otherwise monotonous interactions is to sprinkle in a a little randomness. 

So that's what we will do with our shot angle. We're gonna nudge the trajectory a bit up and down at random to make the stream of bullets a bit more interesting to work with!

Sorry hitscan lovers. 

## Where to go
- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `get_shoot_angle()`
- **COMMENT**: `# [STEP-2.1.4]`

## The changes
Normally we just return whatever angle in degrees has been passed into this function. 

Now we can get a random value between our min (`-_player.shoot_vector_bump`) and our max (`_player.shoot_vector_bump`). 

Then we just add that to our angle to offset it some!

The method should now read:

```gdscript
	func get_shoot_angle(base_degrees: float) -> float:
		if not Steps.check(_box, Steps.SHOOT_SPREAD):
			return base_degrees

		# [STEP-2.1.4]: Randomize the exit trajectory a bit
		return base_degrees + Random.randf_range(-_player.shoot_vector_bump, _player.shoot_vector_bump)
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Shoot Spread** off and on.
3. Hold down **Left Mouse Button** and aim wherever. As you toggle the setting on and off you should notice how the spread of the bullet changes. 
<br>
<br>
> [!IMPORTANT HELP] 
>
> Git command to auto-complete this step: `git checkout step-2.1.4`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 08 · 2.1.3 — 🍋 Gun Knockback](08-gun-knockback.md) | [Table of Contents](00-contents.md) | [Step 10 · 2.2.1 — 🍋 Bigger Bullets →](10-bigger-bullets.md)
