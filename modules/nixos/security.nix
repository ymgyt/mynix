{ ... }:
{
  security.rtkit.enable = true;

  # SSO アカウントは CLI 単体でサインインできず、 デスクトップアプリ連携が必須。
  # システムモジュールで op に setgid ラッパ + polkit を付与し、 アプリと連携させる。
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "ymgyt" ];
  };
}
