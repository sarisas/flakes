{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
      * {
      font-family: FiraCode Nerd Font;
      font-weight: normal;
      font-size: 13.5px;
      min-height: 0;
      transition-property: background-color;
      transition-duration: 0.5s;
      }
      window#waybar {
        background-color: transparent;
      }
      window > box {
        margin-left: 10px;
        margin-right: 10px;
        margin-top: 8px;
        border: 2px solid #206686;
        border-radius: 0px;
        background-color: rgba(30, 30, 46, 1);
      }
      #workspaces {
        padding-left: 0px;
        padding-right: 4px;
        border-radius: 0px;
      }
      #workspaces button {
        padding-top: 5px;
        border-radius: 0px;
        padding-bottom: 5px;
        padding-left: 6px;
        padding-right: 6px;
      }
      #workspaces button.active {
        background-color: #206686;
        color: rgb(26, 24, 38);
      }
      #workspaces button.urgent {
        color: rgb(26, 24, 38);
      }
      tooltip {
        background: rgb(48, 45, 65);
      }
      tooltip label {
        color: rgb(217, 224, 238);
      }
      #custom-launcher {
        font-size: 16px;
        padding-left: 8px;
        padding-right: 6px;
        color: #7ebae4;
      }
      #clock, 
      #memory, 
      #temperature,
      #cpu,
      #mpd, 
      #custom-wall, 
      #temperature, 
      #backlight, 
      #pulseaudio, 
      #network, 
      #battery, 
      #disk, 
      #idle_inhibitor
      {
        padding-left: 8px;
        padding-right: 8px;
        padding-top: 0px;
        padding-bottom: 0px;
        color: rgb(181, 232, 224);
      }
      #tray {
        padding-right: 8px;
        padding-left: 13px;
      }


    '';
    settings = [{
      "layer" = "top";
      "position" = "top";
      modules-left = [
        "custom/launcher"
        "wlr/workspaces"
        "temperature"
        "idle_inhibitor"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "pulseaudio"
        "pulseaudio#microphone"
        "memory"
        "cpu"
        "disk"
        "network"
        "tray"
      ];
      "custom/launcher" = {
        "format" = " ";
        "on-click" = "pkill wofi || wofi";
        "tooltip" = false;
      };
      "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = {
          "activated" = "";
          "deactivated" = "";
        };
      };
      "disk" = {
        "path" = "/home";
        "format" = "󰋊 {percentage_used}%";
      };
      "custom/wall" = {
        "on-click" = "wallpaper_random";
        "on-click-middle" = "default_wall";
        "on-click-right" = "killall dynamic_wallpaper || dynamic_wallpaper &";
        "format" = " ﴔ ";
        "tooltip" = false;
      };
      "wlr/workspaces" = {
        "format" = "{icon}";
        "on-click" = "activate";
      };
      "pulseaudio" = {
        "scroll-step" = 5;
        "format" = "{icon} {volume}%";
        "format-muted" = "󰸈 Muted";
        "format-icons" = {
          "default" = [ "" "" "󱄠" ];
        };
        "on-click" = "pamixer -t";
        "on-click-right" = "pavucontrol";
        "on-click-middle" = "$HOME/.local/bin/toggle_sound_output";
        "tooltip" = false;
      };
      "pulseaudio#microphone" = {
        "format" = "{format_source}";
        "format-source" = "󰍬 {volume}%";
        "format-source-muted" = "󰍭 Muted";
        "on-click" = "pamixer --default-source -t";
        "on-scroll-up" = "pamixer --default-source -i 5";
        "on-scroll-down" = "pamixer --default-source -d 5";
        "scroll-step" = 5;
        "on-click-right" = "pavucontrol";
      };
      "clock" = {
        "interval" = 1;
        "format" = "{:%I:%M %p  %A %b %d}";
        "tooltip" = true;
        "tooltip-format" = "<tt>{calendar}</tt>";
      };
      "memory" = {
        "interval" = 1;
        "format" = "󰨅 {percentage}%";
        "states" = {
          "warning" = 85;
        };
      };
      "cpu" = {
        "interval" = 1;
        "format" = " {usage}%";
      };
      "network" = {
        "interval" = 1;
        "format" = "說 Connected({ifname})";
        "format-alt" = "  {bandwidthUpBytes}    {bandwidthDownBytes}";
        "format-disconnected" = "說 Disconnected";
        "tooltip" = false;
      };
      "temperature" = {
        "tooltip" = false;
        "thermal-zone" = 2;
        "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
        "format" = " {temperatureC}°C";
      };
      "tray" = {
        "icon-size" = 12;
        "spacing" = 10;
      };
    }];
  };
  programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
  });
}
