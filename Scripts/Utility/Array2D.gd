class_name Array2D;
extends Resource;
## Array2D works the same as a triple nested array [[[]]] but is actually a 1D array

var values: Array[Variant];
var x_max: int;
var y_max: int;

## This defines the size of the 1D array
## This is useful to avoid errors when assigning to particular indices
func initialise_size(x_size: int, y_size: int) -> void:
	var array_size: int = x_size * y_size;
	x_max = x_size;
	y_max = y_size;

	values.resize(array_size);

## This takes the 2D coordinates and converts them to the relevant index in the 1D array
func get_index_from_coord(x: int, y: int) -> int:
	return y * x_max + x;

## This takes the 1D index and converts them to the relevant coordinates in the 2D array
func get_coord_from_index(index: int) -> Vector2:
	var x: int = int(float(index) / x_max);
	var y: int = int(index % x_max);
	return Vector2(y, x);

## Allows for setting a value at a particular coordinate
func set_value(x: int, y: int, value: Variant):
	if get_index_from_coord(x, y) < values.size():
		values[get_index_from_coord(x, y)] = value;

## Allows for setting a value at a particular index
func set_value_index(index: int, value: Variant):
	values[index] = value;

### Allows for getting a value at a particular coordinate
func get_value(x: int, y: int) -> Variant:
	return values[get_index_from_coord(x, y)];
	
## Allows for getting a value at a particular index
func get_value_index(index: int) -> Variant:
	return values[index];

## Check if the coordinate is within the area
func is_valid_coord(x: int, y: int) -> bool:
	return x >= 0 and x < x_max and y >= 0 and y < y_max;

## The below is a mirror of base Array functions so they can be called on the class directly rather than its child property
func size() -> int:
	return values.size();

func fill(value) -> void:
	values.fill(value);
	
func append(value) -> void:
	values.append(value);
	
func append_array(value) -> void:
	values.append_array(value);
