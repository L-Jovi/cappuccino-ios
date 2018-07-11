import React from 'react'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { StyleSheet, Text, View, TouchableOpacity, } from 'react-native'

import { actionsPure, actionsSideEffect, } from '~modules'

const { oa: actsMixed, } = actionsSideEffect

const styles = StyleSheet.create(require('./styles').default)


class OA extends React.Component {
  constructor(props) {
    super(props)
    this.actions = actionsSideEffect.utils.bindActions(this, actsMixed)
  }

  componentWillMount() {
  }

  componentDidMount() {
  }

  componentWillUnmount() {
  }

  render() {
    return (
      <View style={styles.container}>
        <Text>OA Page</Text>

        <TouchableOpacity
          style={styles.touchable}
          onPress={this.actions.touchable.onPress}>
          <Text>onPress</Text>
        </TouchableOpacity>
      </View>
    )
  }
}

export default connect(
  (state) => {
    const { isLoadPage } = state.get('oa').toObject()

    return {
      isLoadPage,
    }
  },

  (dispatch) => {
    return {
      actions: bindActionCreators(actionsPure.oa, dispatch),
    }
  },
)(OA)
