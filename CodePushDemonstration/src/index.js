import React from 'react'
import {
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  Image,
} from 'react-native'
import codePush from "react-native-code-push"

import stylesNative from './styles'
import bindActions, { actions, } from './actions'


export default class App extends React.Component {
  static styles = StyleSheet.create(stylesNative)

  constructor(props) {
    super(props)
    this.actions = bindActions(this, actions)
    this.state = {
      syncMessage: '等待更新',
    }
  }

  componentDidMount() {
    codePush.notifyApplicationReady()
  }

  render() {
    const { styles, } = App

    let progressView

    if (this.state.progress) {
      progressView = (
        <Text style={styles.textProgress}>
          更新进度：{this.state.progress.receivedBytes} of {this.state.progress.totalBytes} bytes received
        </Text>
      )
    } else {
      progressView = (
        <Text style={styles.textProgress}>
          更新进度：0 of 0 bytes received
        </Text>
      )
    }

    return (
      <View style={styles.container}>
        <View style={styles.containerShow}>
          <Text>组件更新展示区域</Text>

          <Image
            style={styles.image}
            resizeMode={Image.resizeMode.contain}
            source={require("./images/steam-app.png")}
            // source={require("./images/steam-logo.png")}
          />

          <Text style={styles.textShow}>更新内容 v4</Text>
        </View>

        <View style={styles.containerControl}>
          <Text>模式操作区域</Text>
          <TouchableOpacity
            style={styles.btn}
            onPress={this.actions.touchableOpacity.syncImmediate}>
            <Text style={styles.btnText}>强制更新</Text>
          </TouchableOpacity>

          <Text style={styles.textMsg}>
            更新状态： {this.state.syncMessage}
          </Text>

          {progressView}
        </View>
      </View>
    )
  }
}
