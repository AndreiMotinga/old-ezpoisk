import React from 'react'
// import { connect } from 'react-redux'
import App from './App.jsx'

const mapPropsToState = state => ({
  // appLoaded: state.common.appLoaded,
  // currentUser: state.common.currentUser,
  // redirectTo: state.common.redirectTo
})

const mapDispatchToProps = dispatch => ({
  // redirect: () => dispatch({ type: 'REDIRECT' }),
  // onLoad: (payload, token) =>
  //   dispatch({ type: 'APP_LOAD', payload, token }),
})

// export default connect(mapPropsToState, mapDispatchToProps)(App)
export default App
