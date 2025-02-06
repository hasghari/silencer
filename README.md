# Silencer

A gem to silence ruby warnings from other gem dependencies.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add gem-silencer
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install gem-silencer
```

## Usage

You need to define a `.silencer.yml` file in the root of your project. The file should contain a list of gems that you 
want to silence warnings from. For example:

```yaml
httpclient:
  version: 2.8.3
  patterns:
    - literal string will be frozen
```

When you update any gem listed in the `.silencer.yml` file, this gem will raise an error so you can verify that the 
warning has not been addressed in the updated version. If the warning has been resolved, you can remove the gem from the
`.silencer.yml` file. If not, you can update the version number in the `.silencer.yml` file to match the new version.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can 
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the 
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, 
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hasghari/silencer.
