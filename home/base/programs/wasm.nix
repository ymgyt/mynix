{ pkgs, ... }: {
  home.packages = with pkgs; [
    wabt
    wasm-bindgen-cli
  ];
}
