import React from 'react'
import { StyleSheet, Text, View } from 'react-native'
import stylesOA from './styles'

const styles = StyleSheet.create(require('./styles'))

export default class App extends React.Component {
  constructor(props) {
    super(props)
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
      </View>
    )
  }
}
