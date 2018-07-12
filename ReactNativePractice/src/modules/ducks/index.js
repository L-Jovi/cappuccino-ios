import { combineReducers } from 'redux-immutable'

import utils from './utils'

const createDucks = (types) => {
  // TODO consider [require.context] implements
  const oa = require('./oa').default(types)

  const actionsSideEffect = {
    utils,
    oa: oa.actionsSideEffect,
  }

  const actionsPure = {
    ...oa.actionsPure,
  }

  const reducerRoot = combineReducers({
    oa: oa.reducer,
  })

  return { actionsSideEffect, actionsPure, reducerRoot, }
}

export default createDucks
