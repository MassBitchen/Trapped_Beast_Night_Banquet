shader_type canvas_item;

uniform float vignette_intensity : hint_range(0.0, 5.0) = 0.7;
uniform float vignette_opacity : hint_range(0.0, 1.0) = 0.8;
uniform vec4 vignette_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float corner_radius : hint_range(0.0, 1.0) = 0.5;
uniform float edge_softness : hint_range(0.0, 0.2) = 0.05; // 控制边缘软化程度

void fragment() {
    // 计算当前像素到中心的距离
    vec2 uv = UV - 0.5;

    // 使用power函数来调整四角的弧度
    float dist = pow(abs(uv.x), 2.0 / corner_radius) + pow(abs(uv.y), 2.0 / corner_radius);
    dist = pow(dist, corner_radius);

    // 创建带有少量过渡的边界效果
    float threshold = 0.3;
    float vignette = smoothstep(threshold - edge_softness, threshold + edge_softness, dist * vignette_intensity);

    // 应用颜色
    COLOR = vec4(vignette_color.rgb, vignette * vignette_opacity);
}