# Memberful Integration

[![Build Status](https://travis-ci.org/choiceaustralia/memberful-integration.svg?branch=master)](https://travis-ci.org/choiceaustralia/memberful-integration)

Integrate Discourse with Memberful's API.

## Installation

Enter app: `sudo ./launcher enter app`

Follow these instructions to mount the engine: https://gist.github.com/rimian/170d480c1979b3b6b0880ed0cace31de

Restart app: `sudo ./launcher restart app`

## Developing

Install this plugin to a local instance of discourse and the following directories:

```
cp -r plugins/memberful/app/controllers/memberful app/controllers/
```

## Testing

To use the fixtures against a local install:

```
fixture=$(<fixtures/member_signup.json)
curl -H "Content-Type: application/json" -X POST -d $fixture http://0.0.0.0/memberful/memberful
```
