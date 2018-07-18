import 'haul/hot/patch'
import {
  makeHot,
  tryUpdateSelf,
  callOnce,
  clearCacheFor,
  redraw,
} from 'haul/hot'
import { AppRegistry } from 'react-native'

import App from './src/App.test'

AppRegistry.registerComponent('ReactNativePractice', makeHot(() => App))

if (module.hot) {
  module.hot.accept(['./src/App.test'], () => {
    clearCacheFor(require.resolve('./src/App.test'))
    redraw(() => require('./src/App.test').default)
  })
}
