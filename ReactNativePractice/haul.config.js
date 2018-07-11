import path from 'path'
import { createWebpackConfig } from 'haul'

export default {
  webpack: env => {
    const config = createWebpackConfig((options) => {
      const {
        platform,
        dev,
        minify,
        bundle,
        root,
      } = options

      return {
        entry: `./index.${platform}.js`,
      }
    })(env)

    config.resolve.alias['~modules'] = path.resolve(__dirname, 'src', 'modules')

    if (env.dev === true) {

    } else {
      config.output = {
        filename: `main.jsbundle`,
        path: path.resolve(__dirname, 'dist')
      }
    }

    return config
  }
}
