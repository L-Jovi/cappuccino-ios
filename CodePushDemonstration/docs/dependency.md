# 组织依赖

## 构建依赖

[react-community/create-react-native-app](https://github.com/react-community/create-react-native-app)

[code-push/docs](https://microsoft.github.io/code-push/docs/getting-started.html	)

[Microsoft/react-native-code-push](https://github.com/Microsoft/react-native-code-push)

[lisong/code-push-server](https://github.com/lisong/code-push-server)

## 版本信息

```
"react": "16.2.0"
"react-native": "0.52.0"
"react-native-code-push": "^5.2.2"
```

## 需求

### 目的

iOS 平台应用版本快速迭代，应用内热更新绕过冗长的审核期。

> 虽然技术上动态库的更新是可行的，但是对于 AppStore 上架的应用是不可以的。iOS 8 之后虽然可以上传含有动态库的应用，但是 Apple 不仅需要你动态库和 App 的签名一致，而且会在你上架的时候再经过一次 AppStore 的签名。在线更新动态库，首先需要拥有 Apple APPStore 私钥，而这是不可能的。

### 原理

基于 objc 天然支持的消息机制和运行时，通过构建消息队列和反射依赖 JavascriptCore 得以调用 Native 端的 API。

核心细节可以参考 JSPatch 作者 @bang590 的文章 [React Native通信机制详解](https://blog.cnbang.net/tech/2698/)。

核心消息队列流程图。

![workaround](./images/workaround.png)

另提供 [React Native 详细源码导读](https://github.com/guoxiaoxing/react-native/blob/master/doc/ReactNative%E6%BA%90%E7%A0%81%E7%AF%87/1ReactNative%E6%BA%90%E7%A0%81%E7%AF%87%EF%BC%9A%E6%BA%90%E7%A0%81%E5%88%9D%E8%AF%86.md) 。

以下仅针对应用热修复示例进行引导，不再涉及任何原理内容。