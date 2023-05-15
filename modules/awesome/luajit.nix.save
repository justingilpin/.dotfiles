{ config, lib, pkgs, ... }:
{

with import (fetchTarball https://github.com/NixOS/nixpkgs/archive/master.tar.gz) {};
let myluajit = (luajit.overrideAttrs (old: rec {
    name = "luajit-${version}";
    version = "2.1.0-beta3-${rev}";
    rev = "4589430";

    preBuild = ''
      buildFlagsArray+=(CFLAGS+=" -fPIC -O2 -msse4.2" XCFLAGS+=" -DLUAJIT_ENABLE_GC64" LDFLAGS+="-pthread")
    '';
    
    src = fetchFromGitHub {
      inherit rev;
      owner = "openresty";
      repo = "luajit2";
      sha256 = "15fkmkn3fv26vzic594xq2pcdx0wkyr8qksa3rj3nxkdwrndcx0k";
    };
    
    postInstall = ''
      ( cd "$out/include"; ln -s luajit-*/* . )
      ln -s "$out"/bin/luajit-* "$out"/bin/lua
      ln -s "$out/share/luajit-2.1.0-beta3/jit" "$out/share/lua/5.1/jit"
    '';
  })).override {
    self = myluajit;
    packageOverrides = self: super: rec {
      rapidjson = super.callPackage ./pkgs/development/lua-modules/rapidjson { };
    };
  };
in stdenv.mkDerivation {
 name = "luaapp";
 buildInputs = [ myluajit myluajit.pkgs.luaposix ];
}
}
