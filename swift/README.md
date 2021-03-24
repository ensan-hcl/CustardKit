## 環境

Swift5.3以上。

## プロジェクトで利用する場合

### Swift Package Managerを用いる場合

Xcodeから他のパッケージと同様に追加できます。

### Swift Package Managerを用いない場合

直接プロジェクトに`sources/CustardKit.Swift`を入れてください。

## コマンドラインから実行する場合

セットアップとして、コマンドラインにて以下を実行してください。実行によって`libCustardKit.dylib`と`CustardKit.swiftmodule`が生成されます。

```
swiftc -emit-library -emit-module {{{CustardKit.swiftのpath}}} -module-name CustardKit
```

利用の際には以下のようにしてください。

```
swift -I {{{CustardKit.swiftmoduleのあるdirectory}}} -L {{{libCustardKit.dylibのあるdirectory}}} -lCustardKit {{{CustardKitを用いるSwiftファイルのpath}}}
```

`examples`ディレクトリ内で作業を行う場合は以下の通りにすれば問題なく動きます。

```
swiftc -emit-library -emit-module ../sources/CustardKit.swift -module-name CustardKit
swift -I . -L . -lCustardKit Example.swift
```

