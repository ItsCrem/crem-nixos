{ 
inputs,
outputs,
lib,
...
}:{

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autocd = true;
		shellAliases = {
			fzf-bat = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
		};
		
		autosuggestion.enable = true;
		history = {
			extended = true;
			ignoreAllDups = true;
		};
		syntaxHighlighting = {
			enable = true;
			catppuccin.enable = true;
		};
		initExtra = ''	
			bindkey '^[[1;5C' emacs-forward-word
			bindkey '^[[1;5D' emacs-backward-word
			zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
			zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
			zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
			path+=('/home/crem/go/bin')
		'';
  };
}
