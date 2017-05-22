var React = require("react")
var Post = React.createClass({
  propTypes: {
    title: React.PropTypes.string,
    published: React.PropTypes.bool
  },

  render: function() {
    return (
      <div>
        <div>Title: {this.props.title}</div>
        <div>Published: {this.props.published}</div>
      </div>
    );
  }
});
module.exports = Post
