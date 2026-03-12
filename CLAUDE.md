# Project Notes

## Do NOT change

- `virtualisation.docker.enableNvidia = true` in `system/tdarr-node.nix` — the replacement (`hardware.nvidia-container-toolkit.enable`) does not work for `--gpus all` Docker flag. Ignore the deprecation warning.
- Plymouth theme is managed by Stylix — do not set `boot.plymouth.theme` manually or it will conflict.

## Architecture

- Single-host NixOS config for machine `lovelace`.
- `settings.nix` centralizes user/system settings (hostname, username, locale, etc.).
- `overlays.nix` scans `packages/` directory and auto-builds each package. `broken.nix` lists packages to skip.
- `_sources/generated.nix` is produced by `nvfetcher` (config in `nvfetcher.toml`). Do not edit `_sources/` manually.
- User also maintains a separate nix-darwin config for macOS machines.

## Workflow

- Use `nvfetcher` to bump package sources, then `nh os switch .` to rebuild.
- `nh os switch` requires a real terminal for sudo — won't work from non-interactive shells.
- New files must be `git add`ed before `nix flake check` can see them.

## Known issues (tracked in TODO.md)

- Hyprland window rules in `home/hyprland/windowrules.nix` are disabled — broken after `windowrulev2` -> `windowrule` migration.
- `bat-extras` is broken upstream — commented out in `home/shell.nix`.
