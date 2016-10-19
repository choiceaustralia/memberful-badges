# Memberful Integration

Integrate Discourse with Memberful's API.

## Usage
How to use my plugin.

## Installation

```ruby
gem 'memberful'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install memberful
```

### Adding to your discourse app

Add the following to your app container in the `after_code` hook:

```
hooks:
  after_code:
    - exec:
        cd: $home
        cmd:
          - git clone https://github.com/choiceaustralia/memberful-integration --depth 1 plugins/memberful
          - cp -r plugins/memberful/app/controllers/memberful app/controllers/
```

This will copy your controller into discourse and install the plugin which appends the routes.

## Testing

To use the fixtures against a local install:

```
fixture=$(<fixtures/member_signup.json)
curl -H "Content-Type: application/json" -X POST -d $fixture http://0.0.0.0/memberful/memberful
```

## Contributing
Contribution directions go here.
