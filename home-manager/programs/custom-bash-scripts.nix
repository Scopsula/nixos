{ pkgs, ... }:

let
  prism-sandbox = pkgs.writeShellScriptBin "prism-sandbox" ''
    set -x
    exec bwrap \
	--unshare-user \
	--unshare-ipc \
	--unshare-pid \
	--unshare-uts \
	--unshare-cgroup \
	--die-with-parent \
	--dev /dev \
	--proc /proc \
	--ro-bind /nix /nix \
	--ro-bind /etc /etc \
	--tmpfs /tmp \
	--share-net \
	--ro-bind /run/systemd/resolve /run/systemd/resolve \
	--ro-bind /run/opengl-driver /run/opengl-driver \
	--dev-bind-try /dev/dri /dev/dri \
	--ro-bind-try /sys/class /sys/class \
	--ro-bind-try /sys/dev/char /sys/dev/char \
	--ro-bind-try /sys/devices/pci0000:00 /sys/devices/pci0000:00 \
	--ro-bind-try /sys/devices/system/cpu /sys/devices/system/cpu \
	--setenv XDG_RUNTIME_DIR /tmp \
	--ro-bind-try "$XDG_RUNTIME_DIR/pulse" /tmp/pulse \
	--ro-bind-try "$XDG_RUNTIME_DIR/pipewire-0" /tmp/pipewire-0 \
	--bind "$INST_DIR" "$INST_DIR" \
	--ro-bind "$HOME/.local/share/PrismLauncher/libraries" "$HOME/.local/share/PrismLauncher/libraries" \
	--ro-bind "$HOME/.local/share/PrismLauncher/assets" "$HOME/.local/share/PrismLauncher/assets" \
	--unsetenv XDG_DATA_HOME \
	--unsetenv DBUS_SESSION_BUS_ADDRESS \
	--ro-bind-try "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" "/tmp/$WAYLAND_DISPLAY" \
	-- \
	"$@"
  '';

  prism-skyblock-sandbox = pkgs.writeShellScriptBin "prism-skyblock-sandbox" ''
    set -x
    exec bwrap \
	--unshare-user \
	--unshare-ipc \
	--unshare-pid \
	--unshare-uts \
	--unshare-cgroup \
	--die-with-parent \
	--dev /dev \
	--proc /proc \
	--ro-bind /nix /nix \
	--ro-bind /etc /etc \
	--tmpfs /tmp \
	--share-net \
	--ro-bind /run/systemd/resolve /run/systemd/resolve \
	--ro-bind /run/opengl-driver /run/opengl-driver \
	--dev-bind-try /dev/dri /dev/dri \
	--ro-bind-try /sys/class /sys/class \
	--ro-bind-try /sys/dev/char /sys/dev/char \
	--ro-bind-try /sys/devices/pci0000:00 /sys/devices/pci0000:00 \
	--ro-bind-try /sys/devices/system/cpu /sys/devices/system/cpu \
	--setenv XDG_RUNTIME_DIR /tmp \
	--ro-bind-try "$XDG_RUNTIME_DIR/pulse" /tmp/pulse \
	--ro-bind-try "$XDG_RUNTIME_DIR/pipewire-0" /tmp/pipewire-0 \
	--bind "$INST_DIR" "$INST_DIR" \
	--ro-bind "$HOME/.local/share/PrismLauncher/libraries" "$HOME/.local/share/PrismLauncher/libraries" \
	--ro-bind "$HOME/.local/share/PrismLauncher/assets" "$HOME/.local/share/PrismLauncher/assets" \
	--bind "$HOME/.local/share/PrismLauncher/assets/skins" "$HOME/.local/share/PrismLauncher/assets/skins" \
	--unsetenv XDG_DATA_HOME \
	--unsetenv DBUS_SESSION_BUS_ADDRESS \
	--ro-bind-try "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" "/tmp/$WAYLAND_DISPLAY" \
	-- \
	"$@"
  '';
in

{
  home.packages = [
    prism-sandbox
    prism-skyblock-sandbox
  ];
}
