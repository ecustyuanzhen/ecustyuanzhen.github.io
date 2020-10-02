---
title: Hello World
---
Welcome to [Hexo][1]! This is your very first post. Check [documentation][2] for more info. If you get any problems when using Hexo, you can find the answer in [troubleshooting][3] or you can ask me on [GitHub][4].

## Quick Start
### Install 
1. Make sure have install `git` [node][5]
2. 安装hexo  `npm install -g hexo-cli`
3. 安装部署插件 `npm install --save hexo-deployer-git`
### Config
编辑 zx-hexo 目录下的 _config.yml 
```xml
deploy:
  type: git
  repo: git@github.com:ecustyuanzhen/ecustyuanzhen.github.io.git
  branch: master
```
### Create a new post

```bibtex
$ hexo new "My New Post"
```
或者拷贝文件到`source/_posts`
More info: [Writing][6]

### Run server
you can skip this step if you want show in origin server
``` bash
$ hexo server
```

More info: [Server][7]

### Generate static files

``` bash
$ hexo generate
```

* additional: remember push origin before deploy 
More info: [Generating][8]

### Deploy to remote sites

``` bash
$ hexo deploy
```

More info: [Deployment][9]

[1]:	https://hexo.io/
[2]:	https://hexo.io/docs/
[3]:	https://hexo.io/docs/troubleshooting.html
[4]:	https://github.com/hexojs/hexo/issues
[5]:	https://nodejs.org/en/download/
[6]:	https://hexo.io/docs/writing.html
[7]:	https://hexo.io/docs/server.html
[8]:	https://hexo.io/docs/generating.html
[9]:	https://hexo.io/docs/one-command-deployment.html