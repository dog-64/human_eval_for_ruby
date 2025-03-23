#!/usr/bin/env ruby

require 'bundler/setup'
require_relative '../lib/human_eval/solver_cli'

HumanEval::SolverCLI.start(ARGV) 