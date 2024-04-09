■サービス概要
電子レンジ専用のレシピを生成し、調理時間を短縮してユーザーの自由な時間を増やすサービスです。
ユーザーが食材や料理名を入力すると、生成AIが専用レシピを提案します。
このアプリケーションは家族(もしくは自分)への健康的な手作り料理を提供しつつ時間も捻出したいというニーズに応えます。

■ このサービスへの思い・作りたい理由
料理中はなかなかキッチンから離れられないという悩みから、学習のため時間をより有効に使いたいという願望がこのサービスの開発動機です。
電子レンジをもっと活用することで、下ごしらえから調理、後片付けまでの時間を大幅に短縮できることに気づき、このアイデアが生まれました。

■ ユーザー層について
忙しいワーキングペアレンツ
(小さな子どもがいて、仕事と家庭の両立に追われているが、栄養バランスの取れた手料理を家族に提供したいと考えている。)
家族に健康的な食事を提供したいが料理にかける時間も限られており、尚且つなるべく短縮したいと思っている。以上のニーズが見込めることからターゲットとして適切だと考えます。

リスキリングに取り組んでいる学習者
(資格取得や新しいスキル習得のための学習に多くの時間を割きたいが、経済的かつ健康的な食生活も維持したい。)
自炊＋時短調理ができることで経済的かつ健康的な食生活を実現し、学習時間の増加も見込める可能性がある。以上のニーズが見込めることからターゲットとして適切だと考えます。

■サービスの利用イメージ
ユーザーは簡単に手持ちの食材からレシピを生成し、すぐ調理に取り掛かることができます。
このプロセスを通じて、ユーザーは調理時間の削減・生成されたレシピで新しい料理に挑戦する楽しみ・既存の料理の時短アイディアを体験することができます。

■ ユーザーの獲得について
主にLINEやTwitterでの共有機能を通じて、SNSを介してユーザーの獲得を目指します。
また、知人づてに口コミや紹介をもらって拡散することで、ターゲット層が集まりやすいコミュニティへ認知できる可能性を上げていきます。

■ サービスの差別化ポイント・推しポイント
電子レンジ調理に特化したレシピ生成機能は、既存のレシピサイトやWebアプリケーションにはない独自性を持っています。
また、電子レンジ以外の調理器具をほぼ使わないため、調理と後片付けの手間を最小限に抑えることができます。

■ 機能候補
MVPリリース時に作っていたいもの
・ユーザー登録機能
・ログイン機能
・アプリケーションのトップ画面
・レシピ生成機能(食材を指定して生成)
・レシピ一覧機能
・レシピ詳細機能
・レシピのピン留め機能
・レシピへのコメント機能
・レシピ共有機能

本リリースまでに作っていたいもの
・レシピ検索機能
・レシピ閲覧履歴参照機能
・作成済みレシピの評価機能
・作成済みレシピからランダムで提案機能
・レシピ生成機能(料理名を指定して生成)
・自作レシピ投稿機能
・LINEを利用したログイン機能

■ 機能の実装方針予定
生成AIはopenAIのAPIを使用する予定です。
レシピ生成時の入力フォームにはオートコンプリート機能を実装し、ユーザーの利便性を高めます。
検索機能はマルチ検索を実装し、form objectもしくはconcernを使用する予定です。
LINEとTwitterの共有機能はそれぞれのプラットフォームが提供するAPIを用いて実装する予定です。

■ 使用予定技術
バックエンド
・Ruby 3.3.0
・Ruby on Rails 7.1.3.2

フロントエンド
・Turbo
・Stimulus

CSSフレームワーク
・TailwindCSS

UIコンポーネント
・daisyUI

テンプレートエンジン
・slim

データベース
・postgreSQL

開発環境
・Docker

バージョン管理
・Git
・GitHub

CI/CD
・GitHubActions

テストフレームワーク
・RSpec

テストカバレッジ計測
・simplecov

リントツール
・rubocop

インフラ
・Render
・AWS S3