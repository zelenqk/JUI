function int_to_bytes(val) {	//another gpt function
	var bytes = [];
	
	// Extract each byte
	array_push(bytes, ((val >> 24) & 0xFF) / 255); // Byte 0 (red)
	array_push(bytes, ((val >> 16) & 0xFF) / 255); // Byte 1 (green)
	array_push(bytes, ((val >> 8) & 0xFF) / 255);  // Byte 2 (blue)
	array_push(bytes, (val & 0xFF) / 255);         // Byte 3 (alpha)
	
	return bytes;
}