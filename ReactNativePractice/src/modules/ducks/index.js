import { combineReducers } from 'redux-immutable'

import utils from './utils'

const createDucks = (types) => {
  // TODO consider [require.context] implements
  const oa = require('./oa').default(types)

  const reducerRoot = combineReducers({
    oa: oa.reducer,
  })

  const actionsPure = {
    ...oa.actionsPure,
  }

  const actionsSideEffect = {
    utils,
    oa: oa.actionsSideEffect,
  }

  return { reducerRoot, actionsPure, actionsSideEffect,}
}

export default createDucks
