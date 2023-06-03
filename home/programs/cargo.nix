{ pkgs, ...}: {
	home.packages = with pkgs; [
		cargo-make
	];
}
