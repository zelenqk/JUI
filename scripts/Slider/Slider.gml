function Slider(properties = {}, knobStyle = {}, parent = undefined) constructor {
	self.properties = properties;

	background = get_default("background", #242424);

	width    = get_default("width", 10);
	height   = get_default("height", "100%");
	position = get_default("position", fixed);

	padding = get_default("padding", 2);
	align   = get_default("align", fa_right);

	create = function () {
		var inline = (efficient.width > efficient.height);

		axis  = inline ? "x" : "y";
		cross = inline ? "y" : "x";

		axisSize  = inline ? "width"  : "height";
		crossSize = inline ? "height" : "width";
	};

	// ──────────────────────────────────────────────────────────────

	knob = function (knobStyle, parent) constructor {
		self.properties = knobStyle;
		self.background = #f0f0f0;

		self[$ parent.axisSize]  = "100%";
		self[$ parent.crossSize] = "100%";

		sensitivity = get_default("sensitivity", 10);

		create = function () {
			sensitivity = properties.sensitivity;
			delta = { x: 0, y: 0 };
			holding = false;
		};

		step = function () {
			// ── Sizes ────────────────────────────────────────────────
			var viewportSize = parent.parent.realistic[$ parent.axisSize];
			var contentSize  = parent.parent.flex[$ parent.axisSize];
			var trackSize    = parent.realistic[$ parent.axisSize];

			if (contentSize <= 0) return;

			// Visible ratio (clamped)
			var visibleRatio = clamp(viewportSize / contentSize, 0, 1);
			scale[$ parent.axis] = visibleRatio;
			
			// Knob size
			var knobSize = trackSize * visibleRatio;
			self[$ parent.axisSize] = knobSize;

			// Movement ranges
			var knobRange    = trackSize - knobSize;
			var contentRange = contentSize - viewportSize;

			if (knobRange <= 0 || contentRange <= 0) {
				parent.parent.contentOffset[$ parent.axis] = 0;
				return;
			}

			// ── Mouse wheel scrolling ───────────────────────────────
			if (parent.parent.hovering(false)) {
				offset[$ parent.axis] +=
					(mouse_wheel_down() - mouse_wheel_up()) * sensitivity;
			}

			// ── Drag handling ───────────────────────────────────────
			if (!holding && hover()) {
				alpha = 0.75;

				if (device_mouse_check_button_pressed(mouse, mb_any)) {
					holding = true;

					delta[$ parent.axis] =
						(parent.axis == "x")
							? device_mouse_x_to_gui(mouse)
							: device_mouse_y_to_gui(mouse);
				}
			}

			if (holding) {
				if (device_mouse_check_button_released(mouse, mb_any)) {
					holding = false;
				} else {
					var mousePos =
						(parent.axis == "x")
							? device_mouse_x_to_gui(mouse)
							: device_mouse_y_to_gui(mouse);

					offset[$ parent.axis] += mousePos - delta[$ parent.axis];
					delta[$ parent.axis] = mousePos;
				}
			} else if (mouse == -1) {
				alpha = 1;
			}

			// ── Clamp knob movement ─────────────────────────────────
			offset[$ parent.axis] = clamp(offset[$ parent.axis], 0, knobRange);

			// ── Map knob → content ──────────────────────────────────
			parent.parent.contentOffset[$ parent.axis] =
				-(offset[$ parent.axis] / knobRange) * contentRange;
		};
	};

	// ──────────────────────────────────────────────────────────────

	holder = new container(self, parent);
	holder.add(new knob(knobStyle, holder));
}
