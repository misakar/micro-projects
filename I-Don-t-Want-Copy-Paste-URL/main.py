# -*- coding: utf-8 -*-
# !usr/bin/python
"""
    main.py
    ~~~~~~~~~~
        1.模拟登陆github
        2.读取fork仓库的链接
        3.正则匹配获取需要的内容
        4.格式化输出内容
        ~~~~~~~~~~~~~~~~~~~~~~~
        1.实现本地clone
        2.alias 命令别名实现
"""
#　模块导入
from requests import session
from bs4 import BeautifulSoup as bs
import getpass # 隐式输入密码
import urllib2
import re
import sys
import os

#----------inter----------
#USER = raw_input("username$ ")
USER = 'neo1218'
#PASSWORD = getpass.getpass('password$ ')
PASSWORD = 'ZCH411zch'

URL1 = 'https://github.com/login'
URL2 = 'https://github.com/session'

# 模拟登陆github
with session() as s:

    req = s.get(URL1).text # 获取登陆请求
    html = bs(req)
    token = html.find("input", {"name": "authenticity_token"}).attrs['value']
    commit_value = html.find("input", {"name": "commit"}).attrs['value']

    login_data = {'login': USER,
                  'password': PASSWORD,
                  'commit' : 'Sign in',
                  'authenticity_token' : token}
    r1 = s.post(URL2, data = login_data)

    # ~~~~~~~~~~~~~~~~~登陆成功！~~~~~~~~~~~~~~~~~~~~
    # 正则匹配获取所需的内容
    # fork仓库html对象
    response = urllib2.urlopen("https://github.com/%s?tab=activity" % USER)
    content = response.read().decode('utf-8') # 有汉字呀！
    pattern = re.compile('<div.*?class="title.*?>.*?<a.*?</a>.*?<a.*?>(.*?)</a>.*?<a.*?>(.*?)</a>',re.S) # S开启任意匹配模式(包括换行符)
    items = re.findall(pattern, content)
    # items[0][1] 即为匹配的url --> 我不要复制粘贴你啦!
    url = "https://github.com/%s.git" % items[0][1]

    # ~~~~~~~~~~~~~~~~~git clone~~~~~~~~~~~~~~~~~~~~
    # 执行clone
    # branch ---> 仓库分支
    # path  ---> 　仓库路径
    print "now clone --> %s" % items[0][1]
    os.system('git clone %s' % url)
