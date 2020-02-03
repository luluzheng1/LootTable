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
    # Take in a hash and initialize a Loot object
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

    # Take in a name (string) and returns a LootTable object of that name 
    # if there exists one, otherwise return nil.
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

    # Return an array of the names of all LootTable objects in Loot
    def names
        names = []
        tables.each {|x|
            names.push(x.name)
        }
        return names
    end

end