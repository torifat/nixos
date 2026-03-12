# NixOS Config TODO

## Hardcoded Values -> settings.nix

- [ ] NFS server IP `10.20.30.51` — `system/nfs.nix:17`
- [ ] NFS mount path `/mnt/rust/Media/media` — `system/nfs.nix:17`
- [ ] Tdarr server URL and node ID — `system/tdarr-node.nix:28-31`
- [ ] Tdarr PUID/PGID — `system/tdarr-node.nix:28`
- [ ] Gaming disk device ID — `gaming/mount.nix:7`
- [ ] DDCutil display index — `home/hyprland/binds.nix:12-13`

## Feature Flags

- [ ] Add feature flags to `settings.nix` (e.g. `enableGaming`, `enableNFS`, `enableTdarr`, `enablePrinting`)
- [ ] Use `lib.mkIf` to conditionally import modules based on flags

## Module System

- [ ] Convert key modules to use `lib.mkEnableOption` / `lib.mkOption` for type checking and conditional enabling
- [ ] Document module dependencies (e.g. which system modules are prerequisites for home modules)

## Code Quality

- [ ] Split `home/hyprland/waybar.nix` (280 lines) — extract window-rewrite icon map to separate file
- [x] Extract flake.nix overlay logic to a separate `overlays.nix`
- [x] Add comments explaining the overlay pattern
- [ ] Remove empty `buildInputs` in `packages/tdarr-node/default.nix:16`
- [ ] Make `nixosConfigurations.lovelace` dynamic using `settings.hostname`

## Documentation

- [ ] Document how to add new custom packages (nvfetcher + `_sources/` + `packages/` workflow)
- [ ] Add comments to `system/default.nix` imports explaining each module
- [ ] Document the home-manager bootstrap process

## Shared Packages Repo (NixOS + Darwin)

- [ ] Create a standalone `nix-packages` flake repo containing:
  - `overlays.nix`, `packages/`, `_sources/`, `nvfetcher.toml`, `broken.nix`
- [ ] Consume it as a flake input in both NixOS and nix-darwin configs
- [ ] Add a local `Makefile`/script to automate the bump workflow:
  - Run `nvfetcher` in the shared repo
  - Commit and push
  - `nix flake update my-packages` in the OS config
  - `nh os switch` / `nh darwin switch`

## Security / Secrets

- [ ] Consider `sops-nix` or `agenix` for sensitive config (server URLs, etc.)

## CI / Tooling

- [ ] Add GitHub Action running `nix flake check` on push
- [ ] Verify `.pre-commit-config.yaml` runs `nixfmt` and `statix`

## Pending Fixes

- [ ] Re-enable window rules after Hyprland `windowrulev2` -> `windowrule` migration — `home/hyprland/windowrules.nix`
- [ ] Re-enable `bat-extras` when fixed upstream — `home/shell.nix`
