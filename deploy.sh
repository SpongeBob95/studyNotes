#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
yarn build blog:build

# 进入生成的文件夹
cd blog/.vuepress/dist

git init
git add -A
git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:SpongeBob95/studyNotes.git master:gh-pages
# 链接远程仓库
#git remote add origin https://github.com/SpongeBob95/studyNotes.git
# 拉取远程仓库的文件
#git pull --rebase origin master
# 同步更新代码
#git push -u origin master

cd -