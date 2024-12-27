// app/javascript/packs/react_pack.jsx
import React from 'react'
import ReactDOM from 'react-dom'
import { createRoot } from 'react-dom/client'
import HelloReact from '../components/HelloReact'

document.addEventListener('DOMContentLoaded', () => {
  const reactContainer = document.querySelector('#react-container')
  if (reactContainer) {
    const root = createRoot(reactContainer)
    root.render(<HelloReact />)
  }
  /*React 18での ReactDOM.renderが廃止された
  ReactDOM.render(
    <HelloReact />,
    reactContainer
  )
  */
})