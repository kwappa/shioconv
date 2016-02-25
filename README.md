# Shioconv

convert between volumes and weight for typcal condiments.

[![Build Status](https://travis-ci.org/kwappa/shioconv.png)](https://travis-ci.org/kwappa/shioconv)
[![Coverage Status](https://coveralls.io/repos/kwappa/shioconv/badge.png?branch=master)](https://coveralls.io/r/kwappa/shioconv?branch=master)
[![Code Climate](https://codeclimate.com/github/kwappa/shioconv.png)](https://codeclimate.com/github/kwappa/shioconv)

## Usage

* convert amount of condiments between units

```
salt = Shioconv.measure(:salt, 1, :tbsp)

salt.to_cc # => 15.0
salt.to_g  # => 18.0
```

* show all condiments and units

```
Shioconv::Condiment.list # => returns array of string
Shioconv::Unit.list      # => returns array of string
```
