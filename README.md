# SML#グラフィックスプログラミング環境

## 簡単な始め方

### Windows 11

1. WSL2を有効にしてください。
   1. 「設定」→「システム」→「オプション機能」→「Windowsのその他の機能」から
      「Linux用Windowsサブシステム」にチェックして「OK」を押す。
   2. 指示に従って再起動。
2. 再起動後「ターミナル」を開いて、以下のコマンドを実行し、
   WSL2をアップデートしてください。
   ```sh
   wsl --update
   ```
3. このリポジトリの
   [Releases](https://github.com/uenoB/smlsharp_graphics/releases/)
   から
   [smlsharp_graphics_repl.wsl](https://github.com/uenoB/smlsharp_graphics/releases/download/v0.1.0/smlsharp_graphics_repl.wsl)
   をダウンロードしてください。
4. ダウンロードしたsmlsharp_graphics_repl.wslファイルをエクスプローラから
   開くとインストールが始まり、インストール後に自動でSML#が起動します。
5. 終了するときはグラフィックスを描画するウィンドウを閉じてください。
6. 2回目以降は、「ターミナル」から以下のコマンドで起動してください。
   ```sh
   wsl -d SMLSharpGraphicsRepl
   ```
7. アンインストールするときは「ターミナル」から以下のコマンドを実行してください。
   ```sh
   wsl --unregister SMLSharpGraphicsRepl
   ```

## 対話環境を使わない独立したプログラムを作る

1. `main.sml`にあなたのプログラムを好きに書く
2. `make`コマンドを実行する

エラーがなければ`main`という実行形式ファイルができるので実行する。

## 対話環境をソースからビルドする

OpenGLとGLUTが必要です。
Ubuntuならば`libglut-dev`を`apt install`してください。
macOSならば標準装備です。

SML#コンパイラ自体をソースコードからビルドしたのち、
グラフィックス対話環境をビルドします。
必要なライブラリなどが揃っていれば以下の3ステップでビルドできます。

1. `git clone https://github.com/smlsharp/smlsharp.git`
2. `(cd smlsharp && ./configure && make)`
3. `make -C graphics_repl SMLSHARP_SRCDIR=$PWD/smlsharp`

`graphics_repl`ディレクトリ内に`smlsharp_graphics_repl`という名前の
実行形式ファイルができます。

SML#コンパイラのビルド方法について詳しくは
[SML#ドキュメント](https://smlsharp.github.io/ja/documents/)
をご参照ください。
具体的なビルド手順は
[Dockerfile](wsl/Dockerfile)
を参考にしてください。

## 使い方のまとめ

`graphics`型：「絵」の型
- `empty : graphics` … 何もない、空っぽの絵
- `box : graphics` … 画面中央（原点）に置かれた青い正方形
- `disk : graphics` … 画面中央に置かれた赤い円

`graphics`を変形する基本演算
- 移動
  - `<式1> left <式2>` … 「式1」が表す絵を左に「式2」だけ移動する。
    式1は`graphics`型。
    式2は`int`型または`real`型。
    結果は`graphics`型。
  - `<式1> right <式2>` … 「式1」が表す絵を右に「式2」だけ移動する。
    型は`left`と同じ。
  - `<式1> up <式2>` … 「式1」が表す絵を上に「式2」だけ移動する。
    型は`left`と同じ。
  - `<式1> down <式2>` … 「式1」が表す絵を下に「式2」だけ移動する。
    型は`left`と同じ。
  - `<式1> move <式2>` … 「式1」が表す絵を「式2」が表す変分だけ移動する。
    式1は`graphics`型。
    式2は`int * int`型または`real * real`型で、
    X軸方向およびY軸方向の移動量の組。
    結果は`graphics`型。
- 拡大・縮小
  - `<式1> wide <式2>` … 「式1」が表す絵をX軸方向に「式2」倍に拡大する。
    式1は`graphics`型。
    式2は`int`型または`real`型。
    結果は`graphics`型。
  - `<式1> tall <式2>` … 「式1」が表す絵をY軸方向に「式2」倍に拡大する。
    型は`wide`と同じ
  - `<式1> scale <式2>` … 「式1」が表す絵を「式2」が表す倍率で拡大する。
    式1は`graphics`型。
    式2は`int * int`型または`real * real`型で、
    X軸方向およびY軸方向の拡大率の組。
    結果は`graphics`型。
- 回転
  - `<式1> rot <式2>` … 「式1」が表す絵を原点を中心に「式2」度だけ回転する。
    式1は`graphics`型。
    式2は`int`型または`real`型。
    結果は`graphics`型。
- 色付け
  - `white <式>` … 「式」が表す絵を白色にする。
    式は`graphics`型。結果は`graphics`型。
  - `black <式>` … 「式」が表す絵を黒色にする。
    型は`white`と同じ。
  - `red <式>` … 「式」が表す絵を赤色にする。
    型は`white`と同じ。
  - `green <式>` … 「式」が表す絵を緑色にする。
    型は`white`と同じ。
  - `blue <式>` … 「式」が表す絵を青色にする。
    型は`white`と同じ。
  - `magenta <式>` … 「式」が表す絵を紫色にする。
    型は`white`と同じ。
  - `yellow <式>` … 「式」が表す絵を黄色にする。
    型は`white`と同じ。
  - `cyan <式>` … 「式」が表す絵を水色にする。
    型は`white`と同じ。
  - `<式1> color <式2>` … 「式1」が表す絵を「式2」が表す色にする。
    式1は`graphics`型。
    式2は`int * int * int`型または`real * real * real`型で、
    赤・緑・青の3原色の強さをそれぞれ表す組。
    `int * int * int`型の場合は各色成分を0〜255の範囲で指定。
    `real * real * real`型の場合は各色成分を0.0〜1.0の範囲で指定。
    結果は`graphics`型。

画像の表示・動画の再生
- `draw <式>` … 「式」が表す絵を表示する。
  式の型は`graphics`型。結果は`unit`型。
- `play <式>` … 「式」が表す動画を再生する。
  式の型は`real -> graphics`型。結果は`unit`型。

## 入力に反応する動画を作る機能

キー入力やマウス入力に反応する動画を再生する場合は、`play`ではなく
`start`を用いる。
- `start <式>` … 「式」が表す動画を再生する。
  式の型は`time -> graphics`型。結果は`unit`型。

`play`と`start`は「時間」を表す型が異なる。
`play`では開始からの経過時間が`real`型で提供されている一方、
`start`では抽象的な「一瞬」を表す`time`型で時間が提供される。

`time`型を扱う関数として以下が用意されている。
- 時間
  - `time : time -> real` … `time`型から実経過時間を取り出す関数
- マウス
  - `mouseLeft : time -> bool option`
    … `time`が表す瞬間におけるマウスの左ボタンの状態を返す。
    返り値の`SOME true`はマウスボタンを押した瞬間、
    `SOME false`はマウスボタンを離した瞬間、
    `NONE`はそのどちらでもない
    （この瞬間にはマウスボタンが操作されてしていない）
    ことを表す。
  - `mouseRight : time -> bool option`
    … `time`が表す瞬間におけるマウスの右ボタンの状態を返す。
    返り値の意味は`mouseLeft`と同じ。
  - `mousePos : time -> real * real`
    … その瞬間におけるマウスカーソルの座標を返す。
- キーボード
  - `keyboard : time -> char option`
    … `time`が表す瞬間に押されているキーの文字を返す。
    返り値の`SOME`は押されているキーの文字を、
    `NONE`はその瞬間にはキーが押されていないことを表す。

### 単純な式では書き表せない状態の管理

「ある座標に到達したら跳ね返る」「周囲の影響を受けて速度が変化する」などの
非連続な動画を作りたい場合のために、時間の流れに対して状態を蓄積する関数を
作り出す関数が用意されている。

- `stream : (time * time * 'a -> 'a) -> 'a -> (time -> 'a)`
  … 「前の瞬間における値」から「新しい瞬間における値」を作る関数と
  「初期値」を材料に、`time`から値への関数を作り出す。

この関数は、値の「微小変化」を積分して「時間依存の関数」を作り出す。
例えば、前述した`mouseLeft`は、マウスボタンが押された一瞬にしか`SOME`を
返さないが、マウスが押されている間ずっと`true`を返してくれる関数のほうが
使い勝手が良い場合もあるだろう。そのような関数は以下のとおり`stream`と
`mouseLeft`を組み合わせると作ることができる。

```sml
val mouseLeftButton =
    stream (fn (t, _, b) =>        (* 「今」と「1つ前の値」を受け取る *)
               case mouseLeft t of (* 今のマウスボタンの状態を得る *)
                 NONE => b         (* 動きがなければ「1つ前の値」を選ぶ *)
               | SOME b => b)      (* 動きがあればその値で置き換える *)
           false                   (* 初期値はfalse（＝押されていない） *)
```

`mouseLeftButton`関数の型は`time -> bool`であり、ある「瞬間」を受け取ると、
その瞬間においてマウスボタンは押されていたかどうかを`bool`型で返す。
このように`stream`関数は、「ある瞬間の変化」を蓄積（あるいは積分）し、
「それぞれの瞬間」における蓄積された値を返す能力を持つ。

## 独立したプログラムを作る時に使う機能

対話環境のように背景に格子が欲しいときは以下を用いる。
- `background : graphics`

## License

MIT

## References

- K. Ueno and H. Karato: Functional Reactive Animation with Functions of Time,
  Journal of Information Processing, Vol. 33, pp. 368-376, 2025.
  https://doi.org/10.2197/ipsjjip.33.368
