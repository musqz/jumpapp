# Changelog — jumpapp-ng

This file documents the changes in **jumpapp-ng**, a fork of
[mkropat/jumpapp](https://github.com/mkropat/jumpapp) packaged for Arch Linux on
the [AUR](https://aur.archlinux.org/packages/jumpapp-ng).

Only changes made on top of upstream are listed here. For the upstream history,
see `debian/changelog`.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

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

[Unreleased]: https://github.com/musqz/jumpapp/commits/master
