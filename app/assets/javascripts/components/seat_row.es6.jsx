
const propTypes = {
    'data': React.PropTypes.arrayOf(React.PropTypes.object),
    'callbackChoose': React.PropTypes.func,
    'indexY': React.PropTypes.number,
    'indexFloor': React.PropTypes.number
}

class SeatRow extends React.Component {
    constructor(props) {
        super(props);
        
        this.callbackChoose = this.callbackChoose.bind(this);
    }
    
    shouldComponentUpdate(nextProps, nextState) {
        return this.props['data'] !== nextProps['data'];
    }
    
    callbackChoose() {
        return this.props['callbackChoose'].apply(this, arguments);
    }
    
    render() {
        const { data, indexY } = this.props;
        return (
            <div key={indexY} className="seat-row">
                {data.map((cell, indexX) => {
                const key = (indexX << 8) + indexY;
                return (
                    <Seat key={key}
                        data={cell} coordFloor={this.props['indexFloor']}
                        coordX={indexX} coordY={indexY}
                        callbackChoose={this.callbackChoose}
                        disabled={cell['hold']}
                    />
                    );
                })}
            </div>
        );
    }
}

SeatRow.propTypes = propTypes;