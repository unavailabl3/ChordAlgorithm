class Node
	attr_reader :nodeid
	attr_reader :precessor
	attr_reader :successor
	attr_reader :fingertable

	def initialize(id: 1, bit_amount: 8)
		@precessor = self
		@successor = self
		@nodeid = id
		@fingertable = {}
		@bit_amount = bit_amount
		(1..@bit_amount+1).each{ |i|
			@fingertable[(@nodeid + 2 ** (i - 1)) % (2 ** @bit_amount)] = nil
		}
	end

    def successor
        firstkey = @fingertable.keys[0]
        return @fingertable[firstkey]
    end

	def precessor=(value)
        @precessor = value
    end    

    def successor=(value)
        firstkey = @fingertable.keys[0]
        @fingertable[firstkey] = value
    end

    def to_s
        return "NodeId : #{@nodeid}, FingerTable : #{@fingertable}"
    end

    def repr
        return "ChordNode with id: #{@nodeid}"		
    end
end