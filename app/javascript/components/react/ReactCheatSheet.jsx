"use client"

import React, {
  useState,
  useEffect,
  useRef,
  useContext,
  createContext,
  useCallback,
  useMemo,
  useReducer,
  useId,
  Suspense,
  lazy,
  useTransition,
  useDeferredValue,
  useOptimistic,
  useFormStatus,
  //useFormState,
  useActionState
} from "react"

import { useFormState } from "react-dom"; // ✅ React 19 で追加された
//import { useActionState } from 'react-dom'; // react-dom からインポートする必要があります

// ============================================================
// React 19 チートシート
// ============================================================

export default function React19CheatSheet() {
  return (
    <div className="p-6 max-w-5xl mx-auto">
      <h1 className="text-3xl font-bold text-center mb-8 text-blue-600">React 19.0.0 チートシート</h1>

      {/* 基本的なコンポーネント */}
      <CheatSheetSection title="1. 基本的なコンポーネント">
        <BasicComponentsDemo />
      </CheatSheetSection>

      {/* フック */}
      <CheatSheetSection title="2. React フック">
        <HooksDemo />
      </CheatSheetSection>

      {/* イベント処理 */}
      <CheatSheetSection title="3. イベント処理">
        <EventHandlingDemo />
      </CheatSheetSection>

      {/* 条件付きレンダリングとリスト */}
      <CheatSheetSection title="4. 条件付きレンダリングとリスト">
        <ConditionalAndListDemo />
      </CheatSheetSection>

      {/* フォーム */}
      <CheatSheetSection title="5. フォーム">
        <FormsDemo />
      </CheatSheetSection>

      {/* コンテキスト API */}
      <CheatSheetSection title="6. コンテキスト API">
        <ContextAPIDemo />
      </CheatSheetSection>

      {/* エラーバウンダリ */}
      <CheatSheetSection title="7. エラーバウンダリ">
        <ErrorBoundaryDemo />
      </CheatSheetSection>

      {/* Suspense と遅延ローディング */}
      <CheatSheetSection title="8. Suspense と遅延ローディング">
        <SuspenseAndLazyDemo />
      </CheatSheetSection>

      {/* React 19 の新機能 */}
      <CheatSheetSection title="9. React 19 の新機能">
        <React19FeaturesDemo />
      </CheatSheetSection>

      {/* サーバーコンポーネント */}
      <CheatSheetSection title="10. サーバーコンポーネント">
        <ServerComponentsDemo />
      </CheatSheetSection>

      {/* アクションと use フック */}
      <CheatSheetSection title="11. アクションと use フック">
        <ActionsAndUseHookDemo />
      </CheatSheetSection>
    </div>
  )
}

// セクションコンポーネント
function CheatSheetSection({ title, children }) {
  return (
    <section className="mb-10 border border-gray-200 rounded-lg p-4 shadow-sm">
      <h2 className="text-xl font-semibold mb-4 pb-2 border-b border-gray-200">{title}</h2>
      <div className="space-y-4">{children}</div>
    </section>
  )
}

// コードブロックコンポーネント
function CodeBlock({ code }) {
  return (
    <pre className="bg-gray-100 p-3 rounded-md overflow-x-auto text-sm">
      <code>{code}</code>
    </pre>
  )
}

// ============================================================
// 1. 基本的なコンポーネント
// ============================================================

function BasicComponentsDemo() {
  return (
    <div>
      <h3 className="text-lg font-medium mb-2">関数コンポーネント</h3>
      <CodeBlock
        code={`// 関数コンポーネント
function Greeting({ name }) {
  return <h1>Hello, {name}!</h1>;
}

// アロー関数コンポーネント
const Greeting = ({ name }) => <h1>Hello, {name}!</h1>;

// 使用方法
<Greeting name="React 19" />`}
      />

      <div className="mt-4">
        <h3 className="text-lg font-medium mb-2">コンポーネントの例</h3>
        <div className="bg-white p-4 border rounded-md">
          <Greeting name="React 19" />
        </div>
      </div>

      <div className="mt-4">
        <h3 className="text-lg font-medium mb-2">フラグメント</h3>
        <CodeBlock
          code={`// フラグメントを使用して複数の要素をラップ
function Component() {
  return (
    <>
      <h1>Title</h1>
      <p>Paragraph</p>
    </>
  );
}`}
        />
      </div>
    </div>
  )
}

function Greeting({ name }) {
  return <h1 className="text-xl font-bold">Hello, {name}!</h1>
}

// ============================================================
// 2. React フック
// ============================================================

function HooksDemo() {
  // useState の例
  const [count, setCount] = useState(0)

  // useEffect の例
  useEffect(() => {
    document.title = `Count: ${count}`
    // クリーンアップ関数
    return () => {
      document.title = "React App"
    }
  }, [count]) // 依存配列

  // useRef の例
  const inputRef = useRef(null)

  // useCallback の例
  const handleClick = useCallback(() => {
    setCount((prevCount) => prevCount + 1)
  }, [])

  // useMemo の例
  const doubledCount = useMemo(() => count * 2, [count])

  // useReducer の例
  const [state, dispatch] = useReducer(
    (state, action) => {
      switch (action.type) {
        case "increment":
          return { value: state.value + 1 }
        case "decrement":
          return { value: state.value - 1 }
        default:
          return state
      }
    },
    { value: 0 },
  )

  // useId の例 (React 18+)
  const id = useId()

  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <h3 className="text-lg font-medium mb-2">useState</h3>
          <CodeBlock
            code={`const [count, setCount] = useState(0);

// 更新方法
setCount(1);                    // 直接値を設定
setCount(prevCount => prevCount + 1); // 前の状態を使用`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <p>Count: {count}</p>
            <button onClick={() => setCount(count + 1)} className="px-3 py-1 bg-blue-500 text-white rounded-md mt-2">
              Increment
            </button>
          </div>
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">useEffect</h3>
          <CodeBlock
            code={`useEffect(() => {
  // マウント時や依存配列の値が変更された時に実行
  document.title = \`Count: \${count}\`;
  
  // クリーンアップ関数（アンマウント時や次の実行前に呼ばれる）
  return () => {
    document.title = "React App";
  };
}, [count]); // 依存配列`}
          />
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">useRef</h3>
          <CodeBlock
            code={`const inputRef = useRef(null);

// DOM要素にアクセス
const focusInput = () => {
  inputRef.current.focus();
};`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <input ref={inputRef} type="text" className="border p-1 rounded-md" placeholder="Focus me" />
            <button
              onClick={() => inputRef.current?.focus()}
              className="px-3 py-1 bg-blue-500 text-white rounded-md ml-2"
            >
              Focus
            </button>
          </div>
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">useCallback</h3>
          <CodeBlock
            code={`// 依存配列が変更されない限りメモ化された関数を返す
const handleClick = useCallback(() => {
  setCount(prevCount => prevCount + 1);
}, []); // 空の依存配列 = 再レンダリング時に関数を再作成しない`}
          />
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">useMemo</h3>
          <CodeBlock
            code={`// 依存配列が変更されない限りメモ化された値を返す
const doubledCount = useMemo(() => {
  return count * 2; // 計算コストの高い処理
}, [count]);`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <p>Count: {count}</p>
            <p>Doubled: {doubledCount}</p>
          </div>
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">useReducer</h3>
          <CodeBlock
            code={`const [state, dispatch] = useReducer(
  (state, action) => {
    switch (action.type) {
      case "increment": return { value: state.value + 1 };
      case "decrement": return { value: state.value - 1 };
      default: return state;
    }
  },
  { value: 0 } // 初期状態
);`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <p>Reducer Value: {state.value}</p>
            <div className="flex gap-2 mt-2">
              <button
                onClick={() => dispatch({ type: "decrement" })}
                className="px-3 py-1 bg-red-500 text-white rounded-md"
              >
                -
              </button>
              <button
                onClick={() => dispatch({ type: "increment" })}
                className="px-3 py-1 bg-green-500 text-white rounded-md"
              >
                +
              </button>
            </div>
          </div>
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">useId (React 18+)</h3>
          <CodeBlock
            code={`// アクセシビリティのための安定したユニークID
const id = useId();

// 使用例
<label htmlFor={id}>Name</label>
<input id={id} />`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <label htmlFor={id} className="block mb-1">
              Name
            </label>
            <input id={id} type="text" className="border p-1 rounded-md" placeholder="Enter name" />
          </div>
        </div>
      </div>
    </div>
  )
}

// ============================================================
// 3. イベント処理
// ============================================================

function EventHandlingDemo() {
  const [message, setMessage] = useState("")

  const handleClick = () => {
    setMessage("Button clicked!")
  }

  const handleChange = (e) => {
    setMessage(e.target.value)
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    setMessage("Form submitted!")
  }

  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <h3 className="text-lg font-medium mb-2">基本的なイベント処理</h3>
          <CodeBlock
            code={`// クリックイベント
const handleClick = () => {
  setMessage("Button clicked!");
};

<button onClick={handleClick}>Click me</button>

// インラインで記述
<button onClick={() => setMessage("Clicked!")}>
  Click me
</button>`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <button onClick={handleClick} className="px-3 py-1 bg-blue-500 text-white rounded-md">
              Click me
            </button>
            <p className="mt-2">{message}</p>
          </div>
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">フォームイベント</h3>
          <CodeBlock
            code={`// 入力変更イベント
const handleChange = (e) => {
  setMessage(e.target.value);
};

// フォーム送信イベント
const handleSubmit = (e) => {
  e.preventDefault(); // デフォルトの送信動作を防止
  setMessage("Form submitted!");
};

<form onSubmit={handleSubmit}>
  <input type="text" onChange={handleChange} />
  <button type="submit">Submit</button>
</form>`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <form onSubmit={handleSubmit}>
              <input
                type="text"
                onChange={handleChange}
                className="border p-1 rounded-md"
                placeholder="Type something"
              />
              <button type="submit" className="px-3 py-1 bg-blue-500 text-white rounded-md ml-2">
                Submit
              </button>
            </form>
          </div>
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">イベントとパラメータ</h3>
          <CodeBlock
            code={`// パラメータを渡すイベントハンドラ
const handleItemClick = (id) => {
  console.log(\`Item \${id} clicked\`);
};

<button onClick={() => handleItemClick(1)}>
  Item 1
</button>`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <div className="flex gap-2">
              {[1, 2, 3].map((id) => (
                <button
                  key={id}
                  onClick={() => console.log(`Item ${id} clicked`)}
                  className="px-3 py-1 bg-gray-200 rounded-md"
                >
                  Item {id}
                </button>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

// ============================================================
// 4. 条件付きレンダリングとリスト
// ============================================================

function ConditionalAndListDemo() {
  const [isLoggedIn, setIsLoggedIn] = useState(false)
  const [items, setItems] = useState([
    { id: 1, name: "Item 1" },
    { id: 2, name: "Item 2" },
    { id: 3, name: "Item 3" },
  ])

  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <h3 className="text-lg font-medium mb-2">条件付きレンダリング</h3>
          <CodeBlock
            code={`// if文による条件付きレンダリング
if (isLoggedIn) {
  return <UserGreeting />;
} else {
  return <GuestGreeting />;
}

// 三項演算子
{isLoggedIn ? <UserGreeting /> : <GuestGreeting />}

// 論理演算子 &&
{isLoggedIn && <UserGreeting />}`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <div className="mb-2">{isLoggedIn ? <p>Welcome back, User!</p> : <p>Please log in</p>}</div>
            <button onClick={() => setIsLoggedIn(!isLoggedIn)} className="px-3 py-1 bg-blue-500 text-white rounded-md">
              {isLoggedIn ? "Log out" : "Log in"}
            </button>
          </div>
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">リストのレンダリング</h3>
          <CodeBlock
            code={`// map()を使用したリストのレンダリング
const items = [
  { id: 1, name: "Item 1" },
  { id: 2, name: "Item 2" },
  { id: 3, name: "Item 3" },
];

<ul>
  {items.map(item => (
    <li key={item.id}>{item.name}</li>
  ))}
</ul>`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <ul className="list-disc pl-5">
              {items.map((item) => (
                <li key={item.id}>{item.name}</li>
              ))}
            </ul>
            <button
              onClick={() => {
                const newId = items.length + 1
                setItems([...items, { id: newId, name: `Item ${newId}` }])
              }}
              className="px-3 py-1 bg-green-500 text-white rounded-md mt-2"
            >
              Add Item
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}

// ============================================================
// 5. フォーム
// ============================================================

function FormsDemo() {
  // 制御されたコンポーネント
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    message: "",
  })

  // 非制御コンポーネント用のref
  const fileInputRef = useRef(null)

  const handleChange = (e) => {
    const { name, value } = e.target
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }))
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    console.log("Form submitted:", formData)
    // ファイル入力の値を取得（非制御コンポーネント）
    if (fileInputRef.current?.files) {
      console.log("Selected file:", fileInputRef.current.files[0]?.name)
    }
  }

  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <h3 className="text-lg font-medium mb-2">制御されたコンポーネント</h3>
          <CodeBlock
            code={`// 状態でフォーム値を管理
const [formData, setFormData] = useState({
  name: "",
  email: "",
  message: ""
});

const handleChange = (e) => {
  const { name, value } = e.target;
  setFormData(prev => ({
    ...prev,
    [name]: value
  }));
};

<input
  type="text"
  name="name"
  value={formData.name}
  onChange={handleChange}
/>`}
          />
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">非制御コンポーネント</h3>
          <CodeBlock
            code={`// refを使用してDOM要素に直接アクセス
const fileInputRef = useRef(null);

// 送信時に値を取得
const handleSubmit = (e) => {
  e.preventDefault();
  console.log("Selected file:", fileInputRef.current.files[0]?.name);
};

<input
  type="file"
  ref={fileInputRef}
/>`}
          />
        </div>
      </div>

      <div className="mt-4 bg-white p-4 border rounded-md">
        <h3 className="text-lg font-medium mb-2">フォームの例</h3>
        <form onSubmit={handleSubmit} className="space-y-3">
          <div>
            <label htmlFor="name" className="block mb-1">
              Name
            </label>
            <input
              type="text"
              id="name"
              name="name"
              value={formData.name}
              onChange={handleChange}
              className="w-full border p-2 rounded-md"
            />
          </div>

          <div>
            <label htmlFor="email" className="block mb-1">
              Email
            </label>
            <input
              type="email"
              id="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              className="w-full border p-2 rounded-md"
            />
          </div>

          <div>
            <label htmlFor="message" className="block mb-1">
              Message
            </label>
            <textarea
              id="message"
              name="message"
              value={formData.message}
              onChange={handleChange}
              className="w-full border p-2 rounded-md"
              rows={3}
            ></textarea>
          </div>

          <div>
            <label htmlFor="file" className="block mb-1">
              File (非制御)
            </label>
            <input type="file" id="file" ref={fileInputRef} className="w-full border p-2 rounded-md" />
          </div>

          <button type="submit" className="px-4 py-2 bg-blue-500 text-white rounded-md">
            Submit
          </button>
        </form>

        <div className="mt-4">
          <h4 className="font-medium">フォームデータ:</h4>
          <pre className="bg-gray-100 p-2 rounded-md mt-1">{JSON.stringify(formData, null, 2)}</pre>
        </div>
      </div>
    </div>
  )
}

// ============================================================
// 6. コンテキスト API
// ============================================================

// テーマコンテキストの作成
const ThemeContext = createContext({
  theme: "light",
  toggleTheme: () => {},
})

function ContextAPIDemo() {
  const [theme, setTheme] = useState("light")

  const toggleTheme = () => {
    setTheme((prevTheme) => (prevTheme === "light" ? "dark" : "light"))
  }

  const themeContextValue = {
    theme,
    toggleTheme,
  }

  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <h3 className="text-lg font-medium mb-2">コンテキストの作成と提供</h3>
          <CodeBlock
            code={`// コンテキストの作成
const ThemeContext = createContext({
  theme: 'light',
  toggleTheme: () => {}
});

// コンテキストプロバイダー
function App() {
  const [theme, setTheme] = useState('light');
  
  const toggleTheme = () => {
    setTheme(prevTheme => 
      prevTheme === 'light' ? 'dark' : 'light'
    );
  };

  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      <ThemedComponent />
    </ThemeContext.Provider>
  );
}`}
          />
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">コンテキストの使用</h3>
          <CodeBlock
            code={`// useContext フックを使用
function ThemedComponent() {
  const { theme, toggleTheme } = useContext(ThemeContext);
  
  return (
    <div className={theme === 'dark' ? 'bg-dark' : 'bg-light'}>
      <p>Current theme: {theme}</p>
      <button onClick={toggleTheme}>Toggle Theme</button>
    </div>
  );
}`}
          />
        </div>
      </div>

      <div className="mt-4">
        <h3 className="text-lg font-medium mb-2">コンテキストの例</h3>
        <ThemeContext.Provider value={themeContextValue}>
          <ThemedComponent />
        </ThemeContext.Provider>
      </div>
    </div>
  )
}

function ThemedComponent() {
  const { theme, toggleTheme } = useContext(ThemeContext)

  return (
    <div className={`p-4 rounded-md ${theme === "dark" ? "bg-gray-800 text-white" : "bg-gray-100 text-gray-800"}`}>
      <p>Current theme: {theme}</p>
      <button
        onClick={toggleTheme}
        className={`mt-2 px-3 py-1 rounded-md ${
          theme === "dark" ? "bg-gray-600 text-white" : "bg-gray-300 text-gray-800"
        }`}
      >
        Toggle Theme
      </button>
    </div>
  )
}

// ============================================================
// 7. エラーバウンダリ
// ============================================================

class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props)
    this.state = { hasError: false }
  }

  static getDerivedStateFromError() {
    return { hasError: true }
  }

  componentDidCatch(error, errorInfo) {
    console.error("Error caught by ErrorBoundary:", error, errorInfo)
  }

  render() {
    if (this.state.hasError) {
      return this.props.fallback
    }

    return this.props.children
  }
}

function ErrorBoundaryDemo() {
  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <h3 className="text-lg font-medium mb-2">エラーバウンダリの定義</h3>
          <CodeBlock
            code={`// エラーバウンダリはクラスコンポーネントで定義する必要がある
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error) {
    // エラー発生時に状態を更新
    return { hasError: true };
  }

  componentDidCatch(error, errorInfo) {
    // エラーログの記録など
    console.error("Error caught:", error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      // フォールバックUIをレンダリング
      return this.props.fallback;
    }

    return this.props.children;
  }
}`}
          />
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">エラーバウンダリの使用</h3>
          <CodeBlock
            code={`// コンポーネントをエラーバウンダリでラップ
<ErrorBoundary fallback={<p>Something went wrong</p>}>
  <ComponentThatMightError />
</ErrorBoundary>`}
          />
        </div>
      </div>

      <div className="mt-4">
        <h3 className="text-lg font-medium mb-2">エラーバウンダリの例</h3>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <ErrorBoundary
            fallback={
              <div className="p-4 bg-red-100 text-red-800 rounded-md">Something went wrong in this component.</div>
            }
          >
            <BuggyComponent />
          </ErrorBoundary>

          <div className="p-4 bg-white border rounded-md">
            <p>This component works fine.</p>
          </div>
        </div>
      </div>
    </div>
  )
}

function BuggyComponent() {
  const [shouldError, setShouldError] = useState(false)

  if (shouldError) {
    throw new Error("Simulated error")
  }

  return (
    <div className="p-4 bg-white border rounded-md">
      <p>Click the button to simulate an error:</p>
      <button onClick={() => setShouldError(true)} className="mt-2 px-3 py-1 bg-red-500 text-white rounded-md">
        Trigger Error
      </button>
    </div>
  )
}

// ============================================================
// 8. Suspense と遅延ローディング
// ============================================================

// 遅延ロードされるコンポーネント
const LazyComponent = lazy(() => {
  return new Promise((resolve) => {
    // 遅延ロードをシミュレート
    setTimeout(() => {
      resolve({
        default: () => (
          <div className="p-4 bg-green-100 rounded-md">
            <h3 className="font-medium">Lazy Loaded Component</h3>
            <p>This component was loaded lazily!</p>
          </div>
        ),
      })
    }, 1500)
  })
})

function SuspenseAndLazyDemo() {
  const [showLazy, setShowLazy] = useState(false)

  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <h3 className="text-lg font-medium mb-2">コンポーネントの遅延ロード</h3>
          <CodeBlock
            code={`// コンポーネントの遅延ロード
const LazyComponent = lazy(() => import('./LazyComponent'));

// Suspenseでラップして使用
function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <LazyComponent />
    </Suspense>
  );
}`}
          />
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">データの遅延ロード</h3>
          <CodeBlock
            code={`// React 18+ の use フックでデータを遅延ロード
function DataComponent() {
  const data = use(fetchData());
  return <div>{data.name}</div>;
}

// 使用例
<Suspense fallback={<div>Loading data...</div>}>
  <DataComponent />
</Suspense>`}
          />
        </div>
      </div>

      <div className="mt-4">
        <h3 className="text-lg font-medium mb-2">Suspense の例</h3>
        <button onClick={() => setShowLazy(!showLazy)} className="px-3 py-1 bg-blue-500 text-white rounded-md mb-4">
          {showLazy ? "Hide" : "Show"} Lazy Component
        </button>

        {showLazy && (
          <Suspense fallback={<div className="p-4 bg-gray-100 rounded-md animate-pulse">Loading component...</div>}>
            <LazyComponent />
          </Suspense>
        )}
      </div>
    </div>
  )
}

// ============================================================
// 9. React 19 の新機能
// ============================================================

function React19FeaturesDemo() {
  // useOptimistic の例
  const [todos, setTodos] = useState([
    { id: 1, text: "Learn React 19", completed: false },
    { id: 2, text: "Build an app", completed: false },
  ])

  const [optimisticTodos, addOptimisticTodo] = useOptimistic(todos, (state, newTodo) => [...state, newTodo])

  const addTodo = () => {
    const newTodo = {
      id: Date.now(),
      text: "New optimistic todo",
      completed: false,
    }

    // 楽観的に更新
    addOptimisticTodo(newTodo)

    // 実際の更新をシミュレート（通常はAPIリクエスト）
    setTimeout(() => {
      setTodos((prev) => [...prev, newTodo])
    }, 1000)
  }

  // useTransition の例
  const [isPending, startTransition] = useTransition()
  const [count, setCount] = useState(0)

  const handleTransition = () => {
    startTransition(() => {
      setCount((c) => c + 1)
    })
  }

  // useDeferredValue の例
  const [text, setText] = useState("")
  const deferredText = useDeferredValue(text)

  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <h3 className="text-lg font-medium mb-2">useOptimistic</h3>
          <CodeBlock
            code={`// 楽観的UI更新のための新しいフック
const [optimisticTodos, addOptimisticTodo] = useOptimistic(
  todos,
  (state, newTodo) => [...state, newTodo]
);

const addTodo = () => {
  const newTodo = { id: Date.now(), text: "New todo" };
  
  // 楽観的に更新
  addOptimisticTodo(newTodo);
  
  // 実際の更新（APIリクエストなど）
  saveTodoToServer(newTodo).then(() => {
    setTodos(prev => [...prev, newTodo]);
  });
};`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <h4 className="font-medium mb-2">Todos:</h4>
            <ul className="list-disc pl-5">
              {optimisticTodos.map((todo) => (
                <li key={todo.id} className="mb-1">
                  {todo.text}
                  {todo.id > todos.length && <span className="ml-2 text-xs text-blue-500">(optimistic)</span>}
                </li>
              ))}
            </ul>
            <button onClick={addTodo} className="mt-2 px-3 py-1 bg-blue-500 text-white rounded-md">
              Add Optimistic Todo
            </button>
          </div>
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">useFormStatus と useFormState</h3>
          <CodeBlock
            code={`// フォームのステータスを取得
function SubmitButton() {
  const { pending } = useFormStatus();
  return (
    <button disabled={pending}>
      {pending ? 'Submitting...' : 'Submit'}
    </button>
  );
}

// フォームの状態を管理
function Form() {
  const [state, formAction] = useFormState(serverAction, initialState);
  
  return (
    <form action={formAction}>
      {/* フォーム要素 */}
      <SubmitButton />
    </form>
  );
}`}
          />
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">useTransition と useDeferredValue</h3>
          <CodeBlock
            code={`// 非ブロッキング更新のためのuseTransition
const [isPending, startTransition] = useTransition();

const handleClick = () => {
  startTransition(() => {
    // 優先度の低い状態更新
    setCount(c => c + 1);
  });
};

// 値の遅延更新
const [text, setText] = useState("");
const deferredText = useDeferredValue(text);

// deferredTextは低優先度で更新される`}
          />
          <div className="mt-2 bg-white p-3 border rounded-md">
            <div className="mb-3">
              <p>Count: {count}</p>
              <button onClick={handleTransition} className="px-3 py-1 bg-blue-500 text-white rounded-md">
                {isPending ? "Updating..." : "Increment with Transition"}
              </button>
            </div>

            <div>
              <input
                type="text"
                value={text}
                onChange={(e) => setText(e.target.value)}
                className="border p-1 rounded-md"
                placeholder="Type to see deferred value"
              />
              <p className="mt-1">
                Deferred value: <strong>{deferredText}</strong>
              </p>
            </div>
          </div>
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">useEffectEvent</h3>
          <CodeBlock
            code={`// 依存関係のない安定したイベントハンドラ
const onVisit = useEffectEvent((url) => {
  // このコードは依存配列に含まれない
  logVisit(url, userId);
});

// 使用例
useEffect(() => {
  onVisit(currentUrl);
}, [currentUrl]); // onVisitは依存配列に含まれない`}
          />
        </div>
      </div>
    </div>
  )
}

// ============================================================
// 10. サーバーコンポーネント
// ============================================================

function ServerComponentsDemo() {
  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <h3 className="text-lg font-medium mb-2">サーバーコンポーネント</h3>
          <CodeBlock
            code={`// サーバーコンポーネント (RSC)
// app/page.js (Next.js App Router)
import db from '@/lib/db';

// デフォルトでサーバーコンポーネント
export default async function Page() {
  // サーバー上で直接データを取得
  const products = await db.products.findMany();
  
  return (
    <div>
      <h1>Products</h1>
      <ProductList products={products} />
    </div>
  );
}`}
          />
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">クライアントコンポーネント</h3>
          <CodeBlock
            code={`// クライアントコンポーネント
'use client'; // クライアントコンポーネントを明示

import { useState } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>
        Increment
      </button>
    </div>
  );
}`}
          />
        </div>
      </div>

      <div className="mt-4">
        <h3 className="text-lg font-medium mb-2">サーバーコンポーネントの利点</h3>
        <ul className="list-disc pl-5 space-y-2">
          <li>
            <strong>バンドルサイズの削減</strong> - サーバーコンポーネントのコードはクライアントに送信されない
          </li>
          <li>
            <strong>データベースへの直接アクセス</strong> - クライアントを経由せずにデータを取得できる
          </li>
          <li>
            <strong>APIレイヤーの削減</strong> - バックエンドAPIを作成する必要がない
          </li>
          <li>
            <strong>自動コード分割</strong> - クライアントコンポーネントは自動的に分割される
          </li>
          <li>
            <strong>プライベートコードの保護</strong> - 機密性の高いロジックをクライアントに公開しない
          </li>
        </ul>
      </div>
    </div>
  )
}

// ============================================================
// 11. アクションと use フック
// ============================================================

function ActionsAndUseHookDemo() {
  // サーバーアクションをシミュレート
  async function simulateServerAction(prevState, formData) {
    "use server" // 実際のサーバーアクションではこの指示子が必要

    // フォームデータの処理をシミュレート
    const name = formData.get("name")

    // 処理を遅延させてローディング状態をシミュレート
    await new Promise((resolve) => setTimeout(resolve, 1000))

    // エラーチェック
    if (!name || name.trim() === "") {
      return { error: "Name is required", success: false }
    }

    // 成功レスポンス
    return {
      message: `Hello, ${name}!`,
      timestamp: new Date().toISOString(),
      success: true,
    }
  }
  
  // クライアント側でのフォーム状態管理
  //const [state, formAction] = useFormState(simulateServerAction, {
  const [state, formAction] = useActionState(simulateServerAction, {
    message: "",
    error: "",
    success: false,
  })

  // use フックの例（通常はサーバーコンポーネントで使用）
  const fetchData = async () => {
    await new Promise((resolve) => setTimeout(resolve, 1000))
    return { data: "This is data from an async source" }
  }

  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <h3 className="text-lg font-medium mb-2">サーバーアクション</h3>
          <CodeBlock
            code={`// サーバーアクション
async function submitForm(formData) {
  'use server'; // サーバーアクションを示す指示子
  
  const name = formData.get('name');
  const email = formData.get('email');
  
  // サーバー側でのデータ処理
  const result = await db.users.create({
    data: { name, email }
  });
  
  return { success: true, userId: result.id };
}

// クライアントコンポーネントでの使用
'use client';

function Form() {
  const [state, formAction] = useFormState(submitForm, {
    success: false,
    userId: null
  });
  
  return (
    <form action={formAction}>
      <input name="name" />
      <input name="email" />
      <SubmitButton />
      {state.success && <p>User created: {state.userId}</p>}
    </form>
  );
}`}
          />
        </div>

        <div>
          <h3 className="text-lg font-medium mb-2">use フック</h3>
          <CodeBlock
            code={`// use フックでプロミスを消費
function DataComponent() {
  // プロミスから直接データを取得
  const data = use(fetchData());
  
  return <div>{data.message}</div>;
}

// Suspenseと組み合わせて使用
<Suspense fallback={<Loading />}>
  <DataComponent />
</Suspense>`}
          />
        </div>
      </div>

      <div className="mt-4 bg-white p-4 border rounded-md">
        <h3 className="text-lg font-medium mb-2">サーバーアクションの例</h3>
       
        <form action={formAction} className="space-y-3"> 
          <div>
            <label htmlFor="name" className="block mb-1">
              Name
            </label>
            <input type="text" id="name" name="name" className="w-full border p-2 rounded-md" />
          </div>

          <FormSubmitButton />

          {state.error && <p className="text-red-500">{state.error}</p>}

          {state.success && (
            <div className="p-3 bg-green-100 text-green-800 rounded-md">
              <p>{state.message}</p>
              <p className="text-xs mt-1">Submitted at: {state.timestamp}</p>
            </div>
          )}
        </form>
        
        
      </div>
    </div>
  )
}

// フォーム送信ボタン（useFormStatus を使用）
function FormSubmitButton() {
  //const { pending } = useFormStatus()
  const { pending } = useActionState()
  

  return (
    <button
      type="submit"
      disabled={pending}
      className={`px-4 py-2 rounded-md ${
        pending ? "bg-gray-400 cursor-not-allowed" : "bg-blue-500 hover:bg-blue-600"
      } text-white`}
    >
      {pending ? "Submitting..." : "Submit"}
    </button>
  )
}
