"gitdiff.vim  -- 在vim 窗口中执行git diff操作

function! Gitdiff()

python << GIT
import vim
import os


cb = vim.current.buffer
file = cb.name  # file: 当前缓冲区文件名
print file


# 在vim窗口中执行git diff命令(保持vim打开的状态!)
vim.command(":w")  # 退出当前窗口
os.popen("touch ~/www/python/cookbook/pythonCookbook/diff")  # 创建diff输出信息文件
f_handler = open('diff', 'w')  # 可写的方式打开diff文件
sys.stdout = f_handler  # 将控制台输出定向到文件
print os.popen("git diff %s" % file).read() # python调用系统命令
f_handler.close()  # 关闭文件


vim.command(":vs diff")  # 打开diff文件
os.popen("rm -rf diff")  # 删除这个文件
GIT
endfunction
