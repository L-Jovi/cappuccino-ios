import 'haul/hot/patch'
import {
  makeHot,
  tryUpdateSelf,
  callOnce,
  clearCacheFor,
  redraw,
} from 'haul/hot'
import { AppRegistry } from 'react-native'
import App from './App'

AppRegistry.registerComponent('ReactNativePractice', makeHot(() => App))

if (module.hot) {
  module.hot.accept(['./App'], () => {
    clearCacheFor(require.resolve('./App'));
    redraw(() => require('./App').default);
  })
}
