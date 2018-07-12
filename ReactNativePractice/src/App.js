import React from 'react'
import { Provider, } from 'react-redux'

import store from '~modules'
import OA from './views/oa'

export default class App extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <OA />
      </Provider>
    )
  }
}
