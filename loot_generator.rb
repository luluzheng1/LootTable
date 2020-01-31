require 'json'

def JSONtoHash
    file = File.read('loot_table_example.json')
    hash = JSON.parse(file)
end

def printHash(hash)
    hash.each do |i|
        puts i
    end
end

$h = JSONtoHash()

#puts $h[2]["TableEntryCollection"]
#printHash($h)

class Loot
    # Takes in a hash and initializes an array of LootTables
    def initialize(h)
        @Hash = h
        @LootTables = initializeTables
    end

    def initializeTables
        @LootTables = []
        @Hash.each {|x|  
            @LootTables.push(LootTable.new(x)) 
        }
    end

    def tables
        return @LootTables
    end

    def printTables
        puts @LootTables.inspect
    end


end

class LootTable
    # Takes in a table hash object in h and Initializes a LootTable object
    def initialize(t)
        @TableType = t["TableType"]
        @TableName = t["TableName"]
        @TableEntryCollection = initialize_entries(t["TableEntryCollection"])
        # puts t.entries
    end

    # Initializes a set of TableEntrys for a LootTable object
    def initialize_entries(entries)
        @TableEntryCollection = []

        entries.each {|x|
            @TableEntryCollection.push(Entry.new(x))
        }
    end

    # Get Functions
    def type
        return @TableType
    end

    def name
        return @TableName
    end

    def entries
        return @TableEntryCollection
    end

    # def select_entry_random #NOT WORKING
    #     totalWeight = 0
    #     weight = []
    #     entries.each {|e|
    #         totalWeight += e.SelectionWeight
    #         weight.push(totalWeight)
    #     }

    #     randomNum = rand(totalWeight);
    #     weight.each {|w, index|
    #         if (randomNum < w)
    #             return entries[index]["EntryName"]
    #         end
    #     }
    # end
end

class Entry
    # Takes in an entry hash object and initializes an Entry object
    def initialize(e)
      @EntryType = e["EntryType"]
      @EntryName = e["EntryName"]
      @MinDrops = e["MinDrops"]
      @MaxDrops = e["MaxDrops"]
      @SelectionWeight = e["SelectionWeight"]
    end

    # Get Functions
    def weight
      return @SelectionWeight
    end

    def entry_type
      return @EntryType
    end
end

myLoot = Loot.new($h)
puts myLoot.tables[0].entries.inspect

# myLoot.printTables


