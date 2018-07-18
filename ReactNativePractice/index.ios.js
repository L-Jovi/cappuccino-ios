import 'haul/hot/patch'
import {
  makeHot,
  tryUpdateSelf,
  callOnce,
  clearCacheFor,
  redraw,
} from 'haul/hot'
import { AppRegistry } from 'react-native'

import App from './src/App'

AppRegistry.registerComponent('ReactNativePractice', makeHot(() => App))

if (module.hot) {
  module.hot.accept(['./src/App'], () => {
    clearCacheFor(require.resolve('./src/App'))
    redraw(() => require('./src/App').default)
  })
}
