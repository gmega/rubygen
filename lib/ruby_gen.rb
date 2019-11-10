# frozen_string_literal: true
require 'continuation'

##
# Python-style generators in Ruby using continuations.

class RubyGen

  ##
  # Creates a new generator.
  #
  # = Example
  #
  #   gen = RubyGen.new(3, 5) do |gen, x, y|
  #     (x..y).each { |i| gen.yield(i) }
  #   end
  #
  #   gen.next # returns 3
  #   gen.next # returns 4
  #   gen.next # returns 5
  #   gen.next # returns nil
  #
  def initialize(*pars, &block)
    @next_get = nil
    @next_it = nil
    @done = false
    @block = -> {
      block.call(self, *pars)
      @done = true
    }
  end

  def yield(value)
    @value = value
    callcc do |cc|
      @next_it = cc
      @next_get.call(value)
    end
  end

  def next
    return nil if @done
    callcc do |cc|
      @next_get = cc
      @next_it.nil? ? @block.call : @next_it.call
    end
  end

end

