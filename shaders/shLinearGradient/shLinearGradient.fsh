// Shader inputs
uniform float u_angle;              // Gradient direction in radians
uniform int u_stopCount;            // Number of stops (<= 8)
uniform float u_factors[8];         // Stop positions (0.0 → 1.0)
uniform vec4 u_colors[8];           // RGBA colors (already normalized 0.0 → 1.0)

// Get gradient color by interpolating between stops
vec4 getGradientColor(float t) {
	if (u_stopCount == 1) {
		return u_colors[0];
	}

	// If before first stop
	if (t <= u_factors[0]) {
		return u_colors[0];
	}

	// If after last stop
	if (t >= u_factors[u_stopCount - 1]) {
		return u_colors[u_stopCount - 1];
	}

	// Find the two stops to interpolate between
	for (int i = 0; i < u_stopCount - 1; i++) {
		float f1 = u_factors[i];
		float f2 = u_factors[i + 1];

		if (t >= f1 && t <= f2) {
			float f = (t - f1) / (f2 - f1);
			return mix(u_colors[i], u_colors[i + 1], f);
		}
	}

	// Fallback (shouldn't happen)
	return vec4(1.0, 1.0, 1.0, 1.0);
}

void main() {
	// Rotate UV based on angle
	float s = sin(u_angle);
	float c = cos(u_angle);
	vec2 dir = vec2(c, s);
	float t = dot(gl_FragCoord, dir);

	// Get final color
	gl_FragColor = getGradientColor(t);
}
