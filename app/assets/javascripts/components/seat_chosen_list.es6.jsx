
const propTypes = {
  'data': React.PropTypes.arrayOf(React.PropTypes.arrayOf(React.PropTypes.arrayOf(React.PropTypes.object))),
  'chosen': React.PropTypes.arrayOf(React.PropTypes.arrayOf(React.PropTypes.number))
};

class SeatChosenList extends React.Component {
    
  constructor(props) {
    super(props);
  }
  
  render() {
    return (
      <ul className="rx-seatchosen-list">
        {this.props['chosen'].map((idx, i) => {
          const seat = this.props['data'][idx[0]][idx[2]][idx[1]];
          return <SeatChosenListItem key={i} data={seat} floorId={idx[0]} />;
        })}
      </ul>
    );
  }
}

SeatChosenList.propTypes = propTypes;
