const path = require('path')

module.exports = (options, defaults) => {
  const {
    platform,
    dev,
    minify,
    bundle,
    root,
  } = options

  return {
    entry: `./index.${platform}.js`,

    output: {
      filename: 'main.jsbundle',
      path: path.resolve(__dirname, 'dist')
    },

    // module: {
    //   ...defaults.module,
    //   rules: [
    //     ...defaults.module.rules,
    //   ],
    // },

    // resolve: {
    //   ...defaults.resolve,
    //   plugins: [...defaults.resolve.plugins],
    //   modules: ['src', 'node_modules'],
    //   extensions: ['.js', '.jsx', '.json'],
    // },
  }
}
