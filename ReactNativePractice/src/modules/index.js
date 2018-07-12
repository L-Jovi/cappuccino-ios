import * as types from './constants'
import createDucks from './ducks'
import combineSagas from './sagas'
import createStoreWithMiddleware from './store'

const { actionsPure, actionsSideEffect, reducerRoot, } = createDucks(types)

const getStore = () => {
  const {
    createStore,
    runSaga,
  } = createStoreWithMiddleware(reducerRoot)

  const store = createStore()
  runSaga(combineSagas(types))

  return store
}

export default getStore()

export { actionsPure, actionsSideEffect, }
