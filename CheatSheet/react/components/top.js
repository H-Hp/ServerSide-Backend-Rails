import React from 'react';

class top extends React.Component {
  render() {
    return (
      <div className='Top' style={this.props.titleStyle}>
        <div className='header-logo'>
          <h1>トップページ</h1>
        </div>
      </div>
    );
  }
}

export default top;