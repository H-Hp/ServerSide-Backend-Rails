let user = (name) => {
  return "こんにちは、" + name + "さん";
};

console.log(user("太郎"));

//コンパイル
//TypeScript コンパイラを使用して、TypeScript コードを JavaScript にコンパイル
//tsc app.ts

//実行
//Node.js などの JavaScript ランタイム環境を使用して、生成された JavaScript コードを実行します。
//node app.js

//ts-node
//ts-node は、ソース マップとネイティブ ESM サポートを備えた、node.js の TypeScript 実行および REPL です

//TS Playground
//TypeScript Playground は、TypeScript を学習するための優れたツールです。TypeScript コードを記述し、JavaScript の出力を確認できます。

//型一覧

//プリミティブ型
//boolean//true か false
//number//数字
//string//文字列
//void//値を
//undefined
//null

//オブジェクト型
//Interface
//Class
//Enum
//Array
//Tuple

//その他の型
//any
//object・・・小文字
//unknown
//never

//アサーション型/Assertions
//as const
//as type
//let num = 42;
//let str = num as string;
//any

//非nullアサーション

//atisfiesキーワード

//型一覧ここまで

//型、変数宣言
//型宣言は変数名: 型 = 値の形で行う。
//stringの値の代入はシングルクオート、ダブルクオート、バッククオートの三つから値の代入ができる。
let bool: boolean = true;
let num: number = 1;
let str1: string = "a";
let str2: string = "b";
let str3: string = `c`;

/*型注釈、型推論
今まで通り変数名: 型 = 値で記述するのが、型注釈
型宣言を省略して、代入された値から型を推測してくれるのが、型推論
基本的には型推論を利用することが推奨されます。
変数の初期値を設定しないで宣言した場合はany型となり、型推論ができないので注意が必要です*/
let bool_2 = true;
let num_2 = 1;
let str1_2 = "a";
let str2_2 = "b";
let str3_2 = `c`;
let h_2; // any型
h_2 = "hello";
h_2 = 1;

/*オブジェクト型
オブジェクトの型定義の方法は代表的なもので2つあります。
1つは型定義をそのまま書く方法。
それぞれのキーにどんな値が入るかを定義します。*/
// 型注釈
const Person: {
  name: string;
  age: number;
} = {
  name: "Mike",
  age: 20,
};
// 型推論
const Person2 = {
  name: "Mike",
  age2: 20,
};

//もう1つは型定義の部分を切り出すinterfaceを使う方法です。
//こちらのほうが型定義の使い回しができるため、一般的です。
const author: Author = {
  name: "Haruki",
  age: 99,
  isFamous: false,
};

interface Author {
  name: string;
  age: number;
  isFamous: boolean;
}

//配列
// 型注釈
const human1: string[] = ["Mike", "Anna", "Jason"];
// 型推論
const human2 = ["Mike", "Anna", "Jason"];
let h1 = human1[0];

//タイプの互換性/Type Compatibility
//TypeScript は、構造型付けを使用して型の互換性を判断します。これは、名前に関係なく、同じ構造を持っている場合、2 つの型が互換性があると見なされることを意味します。
//TypeScript での型の互換性の例を次に示します。
//この例では、p1は type を持ち、Point、has はp2type を持ちます{ x: number; y: number }。2 つのタイプの名前は異なりますが、構造が同じであるため、互換性があると見なされます。これは、この例のとで行っているように、 type の値をPointtype の変数に代入できることを意味します。{ x: number; y: number }p1p2
interface Point {
  x: number;
  y: number;
}
let p1: Point = { x: 10, y: 20 };
let p2: { x: number; y: number } = p1;
console.log(p2.x); // Output: 10

//タイプの組み合わせ/Combining Types
//Union Types・Intersection Types・Type Aliases・keyof operator

//タイプガード/ナローイング・Type Guards / Narrowing
//instanceof・typeof・Equality・Truthiness・Type Predicates

//typeof 演算子
//演算子typeofは、変数の型をチェックするために使用されます。変数の型を表す文字列値を返します。
let value: string | number = "hello";
if (typeof value === "string") {
  console.log("value is a string");
} else {
  console.log("value is a number");
}

//＜関数/Functions＞・・・Typing Functions・Function Overloading
//入力関数/Typing Functions
//TypeScript では、関数の入力パラメーターと戻り値の型を示すために、いくつかの異なる方法で関数を型指定できます。

//型を持つ関数宣言
function add(a: number, b: number): number {
  return a + b;
}

//型を持つアロー関数
const multiply = (a: number, b: number): number => {
  return a * b;
};

//機能タイプ:
let divide: (a: number, b: number) => number;
divide = (a, b) => {
  return a / b;
};

//関数のオーバーロード/Function Overloading
//TypeScript の関数のオーバーロードにより、名前が同じでパラメーターが異なる複数の関数を定義できます。呼び出す正しい関数は、実行時に関数に渡される引数の数、型、および順序に基づいて決定されます。
//function add1(a: number, b: number): number;
//function add2(a: string, b: string): string;
function add3(a: any, b: any): any {
  return a + b;
}
console.log(add3(1, 2)); // 3
console.log(add3("Hello", " World")); // "Hello World"

//インターフェース/ Interfaces・・・Types vs Interfaces・Extending Interfaces・Interface Declaration・Hybrid Types
//これはJavaScriptにはない機能です。他のプログラミング言語と同じで、中身の実装を持たずに、メンバーや型の定義だけ持つ機能のこと

//クラス/Classes
//Constructor Params・Constructor Overloading・Access Modifiers・Abstract Classes・Inheritance vs Polymorphism・Method Overriding

//ジェネリック/Generics・・・Generic Types・Generic Constraints
//これもJavaScriptにはない機能です。ジェネリックは実は<>のことです。ジジェネリックは、実際に使われるまで型が決まらないときに、抽象的な型（ジェネリック型）を使うことで、いろいろな型の値を与える関数などを作るときに使います。ジェネリクスは総称型と呼ばれることもあります。

//デコレータ/Decorators

//ユーティリティ型/Utility Types・・・Partial・Pick・Omit・Readonly・Record・Exclude・Extract・NonNullable・Parameters・Return Type・InstanceType・Awaited

//高度なタイプ/Advanced Types・・・Mapped Types・Conditional Types・LiteralTypes・Template Literal Types・RecursiveTypes

//TypeScript モジュール/Modules・・・Namespaces・Ambient Modules・External Modules・Augmentation・Global Augmentation

//Ecosystem/生態系
//Formatting(Prettier)・Linting(ESLint)・Useful Packages・Build Tools

//イテレーターとジェネレーターはJavaScriptと同じ

//メタプログラミングはJavaScriptと同じ
