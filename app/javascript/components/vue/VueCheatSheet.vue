<template>
  <!-- 基本的なテンプレート構文 -->
  <div class="vue3-cheat-sheet">
    <h1>{{ title }}</h1>
    
    <!-- セクション 1: テキスト補間とディレクティブ -->
    <section class="section">
      <h2>テキスト補間とディレクティブ</h2>
      
      <div class="example">
        <h3>テキスト補間</h3>
        <p>{{ message }}</p>
        <p v-text="message"></p>
        <p v-html="htmlMessage"></p>
      </div>
      
      <div class="example">
        <h3>属性バインディング</h3>
        <img :src="imageUrl" :alt="imageAlt" />
        <a :[dynamicAttr]="linkUrl">動的属性</a>
        <div :class="{ active: isActive, 'text-danger': hasError }">クラスバインディング</div>
        <div :style="{ color: textColor, fontSize: fontSize + 'px' }">スタイルバインディング</div>
      </div>
      
      <div class="example">
        <h3>条件付きレンダリング</h3>
        <p v-if="showIf">v-if: 条件が true の場合に表示</p>
        <p v-else-if="showElseIf">v-else-if: 別の条件が true の場合に表示</p>
        <p v-else>v-else: 上記の条件がすべて false の場合に表示</p>
        <p v-show="showElement">v-show: CSS の display プロパティを使用して表示/非表示</p>
      </div>
      
      <div class="example">
        <h3>リストレンダリング</h3>
        <ul>
          <li v-for="(item, index) in items" :key="item.id">
            {{ index }}: {{ item.text }}
          </li>
        </ul>
        
        <div v-for="(value, key, index) in objectItems" :key="key">
          {{ index }}. {{ key }}: {{ value }}
        </div>
      </div>
    </section>
    
    <!-- セクション 2: イベント処理 -->
    <section class="section">
      <h2>イベント処理</h2>
      
      <div class="example">
        <h3>基本的なイベント</h3>
        <button @click="incrementCount">カウント: {{ count }}</button>
        <button @click="incrementCountBy(5)">+5</button>
        <button @click="resetCount">リセット</button>
      </div>
      
      <div class="example">
        <h3>イベント修飾子</h3>
        <button @click.stop="handleClick">Stop Propagation</button>
        <button @click.prevent="handleClick">Prevent Default</button>
        <button @click.once="handleClick">一度だけ実行</button>
        <input @keyup.enter="submitForm" placeholder="Enter キーで送信" />
      </div>
    </section>
    
    <!-- セクション 3: フォーム入力バインディング -->
    <section class="section">
      <h2>フォーム入力バインディング</h2>
      
      <div class="example">
        <h3>v-model の使用</h3>
        <input v-model="inputText" placeholder="テキスト入力" />
        <p>入力値: {{ inputText }}</p>
        
        <input v-model.lazy="lazyInput" placeholder="フォーカスを外すと更新" />
        <input v-model.number="numberInput" type="number" placeholder="数値として扱う" />
        <input v-model.trim="trimmedInput" placeholder="前後の空白を削除" />
        
        <select v-model="selectedOption">
          <option disabled value="">選択してください</option>
          <option v-for="option in options" :key="option.value" :value="option.value">
            {{ option.text }}
          </option>
        </select>
        <p>選択値: {{ selectedOption }}</p>
        
        <input type="checkbox" id="checkbox" v-model="checked" />
        <label for="checkbox">{{ checked ? 'チェック済み' : '未チェック' }}</label>
      </div>
    </section>
    
    <!-- セクション 4: コンポーネントの通信 -->
    <section class="section">
      <h2>コンポーネントの通信</h2>
      
      <div class="example">
        <h3>Props と Emits</h3>
        <child-component 
          :message="childMessage"
          :items="items"
          @update="handleChildUpdate"
        />
      </div>
      
      <div class="example">
        <h3>スロット</h3>
        <slot-example>
          <template #header>
            <h3>ヘッダースロット</h3>
          </template>
          <p>デフォルトスロットのコンテンツ</p>
          <template #footer>
            <p>フッタースロットのコンテンツ</p>
          </template>
        </slot-example>
      </div>
      
      <div class="example">
        <h3>Provide/Inject</h3>
        <p>親から子孫コンポーネントへのデータ提供: {{ providedValue }}</p>
      </div>
    </section>
    
    <!-- セクション 5: ライフサイクルフック -->
    <section class="section">
      <h2>ライフサイクルフック</h2>
      <div class="example">
        <p>現在のライフサイクル: {{ currentLifecycle }}</p>
        <button @click="triggerUpdate">更新をトリガー</button>
      </div>
    </section>
    
    <!-- セクション 6: テンプレート参照 -->
    <section class="section">
      <h2>テンプレート参照</h2>
      <div class="example">
        <input ref="inputRef" placeholder="テンプレート参照の例" />
        <button @click="focusInput">入力にフォーカス</button>
      </div>
    </section>
    
    <!-- セクション 7: Teleport と Suspense -->
    <section class="section">
      <h2>Teleport と Suspense</h2>
      
      <div class="example">
        <h3>Teleport</h3>
        <button @click="showModal = !showModal">モーダルを表示</button>
        
        <teleport to="body">
          <div v-if="showModal" class="modal">
            <div class="modal-content">
              <h3>モーダルタイトル</h3>
              <p>これは Teleport を使用して body に直接レンダリングされたモーダルです。</p>
              <button @click="showModal = false">閉じる</button>
            </div>
          </div>
        </teleport>
      </div>
      
      <div class="example">
        <h3>Suspense</h3>
        <suspense>
          <template #default>
            <async-component />
          </template>
          <template #fallback>
            <p>コンポーネントを読み込み中...</p>
          </template>
        </suspense>
      </div>
    </section>
  </div>
</template>

<script>
// 子コンポーネントの定義（通常は別ファイルですが、チートシートのために同じファイルに含めています）
const ChildComponent = {
  props: {
    message: String,
    items: Array
  },
  emits: ['update'],
  template: `
    <div class="child-component">
      <p>子コンポーネント: {{ message }}</p>
      <button @click="$emit('update', 'from child')">親に通知</button>
    </div>
  `
}

const SlotExample = {
  template: `
    <div class="slot-example">
      <header>
        <slot name="header">デフォルトヘッダー</slot>
      </header>
      <main>
        <slot>デフォルトコンテンツ</slot>
      </main>
      <footer>
        <slot name="footer">デフォルトフッター</slot>
      </footer>
    </div>
  `
}

// 非同期コンポーネント
const AsyncComponent = {
  template: `<div>非同期に読み込まれたコンポーネント</div>`,
  async setup() {
    // 非同期処理をシミュレート
    await new Promise(resolve => setTimeout(resolve, 1000))
    return {}
  }
}

// Options API を使用したコンポーネント定義
export default {
  name: 'Vue3CheatSheet',
  components: {
    ChildComponent,
    SlotExample,
    AsyncComponent
  },
  data() {
    return {
      // 基本データ
      title: 'Vue 3 チートシート',
      message: 'こんにちは Vue 3!',
      htmlMessage: '<span style="color: red">HTML コンテンツ</span>',
      
      // 属性バインディング
      imageUrl: 'https://vuejs.org/images/logo.png',
      imageAlt: 'Vue ロゴ',
      dynamicAttr: 'href',
      linkUrl: 'https://vuejs.org',
      isActive: true,
      hasError: false,
      textColor: 'blue',
      fontSize: 16,
      
      // 条件付きレンダリング
      showIf: true,
      showElseIf: false,
      showElement: true,
      
      // リストレンダリング
      items: [
        { id: 1, text: 'アイテム 1' },
        { id: 2, text: 'アイテム 2' },
        { id: 3, text: 'アイテム 3' }
      ],
      objectItems: {
        name: '太郎',
        age: 30,
        job: 'エンジニア'
      },
      
      // イベント処理
      count: 0,
      
      // フォーム
      inputText: '',
      lazyInput: '',
      numberInput: 0,
      trimmedInput: '',
      selectedOption: '',
      options: [
        { value: 'option1', text: 'オプション 1' },
        { value: 'option2', text: 'オプション 2' },
        { value: 'option3', text: 'オプション 3' }
      ],
      checked: false,
      
      // コンポーネント通信
      childMessage: '親からのメッセージ',
      providedValue: '提供された値',
      
      // ライフサイクル
      currentLifecycle: 'created',
      
      // Teleport
      showModal: false
    }
  },
  computed: {
    // 算出プロパティ
    doubleCount() {
      return this.count * 2
    },
    fullName() {
      return `${this.objectItems.name} (${this.objectItems.age}歳)`
    }
  },
  watch: {
    // ウォッチャー
    count(newValue, oldValue) {
      console.log(`カウントが ${oldValue} から ${newValue} に変更されました`)
    },
    inputText: {
      handler(newValue) {
        console.log(`入力テキストが変更されました: ${newValue}`)
      },
      immediate: true // コンポーネント作成時に即座に実行
    }
  },
  // ライフサイクルフック
  beforeCreate() {
    console.log('beforeCreate')
  },
  created() {
    console.log('created')
    // データの初期化、API呼び出しなど
  },
  beforeMount() {
    console.log('beforeMount')
  },
  mounted() {
    console.log('mounted')
    this.currentLifecycle = 'mounted'
    // DOM操作、子コンポーネントの参照など
  },
  beforeUpdate() {
    console.log('beforeUpdate')
  },
  updated() {
    console.log('updated')
    this.currentLifecycle = 'updated'
  },
  beforeUnmount() {
    console.log('beforeUnmount')
    // イベントリスナーのクリーンアップなど
  },
  unmounted() {
    console.log('unmounted')
  },
  // Provide/Inject
  provide() {
    return {
      providedData: this.providedValue,
      count: this.count
    }
  },
  methods: {
    // イベントハンドラー
    incrementCount() {
      this.count++
    },
    incrementCountBy(amount) {
      this.count += amount
    },
    resetCount() {
      this.count = 0
    },
    handleClick(event) {
      console.log('クリックされました', event)
    },
    submitForm() {
      console.log('フォームが送信されました')
    },
    
    // コンポーネント通信
    handleChildUpdate(value) {
      console.log('子コンポーネントからの更新:', value)
    },
    
    // ライフサイクル
    triggerUpdate() {
      this.message = `メッセージが更新されました: ${new Date().toLocaleTimeString()}`
    },
    
    // テンプレート参照
    focusInput() {
      this.$refs.inputRef.focus()
    }
  }
}
</script>

<!-- Composition API バージョン -->
<script setup>
/*
import { ref, reactive, computed, watch, onMounted, onUpdated, 
         onBeforeUnmount, provide, inject, nextTick } from 'vue'

// リアクティブな状態
const count = ref(0)
const message = ref('こんにちは Vue 3!')
const items = ref([
  { id: 1, text: 'アイテム 1' },
  { id: 2, text: 'アイテム 2' },
  { id: 3, text: 'アイテム 3' }
])

// リアクティブなオブジェクト
const user = reactive({
  name: '太郎',
  age: 30,
  job: 'エンジニア'
})

// 算出プロパティ
const doubleCount = computed(() => count.value * 2)
const fullName = computed(() => `${user.name} (${user.age}歳)`)

// ウォッチャー
watch(count, (newValue, oldValue) => {
  console.log(`カウントが ${oldValue} から ${newValue} に変更されました`)
})

// メソッド
function incrementCount() {
  count.value++
}

function resetCount() {
  count.value = 0
}

// ライフサイクルフック
onMounted(() => {
  console.log('コンポーネントがマウントされました')
})

onUpdated(() => {
  console.log('コンポーネントが更新されました')
})

onBeforeUnmount(() => {
  console.log('コンポーネントがアンマウントされます')
})

// Provide/Inject
provide('providedData', 'Composition API から提供されたデータ')
provide('count', count) // リアクティブな値を提供

// Props と Emits
const props = defineProps({
  title: String,
  initialCount: {
    type: Number,
    default: 0
  }
})

const emit = defineEmits(['update', 'submit'])

function emitUpdate() {
  emit('update', count.value)
}

// テンプレート参照
const inputRef = ref(null)
function focusInput() {
  inputRef.value.focus()
}

// 非同期処理
async function fetchData() {
  try {
    const response = await fetch('https://api.example.com/data')
    const data = await response.json()
    return data
  } catch (error) {
    console.error('データの取得に失敗しました:', error)
  }
}
*/
</script>

<style scoped>
.vue3-cheat-sheet {
  font-family: Arial, sans-serif;
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
  color: #2c3e50;
}

h1 {
  color: #42b883;
  text-align: center;
  margin-bottom: 30px;
}

.section {
  margin-bottom: 40px;
  border: 1px solid #eee;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

h2 {
  color: #35495e;
  border-bottom: 2px solid #42b883;
  padding-bottom: 10px;
  margin-bottom: 20px;
}

.example {
  margin-bottom: 20px;
  padding: 15px;
  background-color: #f8f8f8;
  border-radius: 6px;
}

h3 {
  color: #486491;
  margin-bottom: 10px;
}

button {
  background-color: #42b883;
  color: white;
  border: none;
  padding: 8px 16px;
  margin: 5px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

button:hover {
  background-color: #3aa776;
}

input, select {
  padding: 8px;
  margin: 5px;
  border: 1px solid #ddd;
  border-radius: 4px;
  width: 200px;
}

.child-component {
  border: 1px dashed #42b883;
  padding: 10px;
  margin: 10px 0;
  border-radius: 4px;
}

.slot-example {
  border: 1px solid #35495e;
  margin: 10px 0;
}

.slot-example header,
.slot-example main,
.slot-example footer {
  padding: 10px;
  margin: 5px;
  background-color: #f0f0f0;
}

/* モーダル用スタイル */
.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  max-width: 500px;
  width: 80%;
}
</style>