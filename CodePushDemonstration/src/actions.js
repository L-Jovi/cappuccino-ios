import _ from 'lodash'
import codePush from "react-native-code-push"

const bindActions = (self, actions) => {
  const binding = (self, actions, binding) => {
    if (_.isArray(actions) === true) {
      return _.map(actions, (action) => {
        return binding(self, action, binding)
      });
    }

    if (_.isPlainObject(actions) === true) {
      return _.mapValues(actions, (action) => {
        return binding(self, action, binding)
      });
    }

    if (_.isFunction(actions) === true) {
      return actions.bind(self)
    }
  };

  return binding(self, actions, binding)
}

export default bindActions

export const actions = {
  hotfix: {
    codePushStatusDidChange(syncStatus) {
      switch(syncStatus) {
        case codePush.SyncStatus.CHECKING_FOR_UPDATE:
          this.setState({ syncMessage: "检查更新" });
          break;
        case codePush.SyncStatus.DOWNLOADING_PACKAGE:
          this.setState({ syncMessage: "下载资源包" });
          break;
        case codePush.SyncStatus.AWAITING_USER_ACTION:
          this.setState({ syncMessage: "等待用户交互" });
          break;
        case codePush.SyncStatus.INSTALLING_UPDATE:
          this.setState({ syncMessage: "安装更新" });
          break;
        case codePush.SyncStatus.UP_TO_DATE:
          this.setState({ syncMessage: "应用已是最新版本", progress: false });
          break;
        case codePush.SyncStatus.UPDATE_IGNORED:
          this.setState({ syncMessage: "用户放弃更新", progress: false });
          break;
        case codePush.SyncStatus.UPDATE_INSTALLED:
          this.setState({ syncMessage: "更新已经安装并会在重启后生效", progress: false });
          break;
        case codePush.SyncStatus.UNKNOWN_ERROR:
          this.setState({ syncMessage: "未知错误", progress: false });
          break;
      }
    },

    codePushDownloadDidProgress(progress) {
      this.setState({ progress });
    },
  },

  touchableOpacity: {
    syncImmediate() {
      codePush.sync(
        {
          // deploymentKey: 'gi4DNGxLQLkZscKMDvNT8toxS51H4ksvOXqog',
          deploymentKey: 'ridyazxRiMN2GLRXqFLSjBnGqJ8o4ksvOXqog',
          installMode: codePush.InstallMode.IMMEDIATE,
          updateDialog: true
        },
        this.actions.hotfix.codePushStatusDidChange.bind(this),
        this.actions.hotfix.codePushDownloadDidProgress.bind(this)
      );
    }
  }
}
