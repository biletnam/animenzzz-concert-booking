
const propTypes = {
  'price': React.PropTypes.number
};

class SeatPreview extends React.Component {
  render () {
    const data = {
      'type': 'seat',
      'classname': `seat-p${this.props['price']} seat-preview`
    };
    return <Seat data={data} />;
  }
}

SeatPreview.propTypes = propTypes;
