


#
#=Ruby Cheat Sheet for Beginner
#

##################################################
# 複数行コメント
##################################################

=begin
コメント
=end



##################################################
# 標準出力
##################################################

# 改行あり
puts "test test"

# 改行なし
print "test test\n"

# デバッグ出力
p ["test test", 1] # ["test test", 1]

# ppは改行、インデントして出力する
require 'pp'
pp Array.new(5) { {:foooaaaa=> :buurruuraa} }
# [{:foooaaaa=>:buurruuraa},
#  {:foooaaaa=>:buurruuraa},
#  {:foooaaaa=>:buurruuraa},
#  {:foooaaaa=>:buurruuraa},
#  {:foooaaaa=>:buurruuraa}]

p Array.new(5) { {:foooaaaa=> :buurruuraa} }
# [{:foooaaaa=>:buurruuraa}, {:foooaaaa=>:buurruuraa}, {:foooaaaa=>:buurruuraa}, {:foooaaaa=>:buurruuraa}, {:foooaaaa=>:buurruuraa}]


##################################################
# 定数
##################################################

# 先頭文字が大文字の変数は定数扱い
VALUE_CONST_FOO = "const value"
ValueConstFoo = "const value2"

##################################################
# グローバル変数
##################################################

$global_var = "this is global"

##################################################
# 変数
##################################################

# シンボルと文字列は異なる
# マニュアル : http://docs.ruby-lang.org/ja/2.1.0/class/Symbol.html

p :foo  # Symbolクラス
p "foo" # stringクラス

# 同じシンボルは必ず同一のオブジェクト
# 文字列そのものが必要でないときは、シンボルを用いる

# [シンボルを使うメリット]
# 文字列生成よりも効率が良い
# 比較が高速
# immutableなので書き換えられる心配がない

# シンボル => 文字列の変換
p :foo.to_s

# 文字列 => シンボルの変換
p "foo".to_sym

# シンボルと文字列の比較
p "foo".to_sym == :foo # true
p :foo.to_s == "foo"   # true
p "foo" == :foo # false

# シンボルか文字列か判定
puts "foo is symbol" if :foo.is_a? Symbol  # "foo is symbol" 
puts "foo is string" if "foo".is_a? String # "foo is string" 

# nilチェック
bar = nil
puts "bar is nil" if bar.nil? # "bar is nil"

##################################################
# 文字列
##################################################

# リテラル
p 'test string #{1+1}' # "test string \#{1+1}"
p "test string #{1+1}" # "test string 2"

# 複数行(改行コード含む)
p 'multi line
string' # "multi line\nstring"

# 複数行(改行コード含まない)
p "multi line "\
"string "\
"pattern 2" # "multi line string pattern 2"

# ヒアドキュメント
p <<EOS
select #{1+1};
EOS
# "select 2;\n"

p <<'EOS'
select #{1+1};
EOS
# "select \#{1+1};\n"

# 文字列結合
a = 'test'
a <<= '-foo'
a = a << '-bar' << '-baz'
puts a # test-foo-bar-baz

# フォーマット
p "%s, this year is %04d" % ["hello", Time.now.year]
# "hello, this year is 2014"

# 比較
p "foo" == "foo" # true

# スライス
p "string"[0]         # => s
p "string"[-2]        # => n
p "string"[-2,100]    # => ng
p "string"[100]       # => nil
p "string".slice(1,3) # => tri

# 文字を含むか調べる
p "rinrin"["i"] # "i"

# 文字を置き換える
t = "rinrin"
while t["i"]
  t["i"] = "@"
end
p "r@nr@n"

# 正規表現で文字を置き換える
t = "ab12345cd"
while t[/\d/]
  t[/\d/] = "-"
end
p t # "ab-----cd"

# エンコード
s1 = 'test'
puts s1.encoding # UTF-8
s2 = s1.encode(Encoding::EUC_JP)
puts s2.encoding # EUC-JP

puts s1 == s2 # true
puts s1.eql? s2 # true
puts s1.eql? 'test' # true

##################################################
# 正規表現
##################################################

# 正規表現
p "abcd" =~ /[a-z]+/

# 置換
p "abcd".sub(/[bc]/, "11") # "a11cd"
p "abcd".gsub(/[bc]/, "11") # "a1111d"

# キャプチャ
"abcd"[/^a([a-z]{2})d$/]
p $1 # bc

# 名前付きキャプチャ
# 正規表現を左に書かないと変数が定義されない
/^a(?<captured>[a-z]{2})d$/ =~ "abcd"
p captured # bc

# マッチした部分を配列で取り出す
p "abcdefghi".scan(/^([ab]+).*?([fg]+).*$/) # [["ab", "fg"]]

##################################################
# Arrayクラス
# http://docs.ruby-lang.org/ja/2.1.0/class/Array.html
##################################################

# 配列(Arrayクラスのオブジェクト)
bar = [:A, :B, :C]
p bar # [:A, :B, :C]

# %記法
p %w/a b c d e/        # ["a", "b", "c", "d", "e"]
p %W/a b c #{1 + 1} e/ # ["a", "b", "c", "2", "e"]

# 配列が空か？
p bar.empty? # false
bar = []
p bar.empty? # true
p bar.nil?   # false : Arrayクラスなので、nilではない

# 置換
a = [1, 2, 3, 4, 5, 6]
a[1,2] = ['A', 'B']
p a # [1, "A", "B", 4, 5, 6]

# 配列の結合
a = [1, 2] + [3, 4]

# 末尾に要素追加
hoge = [1, 2, 3]
hoge << "fooooo"
p hoge # [1, 2, 3, "fooooo"]

# 乗算演算子
p [1] * 10 # [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

# 要素削除
p [1, 2, 3, 1, 2, 3] - [2, 1] # [3, 3]

##################################################
# Hashクラス
# http://docs.ruby-lang.org/ja/2.1.0/class/Hash.html
##################################################

hoge = {:a => 1, :b => 2}
p hoge # {:a=>1, :b=>2}
p hoge[:a] # 1

# 省略表記(キーがシンボルの場合のみ)
hoge = {a: 1, b: 2}
p hoge # {:a=>1, :b=>2}
p hoge[:a] # 1

# 要素追加
hoge[:c] = "ccc"
p hoge # {:a=>1, :b=>2, :c=>"ccc"}

# 長さ
p hoge.length # 3
p hoge.size # 3

##################################################
# イテレート処理
##################################################

# イテレート
bar = [121, 3413, 32432]
bar.each {|v| puts v}
bar.each_with_index {|v, index| puts "#{index} => #{v}"}
# 0 => 121
# 1 => 3413
# 2 => 32432

# map
p (1..10).map {|n| n*2 } # [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

# map (ブロックの代わりにMethodオブジェクトを渡す。&演算子が必要)
p (1..10).map &2.method(:*) # [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

# delete (破壊的メソッド)
p %w/1 2 3 4 5/.delete("2") # "2"

# delete_if
test = %w/a 1 c 4 e/.delete_if do |v|
  v =~ /[0-9]+/
end
p test # ["a", "c", "e"]

# select
test = [1, 2, 3, 4, 5, 6, 7, 8].select do |v|
  v.even?
end
p test # [2, 4, 6, 8]

# select (メソッド名を示すシンボルを渡す。&演算子が必要)
test = [1, 2, 3, 4, 5, 6, 7, 8].select &:even?
p test # [2, 4, 6, 8]

# flatten(平坦化)
p [:a, :b, :c, [:d, :e, [:f]]].flatten # [:a, :b, :c, :d, :e, :f]

# inject,reduce
p (1..10).inject {|sum, n| sum += n} # 55
p (1..10).reduce {|sum, n| sum += n} # 55

# reduce(初期値指定)
p (1..10).reduce(1000) {|sum, n| sum += n} # 1055

##################################################
# Hashのイテレート
##################################################

# ペア(配列)をイテレート
hoge.each {|val| puts "pair: #{val}"}
# pair: [:a, 1]
# pair: [:b, 2]
# pair: [:c, "ccc"]

# keyをイテレート
hoge.each_key {|key| puts "#{key} => #{hoge[key]}"}
# a => 1
# b => 2
# c => ccc

# valueをイテレート
hoge.each_value {|val| puts "val: #{val}"}
# val: 1
# val: 2
# val: ccc

##################################################
# 繰り返し
##################################################

# times
3.times {|n|puts "yay!(#{n})"}
# yay!(0)
# yay!(1)
# yay!(2)

# upto
1.upto(5) {|n|puts n*2}
#2
#4
#6
#8
#10

# Range
for n in 1..3 do
  print n, " "
end
puts
# 1 2 3

for n in 1...3 do
  print n, " "
end
puts
# 1 2


##################################################
# Module
# http://docs.ruby-lang.org/ja/2.1.0/class/Module.html
##################################################

# 名前空間を作る
# モジュールはクラスではないので、インスタンスを作成できない
module HogeModule

  # モジュールの特異メソッドを定義する
  # 下記のように呼び出す
  # HogeModule::hoge
  def self.hoge
    p "hoge module"
  end

  # 名前空間にメソッドを定義する
  # Classにincludeしたときにメソッドとして取り込まれる
  def hoge2
    p "hoge module instance method!"
  end

end

##################################################
# 例外(Kernel#raise)
# http://docs.ruby-lang.org/ja/2.1.0/class/Kernel.html#M_FAIL
##################################################

begin
  raise "error test"
rescue => err
  puts "error!"
ensure
  p err
end
# error!
# <RuntimeError: error test>

##################################################
# Class
# http://docs.ruby-lang.org/ja/2.1.0/class/Object.html
##################################################

# ClassクラスはModuleクラスのサブクラスである
# Classクラスは、Module機能とインスタンス作成機能を持つ
# Class < Module < Object < Kernel (< BasicObject)
class Bar

  # クラス定数
  BAR_CONST = "bar const"
  
  # モジュールを取り込む(Mix-In)
  include HogeModule

  # クラスの特異メソッド(クラスメソッド)
  def Bar.bar
    puts '1 Bar.bar class method called'
  end

  # 通常はselfを使って特異メソッドを定義する
  def self.bar2
    puts 'bar2 called'
  end

  # 特異クラスは下記のようにして定義することも可能
  class << self
    def bar3
      puts 'bar3 called'
    end
    
    def bar4
      puts 'bar4 called'
    end
  end
 
  # コンストラクタ
  def initialize
    puts '3 bar initialize method called'
  end

  # メソッド
  def bar_bar
    'bar_bar method called'
  end

  # boolを返すメソッド
  def is_bar?
    true
  end

  def test
    puts "bar test"
  end

  # private メソッド
  # privateメソッドはレシーバを指定できない
  # そのため、他のインスタンスから呼び出せない
  # privateメソッドは、サブクラスから呼び出し可能(javaとは違う)
  private
  
  def private_bar
    puts "private bar"
  end
  
  def private_bar2
    puts "private bar2"
  end

  # protected メソッド
  # protectedメソッドはレシーバを指定できる
  # サブクラスからも呼び出せる
  # 同じクラスであれば、自分以外のインスタンスのメソッドも呼び出せる
  protected
  
  def protected_bar 
    puts "protected barbar"
  end

  def protected_bar2
    puts "protected barbar2"
  end

  # メソッドを指定してprivateメソッドにする
  def self.test_make_private_method
    puts "test_make_private_method called"
  end
  private_class_method :test_make_private_method
end

# 継承
class Foo < Bar

  # 継承クラスの特異メソッドを呼び出す
  bar

  # selfはメソッドが属しているインスタンスを指す
  # そのためメソッドの外側ではselfはクラス自身を指す
  p self # Foo

  # インスタンス変数のアクセサを自動生成
  attr_accessor :auto_var1, :auto_var2

  # クラス変数
  @@class_var = 'class var'

  # クラス定数
  FOO_CONST = "foo const"

  # クラス内クラス
  class FooFoo
    def initialize
      puts "FooFoo initialized!"
    end
  end

  # コンストラクタ
  def initialize
    puts '2 foo initialize method called'

    # スーパークラスのメソッドを呼び出す
    super

    # インスタンス変数
    @ins_var = 'instance var'

    # メソッドの中ではselfはインスタンスを指す
    p self #<Foo:0x007f1de97a7ac0 @ins_var="instance var">

    # スーパークラスのメソッドを呼び出す
    p is_bar? # true

    # includeしたModuleの確認
    hoge2 # "hoge module instance method!"

  end

  # メソッドのオーバーライド
  def test
    super # 親クラスの同名メソッドを呼び出す
    puts "foo test"
  end

  def get_ins_var
    @ins_var
  end

  # エイリアス定義
  alias :test_alias :test

end

# インスタンス化
foo = Foo.new

# 出力
# 1 Bar.bar class method called
# 2 foo initialize method called
# 3 bar initialize method called

# メソッド呼び出し
puts foo.get_ins_var # instance var

# アクセサを使用
foo.auto_var1 = "generated accessor!"
puts foo.auto_var1 # "generated accessor!"

# 下記はアクセサを定義していないのでエラー
# foo.auto_var5 = 1
## undefined local variable or method `fo' for main:Object (NameError)

# オーバーライドされたメソッドを呼び出す
puts foo.test
# bar test
# foo test

# クラス内クラス
Foo::FooFoo.new # FooFoo initialized!

# クラス定数
p Foo::FOO_CONST # "foo const"
p Foo::BAR_CONST # "bar const"

# const_getはクラスやモジュールの定数、クラスを返す
# シンボルか文字列を渡す
p Foo.const_get(:FOO_CONST) # "foo const"
p Foo.const_get(:BAR_CONST) # "bar const"

# 定義があるか確認
if Foo.const_defined? :FooFoo then
  Foo.const_get(:FooFoo).new # FooFoo initialized!
end

# 定数一覧
p Foo.constants # [:FOO_CONST, :FooFoo]

# 親クラスを得る
p Foo.superclass #Bar

# インスタンス比較
p Foo.new == foo # false
p foo == foo # true

# クラス判定
p foo.instance_of? Foo # true
p foo.instance_of? Bar # false 親クラスはfalse

p foo.is_a? Foo # true
p foo.is_a? Bar # true

# is_a?のエイリアス
p foo.kind_of? Foo # true
p foo.kind_of? Bar # true

# privateメソッド呼び出しはエラー
# foo.private_bar # private method `private_bar' called for #<Foo:0x007fed76611898> (NoMethodError)


##################################################
# Singletonクラス
##################################################

require 'singleton'
class SingletonBar

  include Singleton

end

# 外部からインスタンス作成できない
#SingletonClass.new # private method `new' called for SingletonClass:Class (NoMethodError)

# 作成されるインスタンスは1つだけ
p SingletonBar::instance # <SingletonBar:0x007fabfd941a00>
p SingletonBar::instance # <SingletonBar:0x007fabfd941a00>

# サブクラスもsingleton
class SingletonFoo < SingletonBar

end
p SingletonFoo::instance # <SingletonFoo:0x007f74b77755f0>
p SingletonFoo::instance # <SingletonFoo:0x007f74b77755f0>

##################################################
# キー入力プロンプト
##################################################

puts "are you ok?[y/n]"
case gets
when /^[Yy]/
  puts "yes!"
when /^[Nn]/
  puts "no!"
else
  puts "invalid input!"
end

##################################################
# ファイル読み出し
##################################################

filename = "readme.md"
if File.exist?(filename)
  File.open(filename) do |f|
    f.each_line do |line|
      print line
    end
  end
else
  puts "file not found!"
end

##################################################
# データ埋め込み
# http://docs.ruby-lang.org/ja/2.1.0/method/Object/c/DATA.html
##################################################

# 前後に空白のない__END__だけの行がある場合、その行以降は実行されない
# __END__以降のデータはIOストリームオブジェクトのグローバル定数であるDATAで読み出せる

##################################################
# シャットダウンフック
##################################################

# at_exit関数で登録しておくと、プログラム終了直前にシャットダウンフックを実行させることができる
at_exit {puts "program END!"} # program END!

##################################################
# Active Support (Ruby on Railsを構成するライブラリの1つ)
##################################################

# railsのdebug
# http://guides.rubyonrails.org/debugging_rails_applications.html

# nilもしくは空?
begin
  p bar.blank?     # true
  p bar.prensent?  # false
rescue => e
  p e.message
end



=begin
#過去のやつ

#ハッシュ・連想配列
scores = {"taguchi" => 200, "fkoji" => 400}
scores = {:taguchi => 200, :fkoji => 400}
scores = {taguchi: 200, fkoji: 400}

p scores[:taguchi]
scores[:fkoji] = 600
p scores


p scores.size
p scores.keys
p scores.values
p scores.has_key?(:taguchi)


#変換
x = 50
y = "3"
p x + y.to_i #intに変換 # 53
p x + y.to_f #floatに変換 # 53
p x.to_s + y #stringに変換 # 503

scores = {taguchi: 200, fkoji: 400}

p scores.to_a.to_h
puts "\n\n"


#%を使った便利な記述方法
#puts "he\"llo"
#puts 'he\'llo'

#puts %Q(he"llo)
#puts %(he"llo)
#puts %q(he'llo)

p ["red", "blue"]
p ['red', 'blue']

p %W(red blue)
p %w(red blue)
puts "\n\n"

#書式付きで文字列に値を埋め込む方法
puts "書式付きで文字列に値を埋め込む"
p "name: %s" % "taguchi"
p "name: %10s" % "taguchi"
p "name: %-10s" % "taguchi"

p "id: %05d, rate: %10.2f" % [355, 3.284]

#printf
#sprintf

p sprintf("name: %10s\n", "taguchi")
p sprintf("id: %05d, rate: %10.2f\n", 355, 3.284)
puts "\n\n"


=end