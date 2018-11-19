require_relative "chordnode"
require_relative "node"

bit_amount = 3

chord = ChordNode.new
chord.add_node(node: Node.new(id: 0))
chord.add_node(node: Node.new(id: 1))
chord.add_node(node: Node.new(id: 3))
chord.add_node(node: Node.new(id: 6))
#chord.remove_node(id: 6)

chord.nodelist.each{ |node|
	puts node.printFingerTable
}
puts "-----------------------------------------"