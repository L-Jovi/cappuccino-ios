import { fork } from 'redux-saga/effects'

import combineOa from './oa'

const combineSagas = (types) => {
  function* root() {
    yield [
      fork(combineOa(types)),
    ]
  }

  return root
}

export default combineSagas
