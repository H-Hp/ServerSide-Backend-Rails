import consumer from "../channels/consumer"

const chatChannel = consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const messages = document.getElementById('messages')
    messages.innerHTML += `
${data.message}

`
  },

  speak(message) {
    this.perform('speak', { message: message })
  }
})

document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('send_message').addEventListener('click', () => {
    const input = document.getElementById('message_input')
    chatChannel.speak(input.value)
    input.value = ''
  })
})