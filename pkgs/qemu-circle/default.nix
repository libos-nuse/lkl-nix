{ self, super }:

let
  qemu-arm = super.qemu.override {
    hostCpuTargets = [ "arm-softmmu" ];
    SDL2 = self.SDL;
  };
  diffForCommit = commit: "https://github.com/qemu/qemu/commit/${commit}.diff";
in
  qemu-arm.overrideAttrs (old: rec {
    name = "qemu-circle-${version}";
    version = "2.4.1";
    sha256 = "19936r6x7wal09zh0f1s5y32v4k4z5nmnfb2jf0padmff3808jl9";
    src = self.fetchFromGitHub {
      owner = "rsta2";
      repo = "qemu";
      rev = "7a24a5a051ea83529b057fd18c76ca40eb717392";
      fetchSubmodules = true;
      inherit sha256;
    };

    patches = builtins.tail old.patches ++ [
      (self.fetchurl {
        url = diffForCommit "75e5b70e6b5dcc4f2219992d7cffa462aa406af0";
        sha256 = "0a9a09xy4iy6gnmhlbgj28pvzxwp7h165s3rvpc9n6b7lbm0dibj";
      })
    ];

    stdenv = with self; overrideCC stdenv gcc6;
  })
