# Shioconv

convert between cubic contents and weight for typcal seasonings.

## Installation

Add this line to your application's Gemfile:

    gem 'shioconv'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shioconv

## Usage

TODO: Write usage instructions here

## Data source

source of data/condiments.yaml is temporary hosted on google drive.

https://docs.google.com/spreadsheet/ccc?key=0AkNdq2RYAbcWdEp0cGFfMnlKeFd0N3BUbVNOMmo3cWc#gid=0

1. select all and copy this sheat and paste as `data/condiments.tsv`
1. `% cd shiocnov/data`
1. `% ruby meterials.rb`
1. add, commit and push or send pull-reqest

## Contributing

1. Fork it ( https://github.com/[my-github-username]/shioconv/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
