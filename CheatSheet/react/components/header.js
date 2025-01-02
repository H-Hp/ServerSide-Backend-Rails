import React from 'react';

class Header extends React.Component {
  render() {
    return (
      <div className='header' style={this.props.titleStyle}>
        <div className='header-logo'>
          <h1>ヘッダー{this.props.title}</h1>
        </div>
      </div>
    );
  }
}

export default Header;