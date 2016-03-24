
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
    this.clearChosen = this.clearChosen.bind(this);
    this.submitChosen = this.submitChosen.bind(this);
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

  clearChosen() {
      var chosen = this.state['chosen'];
      var data = this.state['data'];

      chosen.forEach(seat =>
        data = React.addons.update(data,
            { [seat[0]]: { [seat[2]]: { [seat[1]]: { 'chosen': { $set: false } } } } })
      );
      chosen = [ ];

      this.setState({ data, chosen });
  }

  submitChosen() {
      var form = document.createElement('form');

      form.style['display'] = 'none';
      form.method = 'GET';
      form.action = '/orders/new';

      this.state['chosen'].forEach(seat => {
          var data = this.state['data'][seat[0]][seat[2]][seat[1]];
          var seatValue = `${data['area']},${data['row']},${data['num']}`;
          var item = document.createElement('input');
          item.type = 'text';
          item.value = seatValue;
          item.name = 'seats[]';
          form.appendChild(item);
      });
      
      var submit = document.createElement('input');
      submit.type = "submit";
      submit.value = "submit";
      form.appendChild(submit);
      
      document.body.appendChild(form);

      form.submit();
  }

  get tooMuch() {
    return this.state['chosen'].length >= 4;
  }

  get totalCost() {
    return this.state['chosen'].reduce((prev, curr) =>
      prev + this.state['data'][curr[0]][curr[2]][curr[1]]['price'], 0);
  }

  render () {
    var className = classNames("rx-seatchooser", { "seat-too-much": this.tooMuch });
    return (
      <div className={className}>
        <TabsDefault className="outer-container" tabs={this.state['data'].map((floor, idx) => `${idx+1} 楼`)}>
            {this.state['data'].map((floor, indexFloor) =>
                <SeatFloor key={indexFloor} data={floor}
                    indexFloor={indexFloor}
                    callbackChoose={this.callbackChoose}
                />
            )}
        </TabsDefault>
        <div className="outer-container light-panel align-center">
            <div>
                共 {this.state['chosen'].length} 个座位 ￥{this.totalCost}
            </div>
            <button className="button" onClick={this.clearChosen}>清空</button>
            <button className="button" onClick={this.submitChosen}>提交</button>
        </div>
      </div>
    );
  }
}

SeatChooser.propTypes = propTypes;
