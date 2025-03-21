{
inputs,
outputs,
lib,
...
}:{
	programs.fzf = {
  		enable = true;
		enableZshIntegration = true;
	};
}
