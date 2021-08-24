require 'rspec'

NUMBEROFDICES = 2
ALLOWEDSIDES = [6, 8, 20]

class Die
	attr_accessor :sides

	def initialize(sides)
		@sides = sides.to_i
	end

	def name
		@sides.to_s + " side Die"
	end

	def roll
		rand(@sides) + 1
	end
end


class ComboDie
	def initialize(args)
		@dices = []
		args[0].to_i.times { |i|
			@dices << Die.new(args[i.to_i + 1]) if args[i.to_i + 1]
		}
	end

	def throw_all
		results = []
		# total = []
		for i in @dices
			# count = i.roll
			# total << count
			# results << [i.name ,  "result in " , count ].join(' ')
			results << i.roll
		end
		results << results.sum
	end

end


# c =  ComboDie.new([3 , 6, 6, 8])
# puts c.throw_all

sides = []
number_of_dices = 0
loop do
	print "Enter number of dices (allowed 1 or 2): "
	number_of_dices = gets().chomp().to_i
	break if(number_of_dices != 0 && number_of_dices <= NUMBEROFDICES )
end
sides << number_of_dices

loop do
	print "Enter sides of #{sides.length} die (allowed #{ALLOWEDSIDES}): "
	side = gets().chomp().to_i 
	sides << side if ALLOWEDSIDES.include?(side)
	break if (sides.length == sides[0] + 1)
end


c =  ComboDie.new(sides)
p c.throw_all


describe Die do 

    context "when testing the 2 dices" do 
    	c1 =  ComboDie.new([2 , 8, 8])
		message1 =  c1.throw_all
        it "should be be_between" do 
	        expect(message1[0]).to be_between(1, 8)
	        expect(message1[1]).to be_between(1, 8)
	        expect(message1.last).to be_between(1, 16)
        end
        it "should not be be_between" do 
	        expect(message1.last).not_to be(0)
        end
    end

    context "when testing the 1 die" do 
    	c2 =  ComboDie.new([1, 6])
		message2 =  c2.throw_all
        it "should be be_between" do 
	        expect(message2.first).to be_between(1, 6)
	        expect(message2.last).to be_between(1, 6)
        end
        it "should not be be_between" do 
	        expect(message2.last).not_to be(0)
        end
    end

end