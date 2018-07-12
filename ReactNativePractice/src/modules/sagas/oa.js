import _ from 'lodash'
import {
  fork,
  take,
  put,
  call,
  takeLatest,
  select,
} from 'redux-saga/effects'

const combineOa = (types) => {
  const {
    OA_IS_LOADING,
  } = types

  function* watchTest(action) {
    console.log(action)
  }

  function* watch() {
    yield [
      fork(takeLatest, OA_IS_LOADING, watchTest),
    ]
  }

  return watch
}

export default combineOa
