require "./loot_generator.rb"

# Read data from JSON file
# Initialize Loot object
u = Util.new
$h = u.JSONtoHash
myLoot = Loot.new($h)

# Get user input
input = gets.chomp
puts input + "World"