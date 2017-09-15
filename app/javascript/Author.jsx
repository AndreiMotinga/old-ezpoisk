
// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const Author = ({ name }) => {
  return (
    <div>Hello {name}!</div>
  )
}

Author.propTypes = {
  name: PropTypes.string
}

export default Author
