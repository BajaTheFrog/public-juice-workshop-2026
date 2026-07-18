# Step 14 · 3.1.2 — ⏰ Danger Zone Slowmo

_**Part 3: Camera & Time · Kinetics · 3.1.2 — ⏰ Danger Zone Slowmo**_

Often times you will hear people describe great moments of focus or intense action as if "time slowed down" or "time stood still". 

Well we can help make time _literally_ slow down in tense moments too! This will enhance that experience and make a player super attuned to how close they are to dying!

## Where to go
- **FILE**: `game/content/entities/player_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `on_danger_changed()`
- **COMMENT**: `# [STEP-3.1.2]`

## The changes
We have some other logic that is tracking bats and how close they are to measure danger. 

Our logic here is to slow down time _more_ the closer the nearest bat is, and speed it back up as we get away. By doing this with a `lerp` (the older cousin of a `Tween`) we can make the transition between time scales _super_ smooth. 

For `time_scale` management reasons we use a special service to do the actual slowing for us. 

The method should now read:

```gdscript
	func on_danger_changed(closeness: float) -> void:
		if not Steps.check(_box, Steps.DANGER_SLOWMO) or closeness <= 0.0:
			Game.services.time.clear_sustained_time(Game.messages.time.danger_zone)
			return

		# [STEP-3.1.2]: As the immediate danger to the player increases, we can slow time
		Game.services.time.set_sustained_time(Game.messages.time.danger_zone, _player, lerpf(1.0, 0.2, closeness))
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **⏰ Danger Zone Slowmo** off and on.
3. Let a bat get close and see how the playback speed of the game changes at different distances to a threat!
<br>
<br>
> [!IMPORTANT HELP] 
>
> Git command to auto-complete this step: `git checkout step-3.1.2`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Step 13 · 3.1.1 — 📺 Dynamic Tracking](13-dynamic-tracking.md) | [Table of Contents](00-contents.md) | [Step 15 · 3.2.1 — 📺 Gun Screenshake →](15-gun-screenshake.md)
