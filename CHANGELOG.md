# Changelog — jumpapp-ng

This file documents the changes in **jumpapp-ng**, a fork of
[mkropat/jumpapp](https://github.com/mkropat/jumpapp) packaged for Arch Linux on
the [AUR](https://aur.archlinux.org/packages/jumpapp-ng).

Only changes made on top of upstream are listed here. For the upstream history,
see the [upstream repository](https://github.com/mkropat/jumpapp).

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- Support Wayland compositors via `lswt` and `wlrctl` when `$WAYLAND_DISPLAY` is set.
- Reject `-C`, `-R` and `-w` on Wayland.

### Removed

- Remove the Debian and RPM packaging and the `make deb`/`make rpm` targets.

## [1.2.2] - 2026-07-19

### Changed

- `-m` (minimize) now implies force-launch: if no window is found it launches the
  app, so a single keybind cycles launch → focus → minimize. (2026-06-15)

### Fixed

- `keep_workspace` (the `-R` flag) is now declared `local` in `main()`, fixing a
  variable-scope leak where it could be influenced by the environment.
  (2026-06-15)
- `list_pids_for_command_from_procfs()` (the `pgrep`-less fallback path) no
  longer misattributes a PID to the target command when its `/proc/*/cmdline`
  read fails mid-loop (e.g. the process exits between the glob and the read);
  previously the stale `cmd_argv0` from the prior iteration was reused for the
  match. (2026-07-19)
- `reverse_words()` no longer iterates one index past the last array element,
  which produced a spurious empty leading field (silently masked by
  word-splitting today, but latent). (2026-07-19)

[Unreleased]: https://github.com/musqz/jumpapp/compare/v1.2.2...master
[1.2.2]: https://github.com/musqz/jumpapp/compare/v1.2.1...v1.2.2
