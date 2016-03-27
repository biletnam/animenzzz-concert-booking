
const propTypes = {
    target: React.PropTypes.string
};

class SeatChooser extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      'data': [ ],
      'chosen': [ ],
      'activeTab': 0
    };
    
    this.callbackChoose = this.callbackChoose.bind(this);
    this.clearChosen = this.clearChosen.bind(this);
    this.submitChosen = this.submitChosen.bind(this);
    this.handleTabChange = this.handleTabChange.bind(this);
  }

  // we can only use bruteforce yet
  //  hopefully it's not a performance bottleneck
  //  and we may switch to hash table
  markSeatHold(data, klass, num, row) {
    for (var floor = 0; floor < data.length; floor++) {
      for (var x = 0; x < data[floor].length; x++) {
        for (var y = 0; y < data[floor][x].length; y++) {
          var seat = data[floor][x][y];
          if (seat['area'] == klass && seat['num'] == num && seat['row'] == row) {
            seat['hold'] = true;
            return seat;
          }
        }
      }
    }
  }

  componentDidMount() {
    var data = undefined,
      hold = undefined;
    $.when(
      $.getJSON(`/halldata/${this.props['target']}.json`,
        ret => data = ret),
      $.getJSON(`/recitals/${this.props['target']}/areas?format=json`, ret => hold = ret)
    ).then(() => {
      hold.forEach((holdSeat) =>
        this.markSeatHold(data, holdSeat['klass'], holdSeat['num'], holdSeat['row'])
      );
      this.setState({ data });
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
      
      //   MUST have on Firefox
      //    (as well as a submit button)
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
  
  handleTabChange(activeTab) {
      this.setState({ activeTab }); }

  render () {
    var className = classNames("rx-seatchooser-main", { "seat-too-much": this.tooMuch });
    return (
      <div className="rx-seatchooser clearfix">
        <TabSelect className="outer-container"
                  activeTab={this.state['activeTab']}
                  onChange={this.handleTabChange}
                  tabs={this.state['data'].map((floor, idx) => `${idx+1} 楼`)}
        />
        <div className="rx-seatchooser-wrap">
          <div className={className}>
            <TabContent activeTab={this.state['activeTab']}>
              {this.state['data'].map((floor, indexFloor) =>
                  <SeatFloor key={indexFloor} data={floor}
                      indexFloor={indexFloor}
                      callbackChoose={this.callbackChoose}
                  />
              )}
            </TabContent>
          </div>
          <div className="rx-seatchooser-second">
          <div>
              <SeatChosenList data={this.state['data']} chosen={this.state['chosen']} />
              <br />
              <div className="align-center">
                <div>共 {this.state['chosen'].length} 个座位</div>
                <div><strong>{this.totalCost}</strong> 元</div>
                <br />
                <button className="button" onClick={this.clearChosen}>清空</button>
                <span> </span>
                <button className="button" onClick={this.submitChosen}>提交</button>
              </div>
          </div>
          </div>
        </div>
      </div>
    );
  }
}

SeatChooser.propTypes = propTypes;
