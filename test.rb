hash = Hash.new
hash = {:two => 2, :three => 3}
# temp = hash[:two]
if hash.key?(:two)
	puts "hi"
end
hash[:two] += 3
hash.each do |name, number|
	puts "#{name}  #{number}"
end