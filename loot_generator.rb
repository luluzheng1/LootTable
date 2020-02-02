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
    end

    # Initializes a set of TableEntrys for a LootTable object
    def initialize_entries(e)
        @TableEntryCollection = []

        e.each {|x|
            temp = Entry.new(x)
            @TableEntryCollection.push(temp)
        }
        return @TableEntryCollection
    end

    # Get Functions
    def type
        @TableType
    end

    def name
        @TableName
    end

    def get_entries
        @TableEntryCollection
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
p myLoot.tables.first.get_entries.first.weight
# myLoot.printTables


