class ChordNode
	attr_reader :nodelist

	def initialize(bit_amount: 3)
		@bit_amount = bit_amount
		@nodelist = []
	end

	def get_first_node
        return (@nodelist.sort_by {|node| node.nodeid})[0] if (@nodelist.size > 0)
    	return nil
    end

	def get_last_node
        return (@nodelist.sort_by {|node| node.nodeid})[-1] if (@nodelist.size > 0)
    	return nil
    end

    def stabilize
    	for nd in @nodelist
    		for key in nd.fingertable.keys
    			for next_nd in @nodelist
    				if next_nd.nodeid >= key
    					nd.fingertable[key] = next_nd
    					break
    				end
    				nd.fingertable[key] = @nodelist[0]
    			end
    		end
    	end
    end

    def add_node(node: nil)
    	if @nodelist.size == 1
    		@nodelist[0].successor = node
			@nodelist[0].precessor = node
            node.successor = @nodelist[0]
            node.precessor = @nodelist[0]    		
    	else  
    		next_node = nil
    		for nd in @nodelist
    			if nd.nodeid > node.nodeid
    				next_node = nd
    				break
    			end
    		end
    		if next_node == nil
                next_node = self.get_first_node()
            end
            if next_node != nil
                node.successor = next_node

            	next_node.precessor = node
            end

            prev_node = nil
			for nd in @nodelist.reverse
    			if nd.nodeid < node.nodeid
    				prev_node = nd
    				break
    			end
    		end            
    		if prev_node == nil
                prev_node = self.get_last_node()
            else
                node.precessor = prev_node
                prev_node.successor = node
            end
    	end
    	@nodelist.push(node)
		for i in (1..@bit_amount+1)
            start = (node.nodeid + 2 ** (i - 1)) % (2 ** @bit_amount)
			node.fingertable[start] = @nodelist[0]
			for nd in @nodelist
    			if nd.nodeid >= start
    				node.fingertable[start] = nd
    				break
    			end
    		end
        end
        self.stabilize()
    end

    def remove_node(id: nil)
	    node = nil
		for nd in @nodelist
    		if nd.nodeid == id
    			node = nd
    			break
    		end
    	end
	    if node != nil
	        node.successor.precessor = node.precessor
	        node.precessor.successor = node.successor
	        @node_list = @nodelist.delete(node)
	        for i in (1..@bit_amount+1)
	            start = (node.precessor.nodeid + 2 ** (i - 1)) % (2 ** @bit_amount)
	            node.precessor.fingertable[start] = @nodelist[0]
				for nd in @nodelist
    				if nd.nodeid >= start
    					node.precessor.fingertable[start] = nd
    					break
    				end
    			end
    		end
    	end
    	self.stabilize()
    end
end