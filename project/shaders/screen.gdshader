shader_type spatial;

uniform sampler2D viewport_texture;
uniform float scale_factor; // Adjust this to shrink/stretch
uniform vec2 texture_size;
uniform vec2 viewport_size;

void fragment() {
    vec2 uv = vec2(UV.y,UV.x);
    uv = (uv - 0.5) * scale_factor+0.5;
	uv.x=1.0-uv.x;
	uv.x-=0.05;
    vec4 color = texture(viewport_texture, uv);
    ALBEDO = color.rgb;
}