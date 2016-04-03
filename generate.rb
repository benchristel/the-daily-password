#!/usr/bin/env ruby

require_relative './lib/password'

20.times { puts Password.generate }
