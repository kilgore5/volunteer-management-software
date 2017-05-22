import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const Item = props => (
  <div>Hello {props.name}!</div>
)

Item.defaultProps = {
  name: 'David'
}

Item.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Item name="React" />
  )
})