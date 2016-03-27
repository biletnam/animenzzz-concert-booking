
const propTypes = {
  'data': React.PropTypes.object,
  'floorId': React.PropTypes.number
};

class SeatChosenListItem extends React.Component {
  
  constructor(props) {
    super(props);
  }
    
  render() {
    
    const { floorId, data } = this.props;
    
    return (
      <li>
        <div>{floorId+1} 楼 {data['row']} 排 {data['num']} 号</div>
        <div>{data['price']} 元</div>
      </li>
    );
  }
}

SeatChosenListItem.propTypes = propTypes;
