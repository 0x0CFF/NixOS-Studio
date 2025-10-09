{
  description = "Rust development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        # 读取相对于 flake.nix 根目录的文件
        overrides = (builtins.fromTOML (builtins.readFile (self + "/rust-toolchain.toml")));
        libPath = with pkgs; lib.makeLibraryPath [
          # 此处加载在 Rust 项目中需要的外部库
        ];
      in
      {
        devShells.default = pkgs.mkShell rec {
          nativeBuildInputs = [ pkgs.pkg-config ];
          buildInputs = with pkgs; [
            clang
            llvmPackages.bintools
            rustup                  # Rust 版本管理器（使用 rustup 安装 Rust 时，Cargo 会作为 Rust 工具链的一部分自动安装）
            rustfmt                 # Rust 代码格式化工具
            clippy                  # Rust 代码检查工具
          ];

          RUSTC_VERSION = overrides.toolchain.channel;

          # https://github.com/rust-lang/rust-bindgen#environment-variables
          LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];

          shellHook = ''
            export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
            export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
          '';

          # 将预编译库添加到 rustc 搜索路径
          RUSTFLAGS = (builtins.map (a: ''-L ${a}/lib'') [
            # 此处添加库 (e.g. pkgs.libvmi)
          ]);

          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (buildInputs ++ nativeBuildInputs);


          # 将 glibc、clang、glib 以及其他头文件添加到 bindgen 搜索路径
          BINDGEN_EXTRA_CLANG_ARGS =
          # 包含普通目录路径
          (builtins.map (a: ''-I"${a}/include"'') [
            # 此处添加开发库 (e.g. pkgs.libvmi.dev)
            pkgs.glibc.dev
          ])
          # 包含特殊目录路径
          ++ [
            ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
            ''-I"${pkgs.glib.dev}/include/glib-2.0"''
            ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
          ];
        };
      }
    );
}
