# Go言語のシンプルなWebサービス

## イメージのビルド

シングルステージか、マルチステージかは、択一です。
シングルステージは開発やデバッグ用、マルチステージは統合テストや本番用と見なすことができます。

  * マルチステージビルド
```
  docker build -t ex4:1.0 .
```
  * シングルステージビルド
```
  docker build -t ex4:dev -f Dockerfile.singlestage .
```

### イメージの実行


マルチステージで開発したコンテナの実行
```
docker run --name ex4 -d -p 9400:8086 ex4:1.0
```

シングルステージで作ったコンテナの実行
```
docker run --name ex4-dev -d -p 9400:8086 ex4:dev
```

## アクセステスト

```
curl http://localhost:9400/ping;echo
```

## コンテナへ入る

シングルステージの場合
```
docker exec -it ex4 bash
```
注意、マルチステージで作られたイメージのコンテナにはログインできません。



## イメージをレジストリへ登録

```
export CR_PAT=YOUR_TOKEN
export USERNAME=YOUR USERID 
echo $CR_PAT | docker login ghcr.io -u $USERNAME --password-stdin
docker tag ex4:1.0 ghcr.io/takara9/ex4:1.0
docker push ghcr.io/takara9/ex4:1.0
```

## クリーンナップ

```
docker stop ex4
docker rm ex4
docker rmi ex4:1.0
docker rmi ghcr.io/takara9/ex4:1.0
```

## GitHubでのリリース方法
メインブランチへ移動してコードを最新化する。そして、ブランチを削除

```
$ git checkout main
$ git pull
$ git branch -d update_branch
```


リリースするTAGを設定する。
ここで付与するTAGはコンテナイメージのタグになるので、リポジトリを確認して、タグ名を決めること。

```
TAG=1.x
$ git tag -a $TAG -m "version $TAG"
$ git push origin $TAG
```
