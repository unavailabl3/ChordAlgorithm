class Node:
    def __init__(self, node_id: int):
        self.precessor = self
        self.node_id = node_id
        self.finger_table = {}
        self.bit_count = 8
        for i in range(1, self.bit_count + 1):
            self.finger_table[(node_id + 2 ** (i - 1)) % (2 ** self.bit_count)] = None
        self.successor = self

    @property
    def successor(self):
        first_elem_key = list(self.finger_table.keys())[0]
        return self.finger_table[first_elem_key]

    @successor.setter
    def successor(self, value):
        first_elem_key = list(self.finger_table.keys())[0]
        self.finger_table[first_elem_key] = value

    def __str__(self):
        return f'NodeId: {self.node_id} | FingerTable: {self.finger_table}'

    def __repr__(self):
        return f'ChordNode with id: {self.node_id}'



class ChordNode:
    def __init__(self):
        self.node_list = []
        self.bit_count = 8
        pass

    def get_first_node(self):
        return sorted(self.node_list, key=lambda x: x.node_id)[0] if len(self.node_list) > 0 else None

    def get_last_node(self):
        return sorted(self.node_list, key=lambda x: x.node_id)[-1] if len(self.node_list) > 0 else None

    def add_node(self, node: Node):
        if len(self.node_list) == 1:
            self.node_list[0].successor = node
            self.node_list[0].precessor = node
            node.successor = self.node_list[0]
            node.precessor = self.node_list[0]
        else:
            next_node: Node
            prev_node: Node
            next_node = next((x for x in self.node_list if x.node_id > node.node_id), None)
            if next_node is None:
                next_node = self.get_first_node()

            if next_node is not None:
                node.successor = next_node
                next_node.precessor = node

            prev_node = next((x for x in self.node_list if x.node_id < node.node_id), None)
            if prev_node is None:
                prev_node = self.get_last_node()

            if prev_node is not None:
                node.precessor = prev_node
                prev_node.successor = node

            for finger_table_key in node.precessor.finger_table.keys():
                if finger_table_key <= node.node_id:
                    node.precessor.finger_table[finger_table_key] = node

        self.node_list.append(node)
        for i in range(1, self.bit_count + 1):
            start = (node.node_id + 2 ** (i - 1)) % (2 ** self.bit_count)
            node.finger_table[start] = next((x for x in self.node_list if x.node_id >= start), self.node_list[0])

    def remove_node(self, node_id: int):
        node: Node
        node = next((x for x in self.node_list if x.node_id == node_id), None)
        if node is not None:
            node.successor.previous = node.precessor
            node.precessor.next = node.successor
            self.node_list.remove(node)
            for i in range(1, self.bit_count+1):
                start = (node.precessor.node_id + 2 ** (i - 1)) % (2 ** self.bit_count)
                node.precessor.finger_table[start] = next((x for x in self.node_list if x.node_id >= start),
                                                          self.node_list[0])

bit_count = 8

if __name__ == '__main__':
    ChordNode = ChordNode()
    ChordNode.add_node(Node(1))
    ChordNode.add_node(Node(3))
    # ChordNode.add_node(Node(5))
    # ChordNode.add_node(Node(4))
    # ChordNode.add_node(Node(6))
    #ChordNode.remove_node(3)
    for node in ChordNode.node_list:
        print(node)