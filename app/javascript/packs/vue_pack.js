//import Vue from "vue";
//import * as Vue from 'vue'  // Vue 3 を正しくインポート
import { createApp } from 'vue'
//import HelloVue from '../components/vue/HelloVue.vue'
//import HelloVue from "../components/HelloVue.vue";
//import HelloVue from "../components/vue/HelloVue.vue";
//import VueCheatSheet from "../components/vue/VueCheatSheet.vue";
import VueCheatSheet from "../components/vue/VueCheatSheet.vue";



document.addEventListener("DOMContentLoaded", () => {
  /*const vueContainer = document.querySelector("#vue-container");
  if (vueContainer) {
    new Vue({
      //render: (h) => h(HelloVue),
      render: (h) => h(VueCheatSheet),
    }).$mount("#vue-container");
  }
  */

  /*
  //const vueElement = document.getElementById('vue-container')
  const vueElement = document.querySelector("#vue-container");
  
  if (vueElement) {
    const app = Vue({
      components: {
        VueCheatSheet
      },
      template: '<VueCheatSheet />'
    })
    
    app.mount('#vue-container')
    
    console.log('Vue Cheat Sheet component mounted successfully')
  } else {
    console.warn('Vue mount element not found')
  }
  */

  /*
  const vueElement = document.getElementById('vue-container')
  
  if (vueElement) {
    const app = Vue.createApp({
      components: {
        VueCheatSheet: () => import('../components/vue/HelloVue.vue')
        //VueCheatSheet: () => import('../components/vue/VueCheatSheet.vue')
        //VueCheatSheet: () => import('../components/vue/VueCheatSheet2.vue')
      },
      template: '<VueCheatSheet />'
    })
    
    app.mount('#vue-container')
    console.log('Vue Cheat Sheet component mounted successfully')
  } else {
    console.warn('Vue mount element not found')
  }
  */


  const element = document.getElementById('vue-container')
  
  if (element) {
    // Vue 3 の方法でアプリケーションを作成
    const app = createApp(VueCheatSheet)
    
    // 必要に応じてグローバルプロパティやプラグインを追加
    // app.config.globalProperties.$axios = axios
    // app.use(somePlugin)
    
    // アプリケーションをマウント
    app.mount('#vue-container')
    
    console.log('Vue application mounted successfully')
  } else {
    console.warn('Vue mount element not found')
  }
  
});
