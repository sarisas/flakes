{ inputs, pkgs, ... }:

{
  imports =
    [ (import ./variables.nix) ] ++
    [ inputs.hyprland.homeManagerModules.default ];
  home.packages = with pkgs;[
    swww
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    hyprpicker
    swaylock-effects
    wofi
    wlogout
    grim
    slurp
    wl-clipboard
    wf-recorder
    glib
    wayland
    direnv
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
    nvidiaPatches = false;
    systemdIntegration = true;
    extraConfig = ''
      $mainMod = SUPER
      monitor = ,highrr,auto,1

      input {
        kb_layout = us 
        follow_mouse = 1
      }

      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        disable_autoreload = false # autoreload is unnecessary on nixos
      }

      general { 
        sensitivity= 1  
        gaps_in = 6
        gaps_out= 10
        border_size = 3
        col.active_border = rgba(206686ff)
        col.inactive_border = 0x00140e10
        apply_sens_to_raw = 1
      }

      dwindle {
        no_gaps_when_only = false
        force_split = 0 
        special_scale_factor = 0.8
        split_width_multiplier = 1.0 
        use_active_for_splits = true
        pseudotile = yes 
        preserve_split = yes 
      }

      master {
        new_is_master = true
        special_scale_factor = 1
        new_is_master = true
        no_gaps_when_only = false
      }

      decoration {
        rounding = 2
        multisample_edges = true
        blur_new_optimizations = 1
        blur = 1
        blur_size = 4
        blur_passes = 3
        drop_shadow = yes
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = 0xff206686
      }

      animations {
        enabled = true
        bezier = smoothIn, 0.25, 1, 0.5, 1
        bezier = overshot,1,1,1,1
        animation = windows, 1, 3, overshot, slide
        animation = windowsOut, 1, 3, overshot, slide
        animation=border,1,4,default
        animation = fade, 1, 10, smoothIn
        animation = fadeDim, 1, 10, smoothIn
        animation = workspaces,1, 3,overshot,slidevert
      }

      # ----------------------------------------------------------------
      # keybindings
      bind = $mainMod, Return, exec, kitty fish
      bind = $mainMod SHIFT, Return, exec, kitty bash
      bind = $mainMod, Q, killactive,
      bind = $mainMod, T, killactive,
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, Space, togglefloating,
      bind = $mainMod, Z, exec, pkill wofi || wofi --show drun
      bind = $mainMod, X, exec, pkill wlogout || wlogout -b 4 
      bind = $mainMod, C, exec, hyprctl dispatch centerwindow none
      bind = $mainMod, P, pseudo,
      bind = $mainMod, Y, pin,
      bind = $mainMod, J, togglesplit,
      bind = $mainMod, E, exec, nemo
      bind = $mainMod, B, exec, pkill -SIGUSR1 .waybar-wrapped
      bind = $mainMod SHIFT, c ,exec, hyprpicker -a
      bind = $mainMod, G,exec, $HOME/.local/bin/toggle_hyprland_layout
      bind = $mainMod, W,exec, pkill wofi || $HOME/.local/bin/wallpaper_picker
      bind = $mainMod, O,exec, $HOME/.local/bin/toggle_opacity
      bind = $mainMod, A,exec, $HOME/.local/bin/toggle_animation
      bind = $mainMod, D,exec, $HOME/.local/bin/toggle_blur
      # screenshot
      bind = ,Print, exec, grimblast --notify --cursor copysave area ~/Pictures/$(date "+%Y-%m-%d"T"%H:%M:%S").png
      bind = $mainMod, Print, exec, grimblast --notify --cursor  copy area
      # switch focus
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      # switch workspace
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      # same as above, but switch to the workspace
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10
      bind = $mainMod CTRL, c, movetoworkspace, empty
      # window control
      bind = SUPER SHIFT, left, movewindow, l
      bind = SUPER SHIFT, right, movewindow, r
      bind = SUPER SHIFT, up, movewindow, u
      bind = SUPER SHIFT, down, movewindow, d
      bind = SUPER CTRL, left, resizeactive, -80 0
      bind = SUPER CTRL, right, resizeactive, 80 0
      bind = SUPER CTRL, up, resizeactive, 0 -80
      bind = SUPER CTRL, down, resizeactive, 0 80
      bind = SUPER ALT, left, moveactive,  -80 0
      bind = SUPER ALT, right, moveactive, 80 0
      bind = SUPER ALT, up, moveactive, 0 -80
      bind = SUPER ALT, down, moveactive, 0 80
      # media and volume controls
      bind = ,XF86AudioRaiseVolume,exec, pamixer -i 5
      bind = ,XF86AudioLowerVolume,exec, pamixer -d 5
      bind = ,XF86AudioMute,exec, pamixer -t
      bind = ,XF86AudioPlay,exec, playerctl play-pause
      bind = ,XF86AudioNext,exec, playerctl next
      bind = ,XF86AudioPrev,exec, playerctl previous
      bind = , XF86AudioStop, exec, playerctl stop
      bind = $mainMod, mouse_down, workspace, e-1
      bind = $mainMod, mouse_up, workspace, e+1
      # mouse binding
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # windowrule
      windowrule = float,title:wlogout
      windowrule = float,title:wofi
      windowrule = noanim,title:wlogout
      windowrule = noanim,title:wofi


      windowrule=nofullscreenrequest,class:firefox
      windowrule=idleinhibit focus,mpv
      windowrule=idleinhibit focus,foot
      windowrule=idleinhibit fullscreen,firefox
      windowrule=float,udiskie
      windowrule=float,title:^(Transmission)$
      windowrule=float,title:^(Volume Control)$
      windowrule=float,title:^(Firefox — Sharing Indicator)$
      windowrule=move 0 0,title:^(Firefox — Sharing Indicator)$
      windowrule=size 700 450,title:^(Volume Control)$
      windowrule=move 40 55%,title:^(Volume Control)$
      windowrulev2 = float, title:^(Picture-in-Picture)$
      windowrulev2 = pin, title:^(Picture-in-Picture)$
      windowrule=float,imv
      windowrule=move 685 100,imv
      windowrule=size 550 900,imv
      windowrule=float,mpv
      windowrule=move 685 100,mpv
      windowrule=size 550 900,mpv
      windowrulev2 = idleinhibit focus, class:^(mpv)$
      windowrulev2 = idleinhibit fullscreen, class:^(firefox)$

      windowrule = workspace 9 silent,discord


      # autostart
      exec-once=hyprctl setcursor Catppuccin-Frappe-Dark 16
      exec-once = swww init && sleep 0.1 && swww img .local/share/default_wallpaper &
      exec-once = sleep 0.1 && swaylock && notify-send "Hey $USER, Welcome back" &
      exec-once = sleep 1 && waybar && mako && nm-applet --indicator &
    '';
  };
}

