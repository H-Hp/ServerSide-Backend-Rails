import React from 'react';
import { useQuery, gql } from "@apollo/client";

const GET_POST = gql`
  query {
    post (id: 1){
      id
      title
    }
  }
`;
/*
  query GetUsers {
    post (id: 1){
      id
      title
    }
  }
*/

export const ClientApolloGraphql = () => {
    const {loading, error, data} = useQuery(GET_POST); // 解説します
    
    if (loading) return 'ロード中....';
    if (error) return `Error ${error.message}`;
    console.log(data)


    return (
        <>
        {data.post.id}: {data.post.title}

        {/* //単一だからpostsは使えない
            {data.post.map(({id,title})=>(
              <div key={title}>
                <p>
                  {id}: {title}
                </p>
              </div>
            ))}
     
            {data.posts.map(post => (
                <div key={post.id}>
                    <h1>{post.title}</h1>
                </div>
            ))}
 */}

        </>
    )
};
export default ClientApolloGraphql;
