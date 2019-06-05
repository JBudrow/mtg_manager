source 'https://rubygems.org'

# Classy web-development dressed in a DSL
gem 'sinatra'
# Auto-reload Sinatra applications
gem 'sinatra-contrib', require: 'sinatra/reloader'
# A Sinatra extension for setting and showing Rails-like flash messages.
gem 'sinatra-flash'
# A redirect helper that can set proper flash (rack-flash) before the redirection
gem 'sinatra-redirect-with-flash'
# Extends Sinatra with ActiveRecord helper methods and Rake tasks
gem 'sinatra-activerecord'
# Just the partials helper in a gem. That is all.
gem 'sinatra-partial'
# PostgreSQL Adapter for DataMapper
gem 'dm-postgres-adapter'
# DataMapper support for PostgreSQL HSTORE and ARRAY types
gem 'dm-pg-types'
# DataMapper plugin providing methods to increment and decrement properties 
gem 'dm-adjust'
# DataMapper plugin for writing and speccing migrations
gem 'dm-migrations'
# An Object Relational Mapper written in Ruby.
gem 'data_mapper'
# Pg is the Ruby interface to the PostgreSQL RDBMS.
gem 'pg'
# Makes http fun again!
gem 'httparty'
# Databases on Rails
gem 'activerecord'
# A wonderfully simple way to load Ruby code
gem 'require_all'
# JSON implementation for Ruby
# gem 'json', '~> 1.8.3'
gem 'json', '~> 1.8.6'
# A make-like build utility for Ruby. 
gem 'rake'
# A Ruby/Rack web server built for concurrency
gem 'puma'
# Manage Procfile-based applications
gem 'foreman'
# Redis-backed Ruby library for creating background jobs, placing them on multiple queues, and processing them later
gem 'resque'
# A Ruby Library for dealing with money and currency conversion
gem 'money'
# Pagination library for Rails, Sinatra, Merb, DataMapper, and more
gem 'will_paginate'
# HTML Abstraction Markup Language - A Markup Haiku
gem 'haml'
# Use ActiveModel has_secure_password
gem 'bcrypt'
# Don't make your Rubies go fast. Make them go fasterer ™
gem 'fasterer'
# A Ruby client library for Redis
gem 'redis'

group :development do 
  # Reloading rack development server / forking version of rackup
  gem 'shotgun'
  # Sinatra dressed for interactive ruby - a sinatra shell 
  gem 'tux'
  # Guard is a command line tool to easily handle events on file system modifications.
  gem 'guard'
  # Guard::RSpec automatically run your specs (much like autotest)
  gem 'guard-rspec', require: false
end 

group :test, :development do
  # Rack::Test is a layer on top of Rack's MockRequest similar to Merb's RequestHelper
  gem 'rack-test', require: 'rack/test'
  # RSpec meta-gem that depends on the other components
  gem 'rspec'
  # Library for stubbing and setting expectations on HTTP requests in Ruby 
  gem 'webmock'
  # A library for setting up Ruby objects as test data
  gem 'factory_bot'
  # Pure-Ruby Readline Implementation 
  gem 'rb-readline'
  # An IRB alternative and runtime developer console
  gem 'pry'
end 