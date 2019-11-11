# RubyGen

Python-style generators in Ruby using call/cc. Generators are akin to interruptible computations which can choose to yield control at the desired point in time,
only to be resumed later. Every time a generator yields control, it can return a value. It therefore "generates"
values from a computation as it goes:

```{ruby}
# An infinite enumeration.
gen = RubyGen.new(1) do |context, start|
  i = start
  loop do
    context.yield(i)
    i += 1
  end
end

# prints 1
puts gen.next
# prints 2
puts gen.next
# prints 3
puts gen.next
# goes on forever...
```

This has been done for my learning/amusement, and to whomever may be looking
for an example of how to implement Python-style generators using continuations. 
