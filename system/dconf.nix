{pkgs, config, ...}:

{
  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases = [{
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        # theme = "WhiteSur-Dark"; # Ini juga bisa dicoba, tapi gtk.theme seharusnya sudah cukup
      };
      # Tambahan untuk Nautilus spesifik jika masih bandel (jarang diperlukan)
      # "org/gnome/nautilus/preferences" = {
        # Ini biasanya tidak ada atau otomatis mengikuti color-scheme
        # Jika ada masalah, cari opsi spesifik Nautilus di dconf-editor
      # };
    };
  }];
}
