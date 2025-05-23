shader_type spatial;
render_mode cull_front, unshaded;

uniform float outline_size : hint_range(0.0, 0.2) = 0.05;
uniform float pulse_speed : hint_range(0.0, 10.0) = 1.0;

void vertex() {
    VERTEX += NORMAL * outline_size;
}

void fragment() {
    float t = TIME * pulse_speed;

    // Cycle hue over time (uses sin() for smooth transitions)
    vec3 color = vec3(
        0.5 + 0.5 * sin(t),
        0.5 + 0.5 * sin(t + 2.0),
        0.5 + 0.5 * sin(t + 4.0)
    );

    ALBEDO = color;
}
