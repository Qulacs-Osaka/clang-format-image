# DevOps OsakaUniv

## Build & Test Qulacs in Docker
Requirements: Docker([installation](https://docs.docker.com/engine/install/))

Docker が qulacs-osaka のコンパイルとインストールに必要な環境を用意します． これは他の人とほぼ同じ環境で実行できることから，デバッグにおいて便利です．
Docker のコマンド実行にはルート権限が必要な場合があります．

Ubuntu ベースのコンテナを実行するのに一番簡単な方法は GitHub から pull してくることです．
まず， GitHub Container Registry にログインします．
```bash
docker login ghcr.io
```
ユーザ名とパスワードを尋ねられるので GitHub のものを入力してください．
ただし、 PAT(Persona Access Token) をパスワードの代わりに入力してください．
PAT の作成方法については[このドキュメント](https://docs.github.com/ja/github/authenticating-to-github/creating-a-personal-access-token)を参照してください．
PAT を作成するときは `read:packages` と `write:packages`， `delete:packages` のスコープを有効化してください．

ログインしたらイメージを pull します．
```bash
docker pull ghcr.io/qulacs-osaka/qulacs-ubuntu-conda:latest
```

`.aliases.sh` にコンテナを実行するためのエイリアスを定義しています．まずはそれを読み込みます．
```bash
source .aliases.sh
# To persist, write to .bashrc
echo "source /path/to/.aliases.sh" >> .bashrc
# Or .zshrc
echo "source /path/to/.aliases.sh" >> .zshrc
```
エイリアスから起動するコンテナ名のデフォルトは `ghcr.io/qulacs-osaka/qulacs-ubuntu-pyenv:latest` です． これとは違うコンテナを使用したいときは `.aliases.sh` の `CONTAINER_NAME` を書き換えます． たとえば `CONTAINER_NAME=ghcr.io/qulacs-osaka/qulacs-ubuntu-conda` のようにします． 書き換えた後は `source .aliases.sh` を実行するかターミナルを再起動してください．

ビルドとテストには以下のコマンドを実行します．
```bash
cd /path/to/qulacs-osaka
# Build qulacs-osaka for C++
qulacs_run
# Run test
qulacs_test
# Install Python module into ./dist
qulacs_install
# Run arbitrary commands in containers
qulacs_run ls -la
qulacs_run echo "Hello"
```

Docker イメージを自分でビルドしたい場合は以下のコマンドを実行します．
```bash
cd /path/to/this/repository
docker build -t qulacs-osaka-env -f Dockerfile.ubuntu .
```

CentOS ベースのイメージを使用したいときは `Dockerfile.ubuntu` の代わりに `Dockerfile.centos` を使ってビルドしてください．

## About images
### Which one to use?
Anaconda と一緒にインストールされた便利なパッケージを利用したい場合は `qulacs-ubuntu-conda` を使ってください．イメージのサイズは大きいですが，より汎用的です．  
qulacs-osaka のビルドやテストをしたいだけなら `qulacs-ubuntu-pyenv` を使ってください．利用できるパッケージは限られていますが，イメージのサイズは小さく， qulacs-osaka の開発には十分です．

### `qulacs-ubuntu-conda`
Python environment: Anaconda  
Python version: 3.8.8  
OS: Ubuntu  
GPU Compatible: No  
このイメージの容量は5GBくらいあるので注意してください．

### `qulacs-ubuntu-pyenv`
Python environment: pyenv  
Python version: 3.8.8  
OS: Ubuntu  
GPU Compatible: No  
このイメージはサイズが小さいバージョンです(およそ1.2GB).

## Development in this repository
### Issue
機能や修正ごとに issue を作ってください． 実装の詳細が分からなくてもアイデアや提案として issue の作成だけをしても問題ありません．

### Branch
新機能を開発し始める際には issue に対してブランチを作ってください． ブランチの命名規則は `{issue number}-{feature summary}` です． 例えば `3-role-install-boost` のようにします．区切り文字には `-` を使ってください．

### Pull Request
実装が完了したら今いるブランチから main ブランチに対して Pull Request(PR) を作成してください．新機能の理解とバグの発見のために他の開発者がレビューするようにしてください．
