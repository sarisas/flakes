{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[ ](bold #cba6f7)[ ](bold #f2cdcd)[ ](bold #b4befe)[ ](bold #a6e3a1)";
        error_symbol = "[ ](bold #cba6f7)[ ](bold #f2cdcd)[ ](bold #b4befe)[ ](bold #f38ba8)";
        vimcmd_symbol = "[ NORMAL](bold #fab387)";
        vimcmd_visual_symbol = "[ VISUAL](bold #89dceb)";
      };
      format = builtins.concatStringsSep "" [
        "$username"
        "$hostname"
        "$shlvl"
        "$kubernetes"
        "$directory"
        "$vcsh"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$hg_branch"
        "$docker_context"
        "$package"
        "$cmake"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$golang"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$perl"
        "$php"
        "$purescript"
        "$python"
        "$red"
        "$ruby"
        "$rust"
        "$scala"
        "$swift"
        "$terraform"
        "$vagrant"
        "$zig"
        "$nix_shell"
        "$aws"
        "$gcloud"
        "$openstack"
        "$env_var"
        "$crystal"
        "$custom"
        "$cmd_duration"
        "$lua"
        "$jobs"
        "$line_break"
        "$status"
        "$shell"
        "$character"
      ];
      git_branch.symbol = " ";
      git_commit.tag_disabled = false;
      git_status = {
        ahead = ''⇡''${count}'';
        behind = ''⇣''${count}'';
        diverged = ''⇕⇡''${ahead_count}⇣''${behind_count}'';
        staged = "+$count";
      };
      kubernetes.disabled = false;
      time.disabled = false;
    };
  };
}
