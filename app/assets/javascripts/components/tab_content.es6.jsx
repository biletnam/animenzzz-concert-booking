
const propTypes = {
  'activeTab': React.PropTypes.number,
};

const defaultProps = {
  'activeTab': 0
};

class TabContent extends React.Component {
  
  constructor(props) {
    super(props); }
    
  render() {
    return (
        <div className="rx-tabc">
            {this.props.children.map((tab, index) => 
                <div key={index}
                  className={classNames('rx-tabc-wrap', { 'rx-tabc-active': (this.props['activeTab'] == index) })}
                >
                    {tab}
                </div>
            )}
        </div>
    );
  }
}

TabContent.propTypes = propTypes;
TabContent.defaultProps = defaultProps;
