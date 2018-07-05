import path from 'path'
import { createWebpackConfig } from 'haul'

export default {
  webpack: createWebpackConfig((options) => {
    const {
      platform,
      dev,
      minify,
      bundle,
      root,
    } = options

    const baseConfig = {
      entry: `./index.${platform}.js`,

      module: {
        rules: [
        ],
      },

      resolve: {
        alias: {
        },
      }
    }

    if (dev === true) {
      return {
        ...baseConfig,
      }

    } else {
      return {
        ...baseConfig,

        output: {
          filename: `main.jsbundle`,
          path: path.resolve(__dirname, 'dist')
        },
      }
    }
  })
}
