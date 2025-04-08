// app/javascript/packs/react_pack.jsx
import React from "react";
//import ReactDOM from "react-dom";
import { createRoot } from "react-dom/client";
//import HelloReact from "../components/react/HelloReact";
import ReactCheatSheet from "../components/react/ReactCheatSheet";
//import ReactCheatSheet from "../components/react/ReactCheatSheet2";

document.addEventListener("DOMContentLoaded", () => {
  const reactContainer = document.querySelector("#react-container");
  if (reactContainer) {
    const root = createRoot(reactContainer);
    //root.render(<HelloReact />);
    root.render(<ReactCheatSheet />);
  }
  /*React 18での ReactDOM.renderが廃止された
  ReactDOM.render(
    <HelloReact />,
    reactContainer
  )
  */
});
