import Vue from 'vue'
import HelloVue from '../components/HelloVue.vue'

document.addEventListener('DOMContentLoaded', () => {
  const vueContainer = document.querySelector('#vue-container')
  if (vueContainer) {
    new Vue({
      render: h => h(HelloVue)
    }).$mount('#vue-container')
  }
})
