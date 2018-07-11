import { combineReducers } from 'redux-immutable'

import createOa from './oa'

// TODO transfer to autobuild
const createDucks = (types) => {
  const { actionsOa, reducerOa } = createOa(types)

  const actionsPure = {
    ...actionsOa,
  }

  const reducerRoot = combineReducers({
    oa: reducerOa,
  })

  return { actionsPure, reducerRoot, }
}

export default createDucks
