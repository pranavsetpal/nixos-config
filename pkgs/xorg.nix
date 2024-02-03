{ ... }: {
  home.file.".xinitrc".text = /* bash */ "xserverauth=$XAUTHORITY \n";
}
