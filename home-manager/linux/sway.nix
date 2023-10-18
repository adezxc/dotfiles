{ config, pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      menu = "fuzzel";
      terminal = "alacritty";
      startup = [
        { command = "discord"; }
        { command = "spotify"; }
      ];
      gaps = {
        bottom = 5;
      	left = 5;
      	right = 5;
      	top = 5;
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "us,lt,pl,ua";
      	  xkb_variant = ",,,phonetic";
          xkb_options = "grp:ctrls_toggle";
	      };
       	"type:mouse" = {
      	  accel_profile = "flat";
      	};
      };
      output = {
        "DP-1" = {
      	  adaptive_sync = "on";
      	  mode = "2560x1440@165.080Hz";
      	  pos = "0 0";
      	};
      };
      bars = [
      {
        statusCommand = "i3status-rs config-default.toml";
      	fonts = {
      	  names = [ "Fira Code" "Font Awesome 6 Free"];
      	  size = 10.0;
      	};
      	colors = {
      	  focusedBackground = "#36342f";
      	};
      }
      ];
      workspaceAutoBackAndForth = true;
      defaultWorkspace = "workspace number 1";
      workspaceOutputAssign =
      map (i:
          if i - (i / 2 * 2) == 0 then
            { output = "DP-1"; workspace = toString i; }
          else
            { output = "DP-2"; workspace = toString i; }
        ) (lib.lists.range 1 10);
      keybindings =
      let
      inherit (config.wayland.windowManager.sway.config)
         terminal menu left down up right;
      mod = config.wayland.windowManager.sway.config.modifier;
      in
      {
        "${mod}+Return" = "exec ${terminal}";
        "${mod}+Shift+q" = "kill";
        "${mod}+d" = "exec ${menu}";

        "${mod}+${left}" = "focus left";
        "${mod}+${down}" = "focus down";
        "${mod}+${up}" = "focus up";
        "${mod}+${right}" = "focus right";

        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        "${mod}+Shift+${left}" = "move left";
        "${mod}+Shift+${down}" = "move down";
        "${mod}+Shift+${up}" = "move up";
        "${mod}+Shift+${right}" = "move right";

        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";

        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        "${mod}+v" = "split v";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+comma" = "layout stacking";
        "${mod}+period" = "layout tabbed";
        "${mod}+slash" = "layout toggle split";
        "${mod}+a" = "focus parent";
        "${mod}+s" = "focus child";

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+v" = ''mode "system:  [r]eboot  [p]oweroff  [l]ogout"'';

        "${mod}+r" = "mode resize";

        "${mod}+n" = "exec ${pkgs.mako}/bin/makoctl dismiss";
        "${mod}+Shift+n" = "exec ${pkgs.mako}/bin/makoctl dismiss -a";

        "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioRaiseVolume" =
          "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" =
          "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
      };      
      assigns = {
        "2" = [{ class = "Discord|^Spotify$"; }];
      };
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      image = "../../dist/257871.jpg";
    };
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        blocks = [
          {
            alert = 10.0;
            block = "disk_space";
            info_type = "available";
            interval = 60;
            path = "/";
            warning = 20.0;
          }
          {
            block = "memory";
          }
        	{
        	  block = "amd_gpu";
        	}
          {
            block = "cpu";
        	  format = " $icon $barchart $utilization ";
            interval = 1;
          }
          {
            block = "sound";
          }
        	{
        	  block = "weather";
        	  format = " $icon $weather ($location) $temp ";
        	  service = {
        	    name = "openweathermap";
        	    api_key = "18cced0425affa78695bbde07ef546a4";
        	    city_id = "593116";
        	    units = "metric";
        	  };
        	}
        	{
        	  block = "keyboard_layout";
        	  driver = "sway";
        	  interval = 0.5;
        	}
          {
            block = "time";
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            interval = 60;
          }
        ];
        icons = "awesome6";
        theme = "slick";
      };
    };
  };
}
