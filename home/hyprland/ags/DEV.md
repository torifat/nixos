# AGS Development

## Quick Start

The NixOS config symlinks `~/.config/ags` to the nix store (read-only).
For local development, run AGS directly from the source directory:

```bash
# Kill any running instance
ags quit

# Run from source (live edits to .scss take effect on restart)
ags run /home/rifat/.config/nixos/home/hyprland/ags
```

## Iterating on Styles

Edit `style.scss`, then restart:

```bash
ags quit && ags run /home/rifat/.config/nixos/home/hyprland/ags
```

## Debugging

```bash
# Open GTK Inspector (live CSS editing, widget tree)
ags inspect

# Check running instance
ags list
```

## CSS Notes

AGS uses **GTK4 CSS**, not web CSS:
- No `display: flex`, `position`, etc. — layout via `<box>`, `<centerbox>`
- `border-radius`, `padding`, `margin`, `background`, `color` work as expected
- Use `rgba()` for transparency (not `alpha()` or `opacity` on backgrounds)
- GTK buttons have default chrome — override with `background: transparent; border: none; box-shadow: none;`
- Icon sizes via `-gtk-icon-size: 16px;`
- Reference: https://docs.gtk.org/gtk4/css-properties.html

## Deploying

After you're happy with changes:

```bash
# Rebuild NixOS config (symlinks ~/.config/ags to store)
nh os switch .
```

## Project Structure

```
ags/
  app.ts              # Entry point
  widget/
    Bar.tsx            # Bar widget
  style.scss           # Styles (SCSS, compiled by AGS)
  tsconfig.json        # TypeScript config
  env.d.ts             # Type declarations
  DEV.md               # This file
```
