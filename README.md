# Memberful Integration

Integrate Discourse with Memberful's API.

Controllers and specs are copied into discourse and the plugin creates the relevant routes.

## Installation

Add the following to your app in the `after_code` hook:

```
hooks:
  after_code:
    - exec:
        cd: $home
        cmd:
          - git clone https://github.com/choiceaustralia/memberful-integration --depth 1 plugins/memberful
          - cp -r plugins/memberful/app/controllers/memberful app/controllers/
          - cp -r plugins/memberful/spec/controllers/memberful spec/controllers/
```

This will copy your controller into discourse and install the plugin which appends the routes.

## Developing

Install this plugin to a local instance of discourse and the following directories:

```
cp -r plugins/memberful/app/controllers/memberful app/controllers/
cp -r plugins/memberful/spec/controllers/memberful spec/controllers/
```

To test the fixtures with curl:

```
fixture=$(<spec/fixtures/member_signup.json)
curl -H "Content-Type: application/json" -X POST -d $fixture http://0.0.0.0/memberful/memberful
```

## Testing

Copy the specs (as above)

```
bundle exec rspec spec/controllers/memberful
```
