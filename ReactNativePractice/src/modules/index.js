import * as types from './constants'
import actionsSideEffect from './actions'
import createDucks from './ducks'
// import combineSagas from './sagas'
import createStoreWithMiddleware from './store'

const { reducerRoot, actionsPure, } = createDucks(types)

const getStore = () => {
  const {
    createStore,
    runSaga,
  } = createStoreWithMiddleware(reducerRoot)

  const store = createStore()
  // runSaga(combineSagas(types))

  return store
}

export default getStore()

export { actionsPure, actionsSideEffect, }
