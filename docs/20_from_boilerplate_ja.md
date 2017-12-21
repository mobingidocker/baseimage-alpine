# Build Docker image from boilerplate

Boilerplateイメージは[ALM用イメージの仕様](./10_overview_ja.md)を満たすようにビルドしたテンプレートです。

## Boilerplateからカスタムイメージを作成する

Dockerfileに`FROM mobingi/baseimage:alpine-3.7`など任意のディストリビューションを指定します。利用できるタグはDockerhubを参照します。

- [https://hub.docker.com/r/mobingi/baseimage/](https://hub.docker.com/r/mobingi/baseimage/)

以下4つの必須ディレクトリを用意します。

- fix-attrs.d (パーミッション修正処理 | Docs => [Fixing ownership & permissions - s6-overlay](https://github.com/just-containers/s6-overlay#fixing-ownership--permissions))
- cont-init.d (起動後の初期化処理 | Docs => [Executing initialization And/Or finalization tasks - s6-overlay](https://github.com/just-containers/s6-overlay#executing-initialization-andor-finalization-tasks))
- services.d (起動するサービスの定義 | Docs => [Writing a service script - s6-overlay](https://github.com/just-containers/s6-overlay#writing-a-service-script))
- cont-finish.d コンテナ停止時の処理 | Docs => [Executing initialization And/Or finalization tasks - s6-overlay](https://github.com/just-containers/s6-overlay#executing-initialization-andor-finalization-tasks))

一般的なイメージならば次の2箇所に手を加えるだけでALM用カスタムイメージとして稼働します。

- `cont-init.d`に初期化処理。
  - 環境変数を利用するためには shbangを `#!/usr/bin/with-contenv bash`とする
- `services.d`にサービス名ディレクトリ+`run`ファイル。
  - フォアグラウンドで稼働するように記述
  - 任意でヘルパーの[execline](https://skarnet.org/software/execline/index.html) Syntaxが利用可能

以下、サンプルを用意しています。

- [example/nginx-statichtml](../example/nginx-statichtml/)
- [example/ubuntu-apache2-php7-with-cron](../example/ubuntu-apache2-php7-with-cron/)
- [example/alpine-nginx-ruby](../example/alpine-nginx-ruby/)

Boilerplateを使わずにカスタムイメージを自作する場合は、s6を使用する必要はありません。

## S6-Overlayについて

S6の詳細は[s6-overlayのREADME](https://github.com/just-containers/s6-overlay)、[s6 | 公式のドキュメント](https://skarnet.org/software/s6/index.html)、ユースケースのサンプルは[s6 - gentoo linux Wiki](https://wiki.gentoo.org/wiki/S6)に載っています。

- https://github.com/just-containers/s6-overlay
- https://skarnet.org/software/s6/index.html
- https://wiki.gentoo.org/wiki/S6
