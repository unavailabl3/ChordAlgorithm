class Node
	attr_reader :nodeid
	attr_reader :precessor
	attr_reader :successor
	attr_reader :fingertable

	def initialize(id: 1, bit_amount: 3)
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
    	@successor = value
        firstkey = @fingertable.keys[0]
        @fingertable[firstkey] = value
    end

    def printFingerTable
    	output = "NodeId : #{@nodeid}, FingerTable:\n"
    	output += "|start|interval| nodeid |\n"
    	keys = @fingertable.keys
    	for key, nd in @fingertable
    		break if keys.size == 1
    		keys = keys-[keys[0]]
    		output += "|  #{key}  |  [#{key},#{keys[0]}) |   #{nd.nodeid}    |\n"
    	end
        return output
    end
=begin
    def printFingerTable
        return "NodeId : #{@nodeid},Precessor:#{@precessor.nodeid}, Successor:#{@successor.nodeid}, FingerTable : #{JSON.generate(@fingertable)}"
    end

    def to_s
        return "ChordNode with id=#{@nodeid}"		
    end
=end
end