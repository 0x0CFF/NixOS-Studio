{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    uv                       # [CLI] [RUST] Python 项目管理工具
    ruff                     # [CLI] [RUST] Python 代码格式化工具
  ];
  # 使 UV 将二进制文件安装到 ~/.local/bin 目录中
  environment.localBinInPath = true;
  # 系统环境变量
  environment.variables = {
    # PYPI 安装镜像源
    # 豆瓣     : https://pypi.doubanio.com/simple/
    # 阿里     : https://mirrors.aliyun.com/pypi/simple/
    # 华为     : https://repo.huaweicloud.com/repository/pypi/simple/
    # 清华大学  : https://pypi.tuna.tsinghua.edu.cn/simple/
    UV_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple/";
    # Python 安装镜像源
    # 官方     : https://github.com/astral-sh/python-build-standalone/releases/download
    # 南京大学  : https://mirror.nju.edu.cn/github-release/indygreg/python-build-standalone/
    UV_PYTHON_INSTALL_MIRROR = "https://mirror.nju.edu.cn/github-release/indygreg/python-build-standalone/";
    # 阻止 uv 在需要时自动下载 Python 二进制文件
    UV_PYTHON_DOWNLOADS = "never";
  };
}
