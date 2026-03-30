{ lib, config, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    history = {
      size = 32768;
      save = 32768;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };

    shellAliases = {
      # Navigation
      ".."    = "cd ..";
      "..."   = "cd ../..";
      "...."  = "cd ../../..";
      "....." = "cd ../../../..";

      # Directories
      "dotfiles" = "cd $DOTFILES";
      "dots"     = "cd $DOTFILES";
      "library"  = "cd $HOME/Library";
      "downloads" = "cd $HOME/Downloads";
      "dls"      = "cd $HOME/Downloads";
      "projects" = "cd $HOME/Developer/Personal";
      "prjs"     = "cd $HOME/Developer/Personal";
      "work"     = "cd $HOME/Developer/Work";
      "wrk"      = "cd $HOME/Developer/Work";

      # Git
      "g"    = "git";
      "gs"   = "git status";
      "gb"   = "git branch";
      "gc"   = "git checkout";
      "pull" = "git pull";
      "push" = "git push";

      # Shortcuts
      "c" = "clear";

      # pnpm
      "pb" = "pnpm build";
      "pd" = "pnpm dev";
      "pf" = "pnpm format";
      "pc" = "pnpm check-types";
      "pl" = "pnpm lint";

      # eza
      "l"  = "eza --icons -lF";
      "la" = "eza --icons -lAF";
    };

    sessionVariables = {
      DOTFILES = "$HOME/.dotfiles";
      EDITOR = "nvim";
    };

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # Add directories to PATH without duplicates
        add_to_path() {
          if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
            export PATH="$1:$PATH"
          fi
        }
        add_to_path "$HOME/.node/bin"
      '')
      ''
        # Source secrets if present
        [[ -f ~/.zsh/secrets.zsh ]] && source ~/.zsh/secrets.zsh

        # FNM setup
        eval "$(fnm env --use-on-cd)"

        # Pyenv setup
        export PYENV_ROOT="$HOME/.pyenv"
        [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
        command -v pyenv &>/dev/null && eval "$(pyenv init -)"

        # Keybindings
        bindkey -e
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward
        bindkey '^[w' kill-region

        # Completion styling
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

        # LM Studio
        add_to_path "$HOME/.lmstudio/bin"

        # OrbStack
        [[ -f ~/.orbstack/shell/init.zsh ]] && source ~/.orbstack/shell/init.zsh 2>/dev/null
      ''
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "aws"
        "kubectl"
        "kubectx"
        "command-not-found"
      ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd" "cd" ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      command_timeout = 1000;
      format = "\$os\$username\$hostname\$kubernetes\$directory\$git_branch\$git_status";

      character = {
        success_symbol = "";
        error_symbol = "";
      };

      os = {
        format = "[\$symbol](bold white) ";
        disabled = false;
      };

      os.symbols = {
        Windows = "";
        Arch = "󰣇";
        Ubuntu = "";
        Macos = "󰀵";
        NixOS = "";
      };

      username = {
        style_user = "white bold";
        style_root = "black bold";
        format = "[\$user](\$style) ";
        disabled = false;
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = "on [\$hostname](\$style) ";
        disabled = false;
        style = "202 bold";
      };

      directory = {
        truncation_length = 1;
        truncation_symbol = "…/";
        home_symbol = "󰋜 ~";
        read_only_style = "197";
        read_only = "  ";
        format = "at [\$path](\$style)[\$read_only](\$read_only_style) ";
      };

      git_branch = {
        symbol = " ";
        format = "via [\$symbol\$branch](\$style) ";
        truncation_symbol = "…/";
        style = "bold green";
      };

      git_status = {
        format = "([ \\( \$all_status\$ahead_behind\\)](\$style) )";
        style = "bold green";
        conflicted = "[ \${count}](red) ";
        up_to_date = "[󰘽](green) ";
        untracked = "[󰋗 \${count}](red) ";
        ahead = " \${count}";
        diverged = " \${ahead_count}  \${behind_count}";
        behind = " \${count}";
        stashed = "[ \${count}](green) ";
        modified = "[󰛿 \${count}](yellow) ";
        staged = "[󰐗 \${count}](green) ";
        renamed = "[󱍸 \${count}](yellow) ";
        deleted = "[󰍶 \${count}](red) ";
      };

      kubernetes = {
        format = "via [󱃾 \$context\\(\$namespace\\)](bold purple) ";
        disabled = true;
      };

      vagrant.disabled = true;
      docker_context.disabled = true;
      helm.disabled = true;
      python.disabled = true;
      nodejs.disabled = true;
      ruby.disabled = true;
      terraform.disabled = true;
    };
  };
}
