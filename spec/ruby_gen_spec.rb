require 'ruby_gen'

describe RubyGen do
  context 'when condition' do
    it 'succeeds' do
      gen = RubyGen.new(3, 5) do |context, x, y|
        (x..y).each do |i|
          context.yield(i)
        end
      end

      expect(gen.next).to eq(3)
      expect(gen.next).to eq(4)
      expect(gen.next).to eq(5)
    end
  end
end