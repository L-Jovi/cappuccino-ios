# 多环境测试

企业生产环境推荐分离测试环境，在内部隔离的环境中经过测试确认后，再切换（promote）到生产环境进行灰度发布。

该部分详细内容请参考官方文档 [多环境测试 - #multi-deployment-testing](https://github.com/Microsoft/react-native-code-push#multi-deployment-testing) 章节，本文档会基于该部分内容进行梳理，并提供一个 [Demo](https://github.com/L-Jovi/exer-ios/tree/master/CodePushDemonstration) 的用例进行参考，当然官方也提供了相应的示例，请参考 [#multi-deployment-testing-ios](https://github.com/Microsoft/react-native-code-push/blob/master/docs/multi-deployment-testing-ios.md) 的 __NOTE__ 部分自行下载搭建。

## 配置

这里的配置项目较为简单，仅仅是修改了 __Info.plist__ 文件中对应的 `CodePushDeploymentKey` 为适配多环境不同 key 对应的版本。

这里不单独对配置进行引导，请直接参考官方 [多环境 iOS 平台配置](https://github.com/Microsoft/react-native-code-push/blob/master/docs/multi-deployment-testing-ios.md) 步骤即可。

## 多环境发布流程

该部分针对完成配置后的多环境测试发布标准流程进行整理和原理的讲解。

假设目前的环境配置名称延用标准的 `Staging`（代表内部版本）和 `Production `（代表线上版本），之后的发布流程如下步骤所示。

1. 所有更新的内容先发布到 `Staging` 环境
  
  这里以 Demo-ios 的项目示例
  
  ```
  code-push release-react Demo-ios ios --mandatory true -d Staging --description '日志记录'
  ```
  
  注意上述命令以强制更新的模式推送资源到 Demo-ios 的远端仓库中（App Center 或者 私服），并指定了平台类型为 iOS 和 `--deploymentName` 为 `Staging`。
  
2. 内部测试客户端可以开始测试新的热修复版本

  这里需要注意的是，原先在 JS 逻辑中调用 `sync` 的位置应该相应区分拉取远端环境的 key，以 Demo-ios 为例，这里强制硬编码为了每次拉取 key 为 `Staging` 环境的热修复版本。
  
  ```
  codePush.sync(
        {
          deploymentKey: 'ridyazxRiMN2GLRXqFLSjBnGqJ8o4ksvOXqog',
          installMode: codePush.InstallMode.IMMEDIATE,
          updateDialog: true
        },
        ...
      );
  ```
  
  应当注意的是，在实际项目中，触发热修复交互的位置应当区分要获取目标环境的 `deploymentKey`，而不应该直接硬编码，如下所示。
  
  ```
  syncMandatory(key) {	// 自行封装对应交互点传入的 key 值
    codePush.sync(
      {
        deploymentKey: key,
        installMode: codePush.InstallMode.IMMEDIATE,
      },
      (status) => {
        switch (status) {
          case codePush.SyncStatus.DOWNLOADING_PACKAGE:
            break;
          case codePush.SyncStatus.INSTALLING_UPDATE:
            break;
          case codePush.SyncStatus.UNKNOWN_ERROR:
            break;
        }
      },
      ({ receivedBytes, totalBytes, }) => {
        // TODO call progress later
      },
    );
  }
  ```
  
  考虑到产品策略，线上正式版本的用户不应当直接从已知的交互点直接获取到 `Staging` 热修复资源，只能获取到 `Prodution` 环境的版本资源。

3. `Staging` 环境完成测试后灰度切换（promote）到 `Prodution` 环境

  ```
  code-push promote Demo-ios Staging Production -r 100%
  ```
  
  以上命令的含义为将已经完成内部新的热修复测试版本的最新资源从 `Staging` 环境切换（promote）到线上环境（`Production`），并指定线上用户中可以收到通知的人群比重，这里的参数可以按照产品策略调整（比如 20% 等）。
  
4. 线上用户完成热修复灰度的发放

  到了这一步，原先在 `Staging` 环境中完成测试的内部客户端已经切换到了 `Production` 环境中，不会再接收到额外的更新通知，而线上的用户可以直接接收到已经经过测试的新版本
  
5. 灰度的填补

  原先在 `promote` 指令中如果设定了灰度比例不足 100% 的参数，可以在线上用户接收到热修复最新资源后进行灰度的填补，使用以下命令。
  
  ```
  code-push patch Demo-ios Production -r 100%
  ```
  
6. 版本回退

  虽然已经有 `Staging` 环境进行内部测试的保障，但是不排除线上仍旧有出现问题的可能性，这个时候可以进行版本的回退，code-push 采用与 git 相似的设计，版本回退会产生新的 label，不会造成历史版本记录的真正回滚。
  
  ```
  rollback Demo-ios Production
  ```
  
  以上命令回滚了 `Production` 环境的版本到上一次热修复，并在历史记录后面追加了新的 label。