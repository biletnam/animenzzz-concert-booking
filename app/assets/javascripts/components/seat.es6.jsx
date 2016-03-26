
const propTypes = {
  data: React.PropTypes.object,
  coordX: React.PropTypes.number,
  coordY: React.PropTypes.number,
  coordFloor: React.PropTypes.number,
  callbackChoose: React.PropTypes.func,
  disabled: React.PropTypes.bool
};

class Seat extends React.Component {
  
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }
  
//   shouldComponentUpdate(nextProps, nextState) {
//       return true;
//   }

  handleClick() {
    if (this.props['callbackChoose']) {
      this.props['callbackChoose'](this.props['coordFloor'],
        this.props['coordX'], this.props['coordY']);
    }
  }
  
  render () {
    switch (this.props['data']['type']) {
      case 'empty':
        return (<span className="seat-placeholder" />);
      case 'stage':
        return (<span className="seat-placeholder-stage" />);
      case 'seat':
        return (
            <span className={classNames('seat', this.props['data']['classname'])}>
                <input type="checkbox"
                disabled={this.props['disabled']}
                checked={!!(this.props['data']['chosen'])}
                />
                <label className="seat-label" onClick={this.handleClick} />
            </span>
        );
      default:
        console.error('Data Type does not match!', this.props);
        return (<span></span>);
    }
    
  }
}

Seat.propTypes = propTypes;
