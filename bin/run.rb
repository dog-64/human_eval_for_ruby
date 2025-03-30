#!/usr/bin/env ruby

require "bundler/setup"
require_relative "../lib/runner/cli"

Runner::CLI.start(ARGV) 
