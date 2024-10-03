local theme = {}

local everbluesh = {}
local catppuccin = {}
local adwaita = {}
local gruvbox_dark = {}
local biscuit = {}
local amarena = {}
local oxocarbon = {}
local tokyonight = {}

everbluesh.bg_dark = "#101619"
everbluesh.bg_dim = "#141b2a"
everbluesh.bg_normal = "#141b1e"
everbluesh.bg_light = "#1b2226"
everbluesh.mid_dark = "#232a2d"
everbluesh.mid_normal = "#3b4244"
everbluesh.mid_light = "#97a09e"
everbluesh.fg_normal = "#dadada"
everbluesh.red = "#ef7d7d"
everbluesh.orange = "#e86b6b"
everbluesh.green = "#8ccf7e"
everbluesh.yellow = "#f4d67a"
everbluesh.lightblue = "#71baf2"
everbluesh.blue = "#55aaeb"
everbluesh.purple = "#ce89df"
everbluesh.magenta = "#c372d7"
everbluesh.cyan = "#67cbe7"
everbluesh.accent = everbluesh.green
everbluesh.systray = everbluesh.mid_normal
everbluesh.aweicon = "/home/youq-chan/.config/awesome/assets/moon.svg"
everbluesh.avatar = ".config/awesome/assets/pfp3.jpg"
everbluesh.gtk = "everbluesh"
everbluesh.icon = ".config/awesome/theme/colorscheme/oxocarbon/assets/icon.svg"
everbluesh.cursor = ".config/awesome/theme/colorscheme/oxocarbon/assets/cursor.png"
everbluesh.icon_theme = ".icons/numix-adwaita"
everbluesh.wallpaper = "~/.config/awesome/theme/assets/wallpaper.png"
everbluesh.wallpapers_path = "/home/youq-chan/.config/awesomeold/theme/colorscheme/everbluesh"

biscuit.bg_dark = "#181515"
biscuit.bg_dim = "#221E1E"
biscuit.bg_normal = "#2B2626"
biscuit.bg_light = "#423939"
biscuit.mid_dark = "#6D5F5F"
biscuit.mid_normal = "#978787"
biscuit.mid_light = "#B6A8A5"
biscuit.fg_normal = "#F4E6D2"
biscuit.red = "#CA3F3F"
biscuit.orange = "#E46A3A"
biscuit.yellow = "#E39C45"
biscuit.green = "#989F56"
biscuit.cyan = "#629386"
biscuit.lightblue = "#517894"
biscuit.blue = "#4A5A8D"
biscuit.purple = "#9F569A"
biscuit.magenta = "#C45497"
biscuit.accent = biscuit.cyan
biscuit.systray = biscuit.mid_normal
biscuit.aweicon = "/home/youq-chan/.config/awesome/assets/moon.svg"
biscuit.avatar = ".config/awesome/assets/pfp3.jpg"
biscuit.gtk = "biscuit"
biscuit.icon = "~/.config/awesome/theme/colorscheme/biscuit/assets/icon.svg"
biscuit.cursor = "~/.config/awesome/theme/colorscheme/biscuit/assets/cursor.png"
biscuit.icon_theme = "~/.icons/numix-adwaita"
biscuit.wallpaper = "~/.config/awesome/theme/assets/wallpaper.png"
biscuit.wallpapers_path = "/home/youq-chan/.config/awesomeold/theme/colorscheme/biscuit"

amarena.bg_dark = "#12161a"
amarena.bg_dim = "#12162e"
amarena.bg_normal = "#1A2026"
amarena.bg_light = "#222a32"
amarena.mid_dark = "#242D35"
amarena.mid_normal = "#526170"
amarena.mid_light = "#5a6b7b"
amarena.fg_normal = "#ffffff"
amarena.red = "#bf616a"
amarena.orange = "#FB6396"
amarena.green = "#a3be8c"
amarena.yellow = "#ebcb8b"
amarena.lightblue = "#6EC1D6"
amarena.blue = "#5e81ac"
amarena.purple = "#CD84C8"
amarena.magenta = "#b48ead"
amarena.cyan = "#88c0d0"
amarena.accent = amarena.orange
amarena.systray = amarena.mid_normal
amarena.aweicon = "/home/youq-chan/.config/awesome/assets/moon.svg"
amarena.avatar = ".config/awesome/assets/pfp3.jpg"
amarena.gtk = "oxocarbon"
amarena.icon = ".config/awesome/theme/colorscheme/oxocarbon/assets/icon.svg"
amarena.cursor = ".config/awesome/theme/colorscheme/oxocarbon/assets/cursor.png"
amarena.icon_theme = ".icons/numix-adwaita"
amarena.wallpaper = "~/.config/awesome/theme/assets/wallpaper.png"
amarena.wallpapers_path = "/home/youq-chan/.config/awesomeold/theme/colorscheme/amarena"

catppuccin.bg_dark = "#181825"
catppuccin.bg_dim = "#1e1e2e"
catppuccin.bg_normal = "#26263a"
catppuccin.bg_light = "#36374A"
catppuccin.mid_dark = "#2d2d46"
catppuccin.mid_normal = "#45475a"
catppuccin.mid_light = "#9399b2"
catppuccin.fg_normal = "#cdd6f4"
catppuccin.red = "#f38ba8"
catppuccin.orange = "#ba6370"
catppuccin.green = "#a6e3a1"
catppuccin.yellow = "#f9e2af"
catppuccin.lightblue = "#89b4fa"
catppuccin.blue = "#5c97f8"
catppuccin.purple = "#f5c2e7"
catppuccin.magenta = "#ed95d5"
catppuccin.cyan = "#94e2d5"
catppuccin.accent = catppuccin.purple
catppuccin.systray = catppuccin.mid_normal
catppuccin.aweicon = "/home/youq-chan/.config/awesome/assets/moon.svg"
catppuccin.avatar = ".config/awesome/assets/pfp3.jpg"
catppuccin.gtk = "catppuccin"
catppuccin.icon = ".config/awesome/theme/colorscheme/oxocarbon/assets/icon.svg"
catppuccin.cursor = ".config/awesome/theme/colorscheme/oxocarbon/assets/cursor.png"
catppuccin.icon_theme = ".icons/numix-adwaita"
catppuccin.wallpaper = "~/.config/awesome/theme/assets/wallpaper.png"
catppuccin.wallpapers_path = "/home/youq-chan/.config/awesomeold/theme/colorscheme/catppuccin"

tokyonight.bg_dark = "#16161e"
tokyonight.bg_normal = "#1a1b26"
tokyonight.bg_light = "#1e2030"
tokyonight.mid_dark = "#24283b"
tokyonight.mid_normal = "#414868"
tokyonight.mid_light = "#828bb8"
tokyonight.fg_dark = "#a0b1d6"
tokyonight.fg_normal = "#c0caf5"
tokyonight.fg_light = "#ffffff"
tokyonight.red = "#f7768e"
tokyonight.orange = "#d8657a"
tokyonight.green = "#9ece6a"
tokyonight.yellow = "#e0af68"
tokyonight.blue = "#7aa2f7"
tokyonight.purple = "#bb9af7"
tokyonight.magenta = "#a589d7"
tokyonight.cyan = "#7dcfff"
tokyonight.accent = tokyonight.purple
tokyonight.systray = tokyonight.mid_normal
tokyonight.aweicon = "/home/youq-chan/.config/awesome/assets/moon.svg"
tokyonight.avatar = ".config/awesome/assets/pfp3.jpg"
tokyonight.gtk = "catppuccin"
tokyonight.icon = ".config/awesome/theme/colorscheme/oxocarbon/assets/icon.svg"
tokyonight.cursor = ".config/awesome/theme/colorscheme/oxocarbon/assets/cursor.png"
tokyonight.icon_theme = ".icons/numix-adwaita"
tokyonight.wallpaper = "~/.config/awesome/theme/assets/wallpaper.png"
tokyonight.wallpapers_path = "/home/youq-chan/.config/awesomeold/theme/colorscheme/tokyonight"

gruvbox_dark.bg_dark = "#1d2021"
gruvbox_dark.bg_normal = "#282828"
gruvbox_dark.bg_light = "#32302f"
gruvbox_dark.mid_dark = "#504945"
gruvbox_dark.mid_normal = "#7c6f64"
gruvbox_dark.mid_light = "#a89984"
gruvbox_dark.fg_dark = "#d5c4a1"
gruvbox_dark.fg_normal = "#ebdbb2"
gruvbox_dark.fg_light = "#fbf1c7"
gruvbox_dark.red = "#fb4934"
gruvbox_dark.orange = "#cc241d"
gruvbox_dark.green = "#b8bb26"
gruvbox_dark.yellow = "#fabd2f"
gruvbox_dark.lightblue = "#83a598"
gruvbox_dark.blue = "#458588"
gruvbox_dark.purple = "#d3869b"
gruvbox_dark.magenta = "#b16286"
gruvbox_dark.cyan = "#8ec07c"
gruvbox_dark.accent = gruvbox_dark.green
gruvbox_dark.systray = gruvbox_dark.mid_normal
gruvbox_dark.aweicon = "/home/youq-chan/.config/awesome/assets/moon.svg"
gruvbox_dark.avatar = ".config/awesome/assets/pfp3.jpg"
gruvbox_dark.gtk = "catppuccin"
gruvbox_dark.icon = ".config/awesome/theme/colorscheme/oxocarbon/assets/icon.svg"
gruvbox_dark.cursor = ".config/awesome/theme/colorscheme/oxocarbon/assets/cursor.png"
gruvbox_dark.icon_theme = ".icons/numix-adwaita"
gruvbox_dark.wallpapers_path = "/home/youq-chan/.config/awesomeold/theme/colorscheme/gruvbox_dark"

adwaita.bg_dark = "#1e1e1e"
adwaita.bg_dim = "#232323"
adwaita.bg_normal = "#282828"
adwaita.bg_light = "#353535"
adwaita.mid_dark = "#444444"
adwaita.mid_normal = "#696969"
adwaita.mid_light = "#a3a3a3"
adwaita.fg_normal = "#eeeeee"
adwaita.red = "#ed333b"
adwaita.orange = "#e66100"
adwaita.yellow = "#ffa348"
adwaita.green = "#57e389"
adwaita.cyan = "#5bc8af"
adwaita.lightblue = "#62a0ea"
adwaita.blue = "#1c71d8"
adwaita.purple = "#c061cb"
adwaita.magenta = "#E05C91"
adwaita.accent = adwaita.blue
adwaita.systray = adwaita.bg_light
adwaita.aweicon = "/home/youq-chan/.config/awesome/assets/star.svg"
adwaita.avatar = ".config/awesome/assets/pfp3.jpg"
adwaita.gtk = "adwaita"
adwaita.icon = "adwaita"
adwaita.cursor = ".config/awesome/theme/colorscheme/adwaita/assets/cursor.png"
adwaita.icon_theme = ".icons/numix-adwaita"
adwaita.wallpapers_path = "/home/youq-chan/.config/awesomeold/theme/colorscheme/adwaita"

oxocarbon.bg_dark = "#161616"
oxocarbon.bg_dim = "#1E1E1E"
oxocarbon.bg_normal = "#262626"
oxocarbon.bg_light = "#393939"
oxocarbon.mid_dark = "#464646"
oxocarbon.mid_normal = "#525252"
oxocarbon.mid_light = "#696969" -- nice
oxocarbon.fg_normal = "#dde1e6"
oxocarbon.red = "#ee5396"
oxocarbon.orange = "#ff7eb6"
oxocarbon.yellow = "#78a9ff"
oxocarbon.green = "#42be65"
oxocarbon.cyan = "#08bdba"
oxocarbon.lightblue = "#82cfff"
oxocarbon.blue = "#33b1ff"
oxocarbon.purple = "#be95ff"
oxocarbon.magenta = "#3ddbd9"
oxocarbon.accent = oxocarbon.yellow
oxocarbon.systray = oxocarbon.bg_light
oxocarbon.aweicon = "/home/youq-chan/.config/awesome/assets/linux.svg"
oxocarbon.avatar = ".config/awesome/assets/pfp3.jpg"
oxocarbon.gtk = "oxocarbon"
oxocarbon.icon = ".config/awesome/theme/colorscheme/oxocarbon/assets/icon.svg"
oxocarbon.cursor = ".config/awesome/theme/colorscheme/oxocarbon/assets/cursor.png"
oxocarbon.icon_theme = ".icons/numix-adwaita"
oxocarbon.wallpapers_path = "/home/youq-chan/.config/awesomeold/theme/colorscheme/adwaita/wall"

function theme.return_theme(color)
  local themes = {
    ["everbluesh"] = function()
      return everbluesh
    end,

    ["gruvbox_dark"] = function()
      return gruvbox_dark
    end,

    ["biscuit"] = function()
      return biscuit
    end,

    ["catppuccin"] = function()
      return catppuccin
    end,

    ["amarena"] = function()
      return amarena
    end,

    ["tokyonight"] = function()
      return tokyonight
    end,

    ["adwaita"] = function()
      return adwaita
    end,

    ["oxocarbon"] = function()
      return oxocarbon
    end,
  }
  return themes[color]()
end

return theme
