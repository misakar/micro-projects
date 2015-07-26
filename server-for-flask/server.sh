#!/bin/bash
#*****************************************
#   server.sh                            *
#   ~~~~~~~~~~                           *
#       linux脚本                        *
#       实现uwsgi+nginx+venv的"一键安装" *
#*****************************************

# 进入/目录,安装所需内库
cd /
yum groupinstall "Development tools"
yum install zlib-devel bzip2-devel pcre-devel openssl-devel ncurses -devel sqlite-devel readline-devel tk-devel

# 检测python版本,更新为2.7
if (python --version) < Python 2.7
then
    cd ~
    wget http://python.org/ftp/python/2.7.5/Python-2.7.5.tar.bz2
    tar xvf Python-2.7.5.tar.bz2
    cd Python-2.7.5
    ./configure --prefix=/usr/local
    make && make altinstall
fi


# 安装python包管理(pip命令)
cd ~
wget https://pypi.python.org/packages/source/d/distribute/distribute-0.6.49.tar.gz
tar xf distribute-0.6.49.tar.gz
cd distribute-0.6.49
python2.7 setup.py install
easy_install pip


# 安装uwsgi服务器
cd ~
pip install uwsgi


# 安装虚拟环境
cd ~
pip install virtualenv


# 安装nginx
cd ~
wget http://nginx.org/download/nginx-1.5.6.tar.gz
tar xf nginx-1.5.6.tar.gz
cd nginx-1.5.6
./configure --prefix=/usr/local/nginx-1.5.6 --with-http_stub_status_module --with-http_gzip_static_module
make && make install

#*****************************************

