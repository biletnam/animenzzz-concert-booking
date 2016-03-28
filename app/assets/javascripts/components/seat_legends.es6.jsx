const propTypes = {
  'className': React.PropTypes.string,
  'prices': React.PropTypes.arrayOf(React.PropTypes.arrayOf(React.PropTypes.number))
};

class SeatLegends extends React.Component {
  render () {
    return (
      <div className={classNames('rx-seatchooser-legends', this.props['className'])}>
        {
          this.props['prices'].map((prices, i) => {
            var ret = prices.map(price => {
              if (typeof price == 'number') {
                return (
                  <span className="rx-seatchooser-legend">
                    <SeatPreview price={price} /> {price} 元
                  </span>
                );
              } else if (Object.prototype.toString.call(price) == '[object Array]') {
                return (
                  <span className="rx-seatchooser-legend">
                    <SeatPreview className={price[0]} /> {price[1]}
                  </span>
                )
              }
            });
            if (i < this.props['prices'].length-1) {
              ret.push(<span className="block-mobile" />); }
            return ret;
          })
        }
        </div>
    );
  }
}

SeatLegends.propTypes = propTypes;
