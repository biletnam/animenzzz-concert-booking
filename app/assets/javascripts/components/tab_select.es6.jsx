
class TabSelectItem extends React.Component {
  
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }
  
  handleClick() {
    if (this.props['onClick']) {
      this.props['onClick'](this.props['index']);
    }
  }
  
  render() {
    return (
      <li>
        <a className={this.props['className']} href="#" onClick={this.handleClick}>
          {this.props['title']}
        </a>
      </li>
    );
  }
}

TabSelectItem.propTypes = {
  'index': React.PropTypes.number,
  'onClick': React.PropTypes.func,
  'title': React.PropTypes.string
};

const propTypes = {
  'tabs': React.PropTypes.arrayOf(React.PropTypes.string),
  'activeTab': React.PropTypes.number,
  'onChange': React.PropTypes.func,
  'className': React.PropTypes.string
};

class TabSelect extends React.Component {
  
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }
  
  handleClick(index) {
    if (this.props['onChange']) {
      this.props['onChange'](index);
    }
  }
  
  render() {

    var className = classNames("rx-tabs clearfix", this.props['className']);
    return (
      <ul className={className}>
        {this.props['tabs'].map((tab, index) =>
          <TabSelectItem
            key={index} index={index} title={tab}
            onClick={this.handleClick}
            className={classNames({ 'rx-tabs-active': this.props['activeTab'] == index })}
          />
        )}
      </ul>
    );
  }
}

TabSelect.propTypes = propTypes;
