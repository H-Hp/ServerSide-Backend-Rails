import React from 'react';

class Footer extends React.Component {
  render() {
    return (
      <div className='footer' style={this.props.titleStyle}>
        <div className='footer-inner'>
          <ul className='footer-list'>
            <li>会社概要</li>
            <li>採用</li>
            <li>お問い合わせ</li>
          </ul>
        </div>
      </div>
    );
  }
}

export default Footer;