import app from "ags/gtk4/app"
import GLib from "gi://GLib"
import Astal from "gi://Astal?version=4.0"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import AstalHyprland from "gi://AstalHyprland"
import AstalWp from "gi://AstalWp"
import AstalNetwork from "gi://AstalNetwork"
import AstalTray from "gi://AstalTray"
import AstalBluetooth from "gi://AstalBluetooth"
import { For, With, createBinding, onCleanup } from "ags"
import { createPoll } from "ags/time"
import { exec, execAsync } from "ags/process"

// Map window class to nerd font icon
const windowIcons: Record<string, string> = {
  "1Password": "󰢁",
  "Alacritty": "",
  "Bitwarden": "󰞀",
  "DBeaver": "",
  "Element": "󰭹",
  "Github Desktop": "󰊤",
  "Postman": "󰛮",
  "Slack": "󰒱",
  "Spotify": "",
  "code": "󰨞",
  "code-url-handler": "󰨞",
  "discord": "󰙯",
  "firefox": "",
  "foot": "",
  "google-chrome": "",
  "google-chrome-stable": "",
  "kitty": "",
  "libreoffice-calc": "󱎏",
  "libreoffice-writer": "",
  "mpv": "",
  "org.gnome.Nautilus": "󰉋",
  "org.telegram.desktop": "",
  "pavucontrol": "",
  "steam": "",
  "thunar": "󰉋",
  "thunderbird": "",
  "vesktop": "󰙯",
  "vlc": "󱍼",
  "com.mitchellh.ghostty": "",
  "ghostty": "",
  "zen": "",
  "zen-browser": "",
  "obsidian": "󱓧",
  "prusa-slicer": "󰐪",
  "org.kde.okular": "",
  "zathura": "",
  "com.obsproject.Studio": "󱜠",
}

function getWindowIcon(className: string): string {
  if (windowIcons[className]) return windowIcons[className]
  // Fuzzy match for firefox variants, steam apps, etc.
  const lower = className.toLowerCase()
  if (lower.includes("firefox")) return ""
  if (lower.includes("steam_app")) return ""
  if (lower.includes("chrome")) return ""
  return ""
}

// ── Workspaces ──────────────────────────────────────────────
const workspaceIcons: Record<number, string> = {
  1: "󰎤", 2: "󰎧", 3: "󰎪", 4: "󰎭", 5: "󰎱",
  6: "󰎳", 7: "󰎶", 8: "󰎹", 9: "󰎼", 10: "󰽽",
}

function Workspaces() {
  const hyprland = AstalHyprland.get_default()
  const workspaces = createBinding(hyprland, "workspaces")
  const focusedWs = createBinding(hyprland, "focusedWorkspace")

  return (
    <box class="Workspaces">
      <For each={workspaces((ws) =>
        ws.filter((w) => w.id > 0).sort((a, b) => a.id - b.id)
      )}>
        {(ws) => {
          const clients = createBinding(ws, "clients")
          const icon = workspaceIcons[ws.id] ?? ""

          return (
            <button
              class={focusedWs((fw) => fw === ws ? "ws focused" : "ws")}
              onClicked={() => ws.focus()}
            >
              <box spacing={4}>
                <label label={icon} />
                <box class="ws-windows">
                  <For each={clients}>
                    {(client) => (
                      <label
                        class="ws-window-icon"
                        label={createBinding(client, "initialClass")(
                          (cls) => getWindowIcon(cls)
                        )}
                      />
                    )}
                  </For>
                </box>
              </box>
            </button>
          )
        }}
      </For>
    </box>
  )
}

// ── Focused Window ──────────────────────────────────────────
function FocusedWindow() {
  const hyprland = AstalHyprland.get_default()
  const focused = createBinding(hyprland, "focusedClient")

  return (
    <box class="FocusedWindow">
      <With value={focused}>
        {(client) =>
          client && (
            <box spacing={6}>
              <label
                class="window-icon"
                label={createBinding(client, "initialClass")(
                  (cls) => getWindowIcon(cls)
                )}
              />
              <label
                class="window-title"
                label={createBinding(client, "title")((t) =>
                  t.length > 60 ? t.substring(0, 57) + "..." : t
                )}
              />
            </box>
          )
        }
      </With>
    </box>
  )
}

// ── Clock ───────────────────────────────────────────────────
function Clock() {
  const time = createPoll("", 1000, () =>
    GLib.DateTime.new_now_local().format("%H:%M")!
  )
  const date = createPoll("", 60000, () =>
    GLib.DateTime.new_now_local().format("%a %b %d")!
  )

  return (
    <menubutton class="Clock module">
      <box spacing={6}>
        <label label="" />
        <label label={time} />
      </box>
      <popover>
        <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
          <label class="date-label" label={date} />
          <Gtk.Calendar />
        </box>
      </popover>
    </menubutton>
  )
}

// ── System Tray ─────────────────────────────────────────────
function SysTray() {
  const tray = AstalTray.get_default()
  const items = createBinding(tray, "items")

  const init = (btn: Gtk.MenuButton, item: AstalTray.TrayItem) => {
    btn.menuModel = item.menuModel
    btn.insert_action_group("dbusmenu", item.actionGroup)
    item.connect("notify::action-group", () => {
      btn.insert_action_group("dbusmenu", item.actionGroup)
    })
  }

  return (
    <box class="SysTray">
      <For each={items}>
        {(item) => (
          <menubutton class="tray-item" $={(self) => init(self, item)}>
            <image gicon={createBinding(item, "gicon")} />
          </menubutton>
        )}
      </For>
    </box>
  )
}

// ── Audio ───────────────────────────────────────────────────
function Audio() {
  const wp = AstalWp.get_default()!
  const speaker = wp.defaultSpeaker!

  const volumeIcons = ["", "", ""]
  const icon = createBinding(speaker, "volume")((v) => {
    if (speaker.mute) return "󰝟"
    const idx = Math.min(Math.floor(v * 3), 2)
    return volumeIcons[idx]
  })

  const label = createBinding(speaker, "volume")((v) =>
    `${Math.round(v * 100)}%`
  )

  return (
    <menubutton class="Audio module">
      <box spacing={4}>
        <label class="icon" label={icon} />
        <label label={label} />
      </box>
      <popover>
        <box spacing={8}>
          <label label="" />
          <slider
            widthRequest={200}
            onChangeValue={({ value }) => speaker.set_volume(value)}
            value={createBinding(speaker, "volume")}
          />
        </box>
      </popover>
    </menubutton>
  )
}

// ── Bluetooth ───────────────────────────────────────────────
function Bluetooth() {
  const bt = AstalBluetooth.get_default()
  const powered = createBinding(bt, "isPowered")
  const devices = createBinding(bt, "devices")

  const connectedCount = devices((devs) =>
    devs.filter((d) => d.connected).length
  )

  return (
    <button
      class="Bluetooth module"
      onClicked={() => execAsync("blueman-manager")}
    >
      <label label={powered((on) => on ? "" : "")} />
    </button>
  )
}

// ── Network ─────────────────────────────────────────────────
function Network() {
  const network = AstalNetwork.get_default()
  const wifi = network.wifi

  if (!wifi) return <box />

  return (
    <button class="Network module">
      <image iconName={createBinding(wifi, "iconName")} />
    </button>
  )
}

// ── Gamemode Toggle ─────────────────────────────────────────
function GamemodeToggle() {
  const gamemodeOn = createPoll(false, 1000, () => {
    const result = exec("hyprctl getoption animations:enabled")
    return result.includes("int: 0")
  })

  const toggle = () => {
    execAsync("bash").then(() => {})
    const isOn = exec("hyprctl getoption animations:enabled").includes("int: 0")
    if (isOn) {
      execAsync(["hyprctl", "reload"])
      execAsync(["hyprctl", "notify", "1", "5000", "rgb(d20f39)", "Gamemode [OFF]"])
    } else {
      execAsync(["bash", "-c", [
        'hyprctl --batch "',
        "keyword animations:enabled 0;",
        "keyword decoration:shadow:enabled 0;",
        "keyword decoration:blur:enabled 0;",
        "keyword general:gaps_in 0;",
        "keyword general:gaps_out 0;",
        "keyword general:border_size 1;",
        'keyword decoration:rounding 0"',
      ].join(" ")])
      execAsync(["hyprctl", "notify", "1", "5000", "rgb(40a02b)", "Gamemode [ON]"])
    }
  }

  return (
    <button class="Gamemode module" onClicked={toggle}>
      <label label="🎮" />
    </button>
  )
}

// ── Power Button ────────────────────────────────────────────
function PowerButton() {
  return (
    <button
      class="Power module"
      onClicked={() => execAsync("rofi -show powermenu")}
    >
      <label label="" />
    </button>
  )
}

// ── Bar ─────────────────────────────────────────────────────
export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return (
    <window
      visible
      namespace="bar"
      name={`bar-${gdkmonitor.connector}`}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox cssName="bar">
        <box $type="start" spacing={8}>
          <FocusedWindow />
        </box>
        <box $type="center">
          <Workspaces />
        </box>
        <box $type="end" spacing={4}>
          <SysTray />
          <GamemodeToggle />
          <Bluetooth />
          <Network />
          <Audio />
          <Clock />
          <PowerButton />
        </box>
      </centerbox>
    </window>
  )
}
