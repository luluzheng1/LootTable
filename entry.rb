class Entry
    # Take in an entry hash object and initialize an Entry object
    def initialize(e)
        @EntryType = e["EntryType"]
        @EntryName = e["EntryName"]
        @MinDrops = e["MinDrops"]
        @MaxDrops = e["MaxDrops"]
        @SelectionWeight = e["SelectionWeight"]
    end

    # Teturn a random number between MinDrops and Max Drops
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