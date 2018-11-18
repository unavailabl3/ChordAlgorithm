require_relative "chordnode"
require_relative "node"
require 'json'

bit_amount = 3

chord = ChordNode.new
chord.add_node(node: Node.new(id: 1))
chord.add_node(node: Node.new(id: 3))
#chord.add_node(node: Node.new(id: 5))
#chord.add_node(node: Node.new(id: 4))
#chord.add_node(node: Node.new(id: 6))
#chord.remove_node(id: 3)

chord.nodelist.each{ |node|
	puts node.printFingerTable
}
