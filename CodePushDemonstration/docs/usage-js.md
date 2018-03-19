# 使用 react-native-code-push

鉴于业务需求和热更新的交互方式很大层面取决于业务，所以该模块封装的 `updateDialog` 更新交互并没有实用性，而且也无法定制（关于为何无法定制可以参考 [issues/402](https://github.com/Microsoft/react-native-code-push/issues/402)），因此只需要熟悉核心的 API `sync` 相关功能即可。

可以参考该接口的官方文档 [#codepushsync](https://github.com/Microsoft/react-native-code-push/blob/master/docs/api-js.md#codepushsync)

```
codePush.sync(options: Object, syncStatusChangeCallback: function(syncStatus: Number), downloadProgressCallback: function(progress: DownloadProgress), handleBinaryVersionMismatchCallback: function(update: RemotePackage)): Promise<Number>;
```

值得注意的是官方提供了两种更新模式 __Silent mode__ 和 __Active mode__，最大的区别取决于更新完成后是否重启应用即时应用新的功能，缺点是对用户可能会有使用的交互干扰，所以更新策略完全可以取决于我方产品的迭代速度和版本间核心功能的差异。

```
// Fully silent update which keeps the app in
// sync with the server, without ever
// interrupting the end user
codePush.sync();

// Active update, which lets the end user know
// about each update, and displays it to them
// immediately after downloading it	
codePush.sync({ updateDialog: true, installMode: codePush.InstallMode.IMMEDIATE });
```

最后在更新策略中需要着重考量 Apple 官方的政策，尽量不能做出打扰用户的更新行为或者不符合 App 功能和应用的更新结果。

细节可以参考官方文档 [#store-guideline-compliance](https://github.com/Microsoft/react-native-code-push#store-guideline-compliance)

> Interpreted code may be downloaded to an Application but only so long as such code: (a) does not change the primary purpose of the Application by providing features or functionality that are inconsistent with the intended and advertised purpose of the Application as submitted to the App Store, (b) does not create a store or storefront for other code or applications, and (c) does not bypass signing, sandbox, or other security features of the OS.

> Apps must not force users to rate the app, review the app, download other apps, or other similar actions in order to access functionality, content, or use of the app.

这里需要注意 `sync` 接口中封装了 `notifyApplicationReady` 在每次应用启动的时候通知其是否已经保持在某次热更新之后的状态。

如果业务中定制了热修复的交互模式，使得 `sync` 没有在 App 启动的时候被调用，那么请一定在 `componentDidMount` 中单独调用 `notifyApplicationReady` 以保证 code push 正确的应用的最近版本的资源。

具体细节可以参考 [issues/323](https://github.com/Microsoft/react-native-code-push/issues/323)