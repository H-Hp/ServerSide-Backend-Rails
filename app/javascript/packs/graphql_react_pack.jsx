// app/javascript/packs/react_pack.jsx
import React from "react";
import { createRoot } from "react-dom/client";
//import {ApolloClient,InMemoryCache,ApolloProvider} from "@apollo/client";
import { ApolloClient, InMemoryCache, ApolloProvider, createHttpLink } from '@apollo/client'
//import HelloReact from "../components/HelloReact";
import Client_apollo_graphql from "../components/ClientApolloGraphql";

// ApolloClient()メソッドを用いてapollo-clientを初期化
//uri...apollo-clientがGraphQLの情報を受け取るところ。uriかlinkのどちらかが必須で、両方あった場合はlinkが優先される。
//cache...apollo-clientがクエリの実行結果をローカルに保存するために使用するもの。 
//@apollo/clientに同梱されているInMemoryCacheがおすすめ。
/*const client = new ApolloClient({
  uri: 'http://localhost:3000/graphql',
  cache: new InMemoryCache()
});
*/

// CSRFトークンを取得する関数
const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

// HTTPリンクの作成
const httpLink = createHttpLink({
  uri: '/graphql',
  credentials: 'same-origin',
  headers: {
    'X-CSRF-Token': csrfToken
  }
});

// クライアントの設定
const client = new ApolloClient({
  link: httpLink,
  cache: new InMemoryCache()
});
/*
export const App = () => {
    return (
        <ApolloProvider client={client} >
            <Client_apollo_graphql />
        </ApolloProvider>
    );
}*/

document.addEventListener("DOMContentLoaded", () => {
  const reactContainer = document.querySelector("#graphql-react-container");
  if (reactContainer) {
    //const root = createRoot(reactContainer);
    //root.render(<HelloReact />);
    const root = createRoot(reactContainer);
    root.render(
      <ApolloProvider client={client} >
          <Client_apollo_graphql />
      </ApolloProvider>
    );
  }
});
