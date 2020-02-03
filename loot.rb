require 'json'
require "./loot_table.rb"
require "./entry.rb"

class Util
def JSONtoHash
    file = File.read('loot_table_example.json')
    return JSON.parse(file)
end

def printHash(hash)
    hash.each do |i|
        puts i
    end
end

end

class Loot
    # Takes in a hash and initializes an array of LootTables
    def initialize(h)
        @Hash = h
        @LootTables = initializeTables
    end

    def initializeTables
        @LootTables = []
        @Hash.each {|x|  
            temp = LootTable.new(x)
            @LootTables.push(temp)
        }
        return @LootTables
    end

    def findTable(name)
        tables.each {|x|
            if x.name.eql? name
                return x
            end
        }
        return nil
    end

    def printTables
        puts @LootTables.inspect
    end

    # Get Function(s)
    def tables
        return @LootTables
    end

    def names
        names = []
        tables.each {|x|
            names.push(x.name)
        }
        return names
    end

end