#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rake/testtask'
require File.expand_path('../lib/mapbox-gl/updater', __FILE__)

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

desc 'Update Mapbox GL JS assets and plugins'
task 'update-mapbox' do
  Updater.new.update
end

task update: 'update-mapbox'

task default: :test
