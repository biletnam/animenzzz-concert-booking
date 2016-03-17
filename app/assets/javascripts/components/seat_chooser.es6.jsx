
const propTypes = {
    target: React.PropTypes.string
};

class SeatChooser extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      'data': [ ],
      'chosen': [ ]
    };
    
    this.callbackChoose = this.callbackChoose.bind(this);
  }

  componentDidMount() {
    $.getJSON(`/halldata/${this.props['target']}.json`)
      .then((data) => {
        this.setState({ 'data': data });
      });
  }
  
  callbackChoose(floor, x, y, value) {
    var initial = !!this.state['data'][floor][y][x]['chosen'];
    if (value === undefined) {
      value = !initial; }
    value = !!value;
    
    if (value !== initial) {
    
      var chosen = this.state['chosen'];
      if (value) {
        chosen = React.addons.update(chosen, { $push: [[ floor, x, y ]] });
      } else {
        chosen.some((item, i) => {
          if (item[0] == floor && item[1] === x && item[2] === y) {
            chosen = React.addons.update(chosen, { $splice: [[ i, 1 ]] });
            return true;
          }
          return false;
        });
      }
    
      var data = React.addons.update(this.state['data'],
        { [floor]: { [y]: { [x]: { 'chosen': { $set: value } } } } });
      this.setState({ data, chosen });
    }
  }
  
  get tooMuch() {
    return this.state['chosen'].length >= 4;
  }
  
  get totalCost() {
    return this.state['chosen'].reduce((prev, curr) =>
      prev + this.state['data'][curr[0]][curr[2]][curr[1]]['price'], 0);
  }
    
  render () {
    return (
      <div className="rx-seatchooser">
        <TabsDefault tabs={this.state['data'].map((floor, idx) => `${idx+1} 楼`)}>

          {this.state['data'].map((floor, indexFloor) => 
            <div key={indexFloor} className="rx-seatchooser-floor-cont">
              <div className="rx-seatchooser-floor">
                {floor.map((row, indexY) =>
                  <div key={indexY} className="seat-row">
                    {row.map((cell, indexX) => {
                      const key = (indexX << 8) + indexY;
                      return (<Seat key={key}
                              data={cell} coordFloor={indexFloor}
                              coordX={indexX} coordY={indexY}
                              callbackChoose={this.callbackChoose}
                              disabled={this.tooMuch && !cell['chosen']}
                              />);
                    })}
                  </div>
                )}
              </div>
            </div>
          )}

        </TabsDefault>
        <div>
          共 {this.state['chosen'].length} 个座位 ￥{this.totalCost}
        </div>
      </div>
    );
  }
}

SeatChooser.propTypes = propTypes;
