/bin/sh
#############################
#        install.sh
#       一键安装脚本｀
# 1. 系统依赖安装　2. 命令安装
#############################
# pip安装其他模块
cd ~
#sudo apt-get install python-pip
sudo pip install requests
echo "requests -------> done!"
sudo pip install BeautifulSoup4
echo "BeautifulSoup4 --------> done!"

# 命令安装
# alias别名设置　---> 借用　GNU sed
cd ~
sudo sed -i "2i    alias giturl='python ~/I-Don-t-Want-Copy-Paste-URL/main.py'" ~/.bashrc
echo "-------done!-------"
# done!
