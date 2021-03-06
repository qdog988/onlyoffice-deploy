#!/usr/bin/env bash
git pull
var=$(cat .config)
arr=()
for element in $var
do
    arr[${#arr[*]}]=$element
done
echo ${arr[0]} ${arr[1]};
data=${arr[0]}
tag=${arr[1]}

export basedir=$data
export tag=$tag

bash pullImage.sh $tag

cd $data/service
echo "reinstall service"
docker-compose up -d
cd -
sleep 30

cp -r resource/* $data/resource
bash initTools.sh 2

cd $data/workspace
echo "reinstall apps"
docker-compose up -d

cd -


cd $data/nginx
echo "reinstall nginx"
docker-compose up -d

cd -

bash fontsService.sh

bash restart.sh

bash clearImages.sh
echo "你开始使用毕升Office即表示你同意链接 https://bishengoffice.com/apps/blog/posts/agreement.html 中的内容"
echo "在你的浏览器中打开 http://IP 即可访问毕升文档"
