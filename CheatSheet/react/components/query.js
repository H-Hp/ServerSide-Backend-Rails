import React from 'react';

class query extends React.Component {
  render() {
    return (
      <div className='Query' style={this.props.titleStyle}>
        <div className='header-logo'>
          <h1>お問合せ</h1>
          <input type="text" />
        </div>
      </div>
    );
  }
}

export default query;