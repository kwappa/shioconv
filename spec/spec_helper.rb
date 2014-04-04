require 'bundler'
Bundler.setup(:default, :test)
$: << File.join(File.dirname(File.expand_path(__FILE__)), %w[.. lib])
require 'shioconv'
