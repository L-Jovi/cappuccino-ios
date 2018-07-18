import React from 'react'
import { Provider, } from 'react-redux'
import { NativeRouter, Route, Link, } from 'react-router-native'

import store from '~modules'
import OA from './views/oa'

export default class App extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <NativeRouter>
          <Route exact path="/" component={OA}/>
        </NativeRouter>
      </Provider>
    )
  }
}
