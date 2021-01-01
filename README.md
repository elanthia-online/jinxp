# jinxp / jinx packager

single [crystal](http://crystal-lang.org/) binary to package a jinx repo for publishing

## Usage / Continuous Deployment

There are several options for CD, in this repo you will find an example `netlify.toml` for your convenience.

Basically anything that allows you to upload your `dist/` folder will work though.

## Usage / CLI

```
jinxp --help
```

## Development

clone this repo, make a pr

## Build

Install [Crystal and Shards](https://crystal-lang.org/install/), then run:

```
shards build
```

## Contributing

1. Fork it (<https://github.com/elanthia-online/jinxp/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request (<https://github.com/elanthia-online/jinxp/compare>)

## Contributors

- [Ondreian](https://github.com/ondreian) - creator and maintainer
