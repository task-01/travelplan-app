<div id="top"></div>

## 使用技術一覧

<!-- シールド一覧 -->
<!-- 該当するプロジェクトの中から任意のものを選ぶ-->
<p style="display: inline">
  <!-- フロントエンドのフレームワーク一覧 -->
  <img src="https://img.shields.io/badge/-Node.js-000000.svg?logo=node.js&style=for-the-badge">
  <img src="https://img.shields.io/badge/-Bootstrap-000000.svg?logo=bootstrap&style=for-the-badge">
  <img src="https://img.shields.io/badge/-Jquery-0769AD.svg?logo=jquery&style=for-the-badge">
  <!-- バックエンドのフレームワーク一覧 -->
  <img src="https://img.shields.io/badge/-Rails-CC0000.svg?&style=for-the-badge">
  <!-- バックエンドの言語一覧 -->
  <img src="https://img.shields.io/badge/-Ruby-CC342D.svg?logo=ruby&style=for-the-badge">
  <!-- ミドルウェア一覧 -->
  <img src="https://img.shields.io/badge/-Sqlite3-003B57.svg?logo=sqlite&style=for-the-badge&logoColor=white">
  <!-- インフラ一覧 -->
  <img src="https://img.shields.io/badge/-Amazon%20aws-232F3E.svg?logo=amazon-aws&style=for-the-badge">
</p>

## 目次

1. [プロジェクトについて](#プロジェクトについて)
2. [環境](#環境)
3. [ディレクトリ構成](#ディレクトリ構成)
4. [開発環境構築](#開発環境構築)

<br />
<!-- プロジェクト名を記載 -->

## プロジェクト名

ズボラ向け自動旅行プラン作成サイト

<!-- プロジェクトについて -->

## プロジェクトについて背景

旅行プランを自動で簡単に作成・共有ができるサイトです。
プライベートで予定を立てて旅行に行くのが面倒と思い作成しました！

<p align="right"><a href="#top">トップへ</a></p>

## 環境

<!-- 言語、フレームワーク、ミドルウェア、インフラの一覧とバージョンを記載 -->

| 言語・フレームワーク・ミドルウェア | バージョン   |
|--------------------------|--------------|
| Ruby                     | 3.1.4        |
| Rails                    | 6.1.7        |
| Puma                     | 5.0          |
| Webpacker                | 5.4.4        |
| Turbolinks               | 5            |
| Bootstrap                | 5.3.0.alpha3 |
| Devise                   | 4.9.2        |
| RSpec                    | 3.12         |
| Node.js                  | 18.17.1      |
| Sidekiq                  | 7.1.2        |
| Redis                    | 7.2.0        |
| ruby-openai              | 4.2.0        |

その他のパッケージのバージョンは package.json を参照してください

<p align="right"><a href="#top">トップへ</a></p>

![ER図](https://github.com/task-01/travelplan-app/assets/113382858/e8e33a67-b79a-4d98-8dc4-b1b797f555a3)


## ディレクトリ構成

<!-- Treeコマンドを使ってディレクトリ構成を記載 -->

.
├── .bundle
├── .env
├── .gitattributes
├── .gitignore
├── .rspec
├── .rubocop.yml  (and other related .rubocop files)
├── .ruby-version
├── Gemfile (and Gemfile.lock)
├── Procfile
├── README.md
├── Rakefile
├── app
│   ├── assets
│   ├── controllers
│   ├── helpers
│   ├── javascript
│   ├── mailers
│   ├── models
│   └── views
├── bin
├── config
├── db
├── lib
├── log
├── package.json (and package-lock.json)
├── public
├── spec
├── storage
├── test
├── tmp
└── vendor


<p align="right"><a href="#top">トップへ</a></p>

## 開発環境構築

<!-- コンテナの作成方法、パッケージのインストール方法など、開発環境構築に必要な情報を記載 -->

### APIの設定・非同期処理の為にsidekiqとRedisの導入とrailsサーバーの起動

.env ファイルを以下の環境変数例と[環境変数の一覧](#環境変数の一覧)を元に作成

.env
USER=asaatouma
SHELL=/bin/zsh
HOME=/Users/asaatouma
LANG=ja_JP.UTF-8
HOMEBREW_PREFIX=/opt/homebrew
RBENV_SHELL=zsh
TERM_PROGRAM=vscode

CHATGPT_API_KEY=[secret]
AWS_ACCESS_KEY_ID=[secret]
AWS_SECRET_ACCESS_KEY=[secret]


.env ファイルを作成後、以下のコマンドで開発環境を構築

gem sidekiq, gem ruby-openai

bundle install

brew install redis, brew services start redis

### 動作確認

rails serverによりサーバー起動後
http://127.0.0.1:3000 にアクセスできるか確認
アクセスできたら成功

### 環境変数の一覧

| 変数名                  | 役割                                 | デフォルト値     |
|------------------------|--------------------------------------|-----------------|
| USER                   | 現在のユーザー名                      | asaatouma       |
| SHELL                  | 使用しているシェル                    | /bin/zsh        |
| HOME                   | ユーザーのホームディレクトリ          | /Users/asaatouma|
| LANG                   | 使用している言語設定                  | ja_JP.UTF-8     |
| PATH                   | 実行ファイルの検索パス                | [path value]    |
| HOMEBREW_PREFIX        | Homebrewのインストール先              | /opt/homebrew   |
| RBENV_SHELL            | rbenvが使用するシェル                 | zsh             |
| TERM_PROGRAM           | 使用しているターミナルアプリケーション     | vscode          |
| CHATGPT_API_KEY        | ChatGPTのAPI認証キー              　　| [secret]        |
| AWS_ACCESS_KEY_ID      | AWSアクセスキー                       | [secret]        |
| AWS_SECRET_ACCESS_KEY  | AWSのシークレットアクセスキー            | [secret]        |

<p align="right"><a href="#top">トップへ</a></p>
