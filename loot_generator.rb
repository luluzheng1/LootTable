require 'json'

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

        if !name.nil?
            raise "Table " + name + "does not exist"
        end
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

    # Select an entry from a loot table
    # Returns the entry object
    def select_entry
        totalWeight = 0
        weightArray = []
        
        entries.each {|e|
            totalWeight += e.weight
            weightArray.push(totalWeight)
        }

        randomNum = rand(0..totalWeight);

        weightArray.each_with_index {|w, i|
            if randomNum <= w
                return entries[i]
            end
        }
    end

    # Returns an array of entries that are tables
    def entriesAreTable(tablenames)
        tables = []
        entrynames.each { |x|
            if tablenames.include? x
                tables.push(x)
            end
        }
        return tables
    end

    # Performs loot drop for Random loot table
    def random(tablenames, num_drop)
        dropSet = Hash.new
        tables = entriesAreTable(tablenames)
        h = Hash.new
        while num_drop > 0
            curr_entry = select_entry
            curr_name = curr_entry.name
            amount = curr_entry.select_amount

            # If in hash, update value
            # Otherwise add to hash
            if dropSet.key?(curr_name)
                # puts "Adding to " + curr_name
                dropSet[curr_name] += amount
            else
                # puts "Inserting " + curr_name
                dropSet[curr_name] = amount
            end
            # puts "Dropped " + curr_entry.select_amount.to_s + " " + curr_entry.name
            num_drop -= 1
        end 

        dropSet.each {|name, amount| 
                # if entry is a table do not print to stdout
                if tables.include? name
                    h[name] = amount
                else
                    puts "Dropped #{amount} #{name}"
                end
            }
       return h
    end

    # Performs loot drop for UniqueRandom loot table
    # Raises error when selecting after all entries
    # have been selected
    def uniquerandom(tablenames, num_drop)
        temp = [] #keeps track of uniqueness
        exhausted = false
        h = Hash.new

        while num_drop > 0
            if exhausted
                puts "Entries all exhausted, no more loot could be dropped" 
                break
            end

            curr_entry = select_entry
            curr_name = curr_entry.name
            amount = curr_entry.select_amount

            if (!temp.include? curr_entry)
                if tablenames.include? curr_name
                    if h.key? curr_name
                        h[curr_name] += amount
                    else
                        h[curr_name] = amount
                    end
                else
                    puts "Dropped " + curr_entry.select_amount.to_s + " " + curr_entry.name
                end
                temp.push(curr_entry)
                num_drop -= 1
            end

            exhausted = entries.length.eql? temp.length
        end
        
        return h
    end

    # Get Functions
    def type
        @TableType
    end

    def name
        @TableName
    end

    def entries
        @TableEntryCollection
    end

    def entrynames
        names = []
        entries.each {|x|
            names.push(x.name)
        }
        return names
    end

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

    # Generates a random amount between MinDrops and MaxDrops
    def select_amount
        amount = rand(min..max)
        return amount
    end

    # Get Functions
    def weight
        return @SelectionWeight
    end

    def type
        return @EntryType
    end

    def name
        return @EntryName
    end

    def min
        return @MinDrops
    end

    def max
        return @MaxDrops
    end

end

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