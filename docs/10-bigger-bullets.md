# Step 10 · 2.2.1 — 🍋 Bigger Bullets

_**Part 2: Interactions · Feedback · 2.2.1 — 🍋 Bigger Bullets**_

Many of these tips come directly from JW's wonderful talk: _The Art of the Screenshake_. One such tip is as delightful as it simple: Just make your bullets bigger. 

You aren't making a simulation! 
<br>
It doesn't need to "make sense"!
<br>
Get the important stuff IN the player's FACE!

It's easier to track and it feels more powerful. 
JW specifically says "...your bullets should be about the size of your chest."

Again, this is going to make more sense for some styles of games than others, but the point is to lean into the important pieces of your particular game and draw attention to them.

## Where to go
- **FILE**: `game/content/objects/player_bullet_juice_box.gd`
- **CLASS**: `Feedback`
- **FUNCTION**: `_apply_bigger_bullet()`
- **COMMENT**: `# [STEP-2.2.1]`

## The changes
Dead simple change that is only a code-change for consistency with the rest of the group. We just up the scale. 

The method should now read:

```gdscript
	func _apply_bigger_bullet() -> void:
		if not Steps.check(_box, Steps.BIGGER_BULLETS):
			return

		# [STEP-2.2.1]: Increase the size of the bullet (seed) so its more prominent
		_box.body.scale *= 2.0
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **🍋 Bigger Bullets** off and on.
3. Hold down **Left Mouse Button** and aim wherever. The bullets are twice the size and twice as fun!
<br>
<br>
> [!IMPORTANT]  
>
> Git command to auto-complete this step: `git checkout step-2.2.1`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 09 · 2.1.4 — 🍋 Shoot Spread](09-shoot-spread.md) | [Table of Contents](00-contents.md) | [Step 11 · 2.2.2 — 🍋 Muzzle Flash →](11-muzzle-flash.md)
