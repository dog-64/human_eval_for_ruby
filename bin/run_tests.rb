#!/usr/bin/env ruby

require "bundler/setup"
require_relative "../lib/test_runner/cli"

TestRunner::CLI.start(ARGV) 