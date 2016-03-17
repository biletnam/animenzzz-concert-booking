var Tabs = (TabSelect, TabContent) => {
  const propTypes = {
    'tabs': React.PropTypes.arrayOf(React.PropTypes.string)
  };
  var WrappedComponent = class extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        'activeTab': 0
      };
      this.handleChange = this.handleChange.bind(this);
    }
    
    handleChange(activeTab) {
      this.setState({ activeTab }); }
    
    render() {
      return (
        <div>
          <TabSelect activeTab={this.state['activeTab']} onChange={this.handleChange} tabs={this.props['tabs']} />
          <TabContent activeTab={this.state['activeTab']}>
            {this.props.children}
          </TabContent>
        </div>
      );
    }
  };
  WrappedComponent.propTypes = propTypes;
  return WrappedComponent;
}

var TabsDefault = Tabs(TabSelect, TabContent);

