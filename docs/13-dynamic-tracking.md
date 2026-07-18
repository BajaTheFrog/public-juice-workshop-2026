# Step 13 · 3.1.1 — 📺 Dynamic Tracking

_**Part 3: Camera & Time · Kinetics · 3.1.1 — 📺 Dynamic Tracking**_

As with all of these changes, it depends on your game and intended experience etc etc. 

But even a simple game like this can be invigorated with some gentle camera movement that frees it from a locked orientation.  

We'll do this in our game by adding tracking to the player movement.

## Where to go
- **FILE**: `game/content/contexts/play_context/level_juice_box.gd`
- **CLASS**: `Kinetics`
- **FUNCTION**: `track_camera()`
- **COMMENT**: `# [STEP-3.1.1]`

## The changes
In this case we have already written the code to do the work in `_track_player_with_camera`, so we can just call it!

The method should now read:

```gdscript
	func track_camera(camera: GameCamera) -> void:
		var camera_center: Vector2 = Game.services.screen.get_screen_center()
		camera.global_position = camera_center

		if not Steps.check(_box, Steps.CAMERA_TRACKING):
			if camera.zoom != camera.standard_zoom:
				camera.zoom = camera.standard_zoom
			return

		# [STEP-3.1.1]: Track the player's position with the camera
		_track_player_with_camera(camera, camera_center)
```

## Try it

1. Press **J** for the Juice menu.
2. Toggle **📺 Dynamic Tracking** off and on.
3. Move around with **A** / **D**.
<br>
<br>
> [!IMPORTANT HELP] 
>
> Git command to auto-complete this step: `git checkout step-3.1.1`.
> See [Git Help & FAQ](25-appendix-git-help.md) for help.
<br>

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Part 3 — Camera & Time](12.1-part-3-camera-time.md) | [Table of Contents](00-contents.md) | [Step 14 · 3.1.2 — ⏰ Danger Zone Slowmo →](14-danger-zone-slowmo.md)
