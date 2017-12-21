# Docker image for mobingi-alm overview

[Mobingi ALM](https://mobingi.co.jp/cloud/saas)では、次の仕様に沿ったdockerイメージを実行します。

- イメージ作成時(docker image build)
  - コードマウントディレクトリの指定
  - EXPOSE
  - HEALTHCHECK(experimental)
- 実行時(docker container run)
  - コンテナステータスファイルへの書き込み
  - `mobingi-init.sh`の実行


## コードマウントディレクトリの指定

Dockerコンテナを管理する[alm-agent](https://github.com/mobingi/alm-agent)は、コードをマウントするパスを次の優先順で決定します。

1. ALM Templateの [`container_code_dir`セクション](https://learn.mobingi.com/alm-templates-reference#container_code_dir)
1. Dockerイメージの`LABEL:com.mobingi.code_dir`
1. デフォルトの`/var/www/html`

## EXPOSE

コンテナがポートをLISTENする場合、EXPOSEでポートを指定します。

## HEALTHCHECK(experimental)

Dockerイメージ作成時にHEALTHCHECKを含めることができます。<br />
現在は動作に影響しませんが、コンテナ起動後のステータスを監視し、状態によってコンテナを自動リスタートする予定です。

## コンテナステータスファイルへの書き込み

コンテナ起動後、事前処理などの進行状況を `/var/log/container_status` へ書き込みます。<br />
これらはALMのコントロールパネルの表示内容として、[alm-agent](https://github.com/mobingi/alm-agent)がAPIに送信します。

- `installing` : コンテナ起動直後
- `complete`(必須) : すべての処理が完了し、サービスを提供する準備が整った


## `mobingi-init.sh`の実行

コードリポジトリに`mobingi-init.sh`というファイルが含まれていると、[alm-agent](https://github.com/mobingi/alm-agent)はコンテナ実行時に`/tmp/init/init.sh`としてマウントします。

コンテナ起動後の事前処理で`/tmp/init/init.sh`を実行するようにDockerイメージを構成します。

- [起動時の実行例](../s6-defaults/cont-init.d/zz_status_comp)
