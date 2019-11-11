require 'ruby_gen'

describe RubyGen do
  it 'yields proper results' do
    gen = RubyGen.new(3, 5) do |context, x, y|
      (x..y).each do |i|
        context.yield(i)
      end
    end

    expect(gen.next).to eq(3)
    expect(gen.next).to eq(4)
    expect(gen.next).to eq(5)

    expect do
      gen.next
    end.to raise_exception(StopIteration)
  end

  it 'works with non-looped constructs' do
    gen = RubyGen.new do |context|
      context.yield('hello')
      context.yield('Ruby')
      context.yield('!')
    end

    expect(gen.next).to eq('hello')
    expect(gen.next).to eq('Ruby')
    expect(gen.next).to eq('!')
  end

  it 'works in the example in the README' do
    gen = RubyGen.new(1) do |context, start|
      i = start
      loop do
        context.yield(i)
        i += 1
      end
    end

    expect(gen.next).to eq(1)
    expect(gen.next).to eq(2)
    expect(gen.next).to eq(3)
    expect(gen.next).to eq(4)
    # by induction... ;-)

  end
end