#!/usr/bin/env ruby

require 'bundler/setup'
require_relative '../lib/solver'

Solver::CLI.start(ARGV) 