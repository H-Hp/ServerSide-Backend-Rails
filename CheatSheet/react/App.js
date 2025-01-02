import logo from './logo.svg';
import './App.css';
import { BrowserRouter, Routes, Route} from "react-router-dom";

import Header from './components/header'
import Footer from './components/footer'
import Top from './components/top'
import Query from './components/query'

function App() {
  return (
    <div className="App">
      <Header titleStyle={{backgroundColor: "pink"}} title="リンゴ" />
      <a href="/">Top</a><br/>
      <a href="/Query">お問合せ</a><br/>

      <p className="text-white bg-black w-20">Hello world!</p>

    <BrowserRouter>
    <Routes>
      <Route path={`/`} element={<Top title="Top" />} />
      <Route path={`/Query/`} element={<Query />} />
      </Routes>
  </BrowserRouter>

  <Footer titleStyle={{backgroundColor: "blue"}}  />
    </div>
  );
}

export default App;
