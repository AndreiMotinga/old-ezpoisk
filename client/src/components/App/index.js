import React, { Component } from 'react';
import './index.css';

class App extends Component {
  constructor(props) {
    super(props)

    this.state = {
      value: "Mr. A"
    }
  }

  handleInput(e) {
    console.log(e.target.value)
    this.setState({ value: e.target.value })
  }


  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h2>Welcome to React</h2>
        </div>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.

          <input
            type="text"
            name="title"
            value={this.state.value}
            onChange={this.handleInput.bind(this)}
          />
        </p>
      </div>
    );
  }
}

export default App;
