import { Map, } from 'immutable'
import { createActions, handleActions, combineActions, } from 'redux-actions'

const initialState = Map({
  isLoadPage: true,
})

export default (types) => {
  const {
    OA_IS_LOADING,
  } = types

  const reducer = handleActions({
    [OA_IS_LOADING](state, { payload: { isLoadPage } }) {
      return state.set('isLoadPage', isLoadPage)
    },
  }, initialState)

  const actionsPure = createActions({
    [OA_IS_LOADING]: (isLoadPage) => ({ isLoadPage }),
  })

  const actionsSideEffect = {
    touchable: {
      onPress() {
        this.props.actions.isLoading(false)
      }
    }
  }

  return { reducer, actionsPure, actionsSideEffect, }
}
