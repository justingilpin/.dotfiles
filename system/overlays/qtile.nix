nixpkgs.overlays = [
                          (self: super: {
                              qtile = super.qtile.overrideAttrs(oldAttrs: {
                              pythonPath = oldAttrs.pythonPath ++ (with self.python37Packages; [
                              keyring
                              xcffib
                              #cairocffi-xcffib
                              setuptools
                              setuptools_scm
                              dateutil
                              dbus-python
                              mpd2
                              psutil
                              pyxdg
                              qtile-extras
                              pygobject3
                            ]);
                          });
                        })];
