class_name Queue 

var queue_elements = [];

# Method for adding an element to the back of the queue
func push_back(element):
	# Add the element to the list of queue elements
	queue_elements.append(element)

# Method for removing an element from the front of the queue
func pop_front():
	# Get the first element in the queue
	var element = queue_elements[0]
	
	# Remove the element from the queue
	queue_elements.remove(0)
	
	# Return the element
	return element

# Method for getting the size of the queue
func size():
	# Return the size of the queue
	return queue_elements.size()
