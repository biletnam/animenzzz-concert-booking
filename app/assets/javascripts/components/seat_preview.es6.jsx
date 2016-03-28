
const propTypes = {
  'price': React.PropTypes.number,
  'className': React.PropTypes.string
};

class SeatPreview extends React.Component {
  render () {
    var classname = 'seat-preview'
    if (this.props['className']) {
      classname = this.props['className'];
    } else {
      classname = `seat-p${this.props['price']}`;
    }
    classname = classNames(classname, 'seat-preview');
    
    const data = {
      'type': 'seat',
      classname
    };
    return <Seat data={data} />;
  }
}

SeatPreview.propTypes = propTypes;
