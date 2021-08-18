require 'rspec'

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
		total = []
		for i in @dices
			count = i.roll
			total << count
			results << [i.name ,  "result in " , count ].join(' ')
		end
		results << "total = #{total.sum}"
	end

end



# c =  ComboDie.new([4 , 6, 6])
# puts c.throw_all

sides = []
print "Enter number of dices"
number_of_dices = gets().chomp().to_i
sides << number_of_dices
number_of_dices.times.each do |i|
	print "Enter sides of #{i+1} die"
	sides << gets().chomp().to_i
end

c =  ComboDie.new(sides)
puts c.throw_all






describe Die do 
    context "when testing the Die class" do 
      
        it "should be be_between" do 
	        d1 = Die.new(6) 
	        message = d1.roll
	        expect(message).to be_between(0, 6).inclusive
        end
      
        it "should not be be_between" do 
	        d2 = Die.new(6) 
	        message = d2.roll
	        expect(message).not_to be_between(7, 100).exclusive
        end

   end
end