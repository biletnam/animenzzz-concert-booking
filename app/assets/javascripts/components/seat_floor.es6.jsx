
const propTypes = {
    'callbackChoose': React.PropTypes.func,
    'data': React.PropTypes.arrayOf(React.PropTypes.arrayOf(React.PropTypes.object)),
    'indexFloor': React.PropTypes.number,
};

class SeatFloor extends React.Component {
    constructor(props) {
        super(props);
        
        this.callbackChoose = this.callbackChoose.bind(this);
    }
    
    shouldComponentUpdate(nextProps, nextState) {
        if (this.props['data'] === nextProps['data']) {
            return false; }
        return true;
    }
    
    callbackChoose() {
        return this.props['callbackChoose'].apply(this, arguments);
    }
    
    render() {
        return (
            <div className="rx-seatchooser-floor-cont">
                <div className="rx-seatchooser-floor">
                    {this.props['data'].map((row, indexY) =>
                        <SeatRow key={indexY} data={row} indexY={indexY}
                            indexFloor={this.props['indexFloor']}
                            callbackChoose={this.callbackChoose}
                        />
                    )}
                </div>
            </div>
        );
    }
}

SeatFloor.propTypes = propTypes;