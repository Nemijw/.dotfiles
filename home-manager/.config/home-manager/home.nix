{ config, pkgs, ... }:

{

  home = {
    username = "{$USER}";
    homeDirectory = "/home/{$USER}";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.

    # The packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
        neovim
        atac
        firefox
        sshs
	    less
        xsel
        cargo
	    jq
	    htop-vim
        fzf
        zsh 
        zsh-fzf-tab
        zsh-syntax-highlighting
        oh-my-zsh
        zsh-completions
        zsh-autosuggestions
        #fzf-git-sh
        ripgrep
        fd
        eza
        unzip
        tlrc
        lazygit
        bat
        nb
        tmux
        docker
        neofetch
        bitwarden-cli
        mgitstatus

        #cmake

        go
        #npm
        nodejs
        #dotnet-sdk

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.username}!"
      # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/ubuntu/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
       EDITOR = "nvim";
    };
  };
  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    
    zsh = {
	enable = true;
	autocd = true;
	history = {
	   extended = true;
           ignoreAllDups = true;
           ignoreDups = true;
           ignoreSpace = true;
           share = true;


	};
	enableCompletion = true;
	autosuggestion.enable = true;
	syntaxHighlighting.enable = true;
	oh-my-zsh = {
	   enable = true;
	   plugins = [ "docker-compose" "docker" "eza" "z" "gitfast" "web-search" ];
	   theme = "robbyrussell";
	};
	initExtra = ''
           bindkey '^f' autosuggest-accept
	   bindkey -s ^f "tmux-sessionizer\n"

	   COMPLETION_WAITING_DOTS="true"

           HIST_STAMPS="yyyy-mm-dd"

           if [ -f ~/.aliases ]; then
              . ~/.aliases
           fi

           if [ -f ~/.config/fzf/fzf-settings ]; then
              . ~/.config/fzf/fzf-settings
           fi

           source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
	'';
  };

	  fzf = {
	    enable = true;
	    enableZshIntegration = true;
	  };
  };
}
