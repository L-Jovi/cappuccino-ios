import { Map, } from 'immutable'
import { createActions, handleActions, } from 'redux-actions'

const initialState = Map({
  isLoadPage: true,
})

const createOa = (types) => {
  const {
    OA_IS_LOADING,
  } = types;

  const actionsOa = createActions({
    [OA_IS_LOADING]: (isLoadPage) => ({ isLoadPage })
  })

  const reducerOa = handleActions({
    [actionsOa.osIsLoading](state, { payload: { isLoadPage } }) {
      return state.set('isLoadPage')
    }
  }, initialState)

  return { actionsOa, reducerOa };
}

export default createOa;
