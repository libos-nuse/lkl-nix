self: super: {
  qemu-circle = import ./pkgs/qemu-circle { inherit self super; };
  nix-selinux-policy = self.callPackage ./pkgs/nix-selinux-policy { };
}
