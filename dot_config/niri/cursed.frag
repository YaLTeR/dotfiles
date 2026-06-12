#define BS 8

#define PI 3.141592654
#define NORM 0.7071067812


void FastDct8_transform(
	inout vec3 x0, inout vec3 x1, inout vec3 x2, inout vec3 x3,
	inout vec3 x4, inout vec3 x5, inout vec3 x6, inout vec3 x7
) {
	vec3 v0 = x0 + x7;
	vec3 v1 = x1 + x6;
	vec3 v2 = x2 + x5;
	vec3 v3 = x3 + x4;
	vec3 v4 = x3 - x4;
	vec3 v5 = x2 - x5;
	vec3 v6 = x1 - x6;
	vec3 v7 = x0 - x7;

	vec3 v8 = v0 + v3;
	vec3 v9 = v1 + v2;
	vec3 v10 = v1 - v2;
	vec3 v11 = v0 - v3;
	vec3 v12 = -v4 - v5;
	vec3 v13 = (v5 + v6) * 0.7071067811865475;
	vec3 v14 = v6 + v7;

	vec3 v15 = v8 + v9;
	vec3 v16 = v8 - v9;
	vec3 v17 = (v10 + v11) * 0.7071067811865475;
	vec3 v18 = (v12 + v14) * 0.3826834323650898;

	vec3 v19 = -v12 * 0.5411961001461970 - v18;
	vec3 v20 = v14 * 1.3065629648763766 - v18;

	vec3 v21 = v17 + v11;
	vec3 v22 = v11 - v17;
	vec3 v23 = v13 + v7;
	vec3 v24 = v7 - v13;

	vec3 v25 = v19 + v24;
	vec3 v26 = v23 + v20;
	vec3 v27 = v23 - v20;
	vec3 v28 = v24 - v19;

	x0 = 0.3535533905932738 * v15;
	x1 = 0.2548977895520796 * v26;
	x2 = 0.2705980500730985 * v21;
	x3 = 0.3006724434675226 * v28;
	x4 = 0.3535533905932738 * v16;
	x5 = 0.4499881115682079 * v25;
	x6 = 0.6532814824381883 * v22;
	x7 = 1.2814577238707531 * v27;
}

void FastDct8_inverseTransform(
	inout vec3 x0, inout vec3 x1, inout vec3 x2, inout vec3 x3,
	inout vec3 x4, inout vec3 x5, inout vec3 x6, inout vec3 x7
) {
	vec3 v15 = x0 * 2.8284271247461903;
	vec3 v26 = x1 * 3.9231411216129217;
	vec3 v21 = x2 * 3.6955181300451470;
	vec3 v28 = x3 * 3.3258784492101810;
	vec3 v16 = x4 * 2.8284271247461903;
	vec3 v25 = x5 * 2.2222809320784090;
	vec3 v22 = x6 * 1.5307337294603591;
	vec3 v27 = x7 * 0.7803612880645130;

	vec3 v19 = (v25 - v28) * 0.5;
	vec3 v20 = (v26 - v27) * 0.5;
	vec3 v23 = (v26 + v27) * 0.5;
	vec3 v24 = (v25 + v28) * 0.5;

	vec3 v7  = (v23 + v24) * 0.5;
	vec3 v11 = (v21 + v22) * 0.5;
	vec3 v13 = (v23 - v24) * 0.5;
	vec3 v17 = (v21 - v22) * 0.5;

	vec3 v8 = (v15 + v16) * 0.5;
	vec3 v9 = (v15 - v16) * 0.5;

	vec3 v18 = (v19 - v20) * 0.3826834323650898;

	// Original denominator is exactly -1 for these constants:
	// A2*A5 - A2*A4 - A4*A5 == -1
	vec3 v12 = v18 - v19 * 1.3065629648763766;
	vec3 v14 = v20 * 0.5411961001461970 - v18;

	vec3 v6 = v14 - v7;
	vec3 v5 = v13 * 1.4142135623730951 - v6;
	vec3 v4 = -v5 - v12;
	vec3 v10 = v17 * 1.4142135623730951 - v11;

	vec3 v0 = (v8 + v11) * 0.5;
	vec3 v1 = (v9 + v10) * 0.5;
	vec3 v2 = (v9 - v10) * 0.5;
	vec3 v3 = (v8 - v11) * 0.5;

	x0 = (v0 + v7) * 0.5;
	x1 = (v1 + v6) * 0.5;
	x2 = (v2 + v5) * 0.5;
	x3 = (v3 + v4) * 0.5;
	x4 = (v3 - v4) * 0.5;
	x5 = (v2 - v5) * 0.5;
	x6 = (v1 - v6) * 0.5;
	x7 = (v0 - v7) * 0.5;
}

void FastDct8_transformRow(inout vec3 table[64], int y) {
	int i = y * BS;
	FastDct8_transform(
		table[i + 0], table[i + 1], table[i + 2], table[i + 3],
		table[i + 4], table[i + 5], table[i + 6], table[i + 7]
	);
}

void FastDct8_inverseTransformRow(inout vec3 table[64], int y) {
	int i = y * BS;
	FastDct8_inverseTransform(
		table[i + 0], table[i + 1], table[i + 2], table[i + 3],
		table[i + 4], table[i + 5], table[i + 6], table[i + 7]
	);
}

void FastDct8_transformColumn(inout vec3 table[64], int x) {
	FastDct8_transform(
		table[0 * BS + x], table[1 * BS + x],
		table[2 * BS + x], table[3 * BS + x],
		table[4 * BS + x], table[5 * BS + x],
		table[6 * BS + x], table[7 * BS + x]
	);
}

void FastDct8_inverseTransformColumn(inout vec3 table[64], int x) {
	FastDct8_inverseTransform(
		table[0 * BS + x], table[1 * BS + x],
		table[2 * BS + x], table[3 * BS + x],
		table[4 * BS + x], table[5 * BS + x],
		table[6 * BS + x], table[7 * BS + x]
	);
}

const mat3 RGB_TO_YUV = mat3(
	vec3( 0.299000, -0.168736,  0.500000),
	vec3( 0.587000, -0.331264, -0.418688),
	vec3( 0.114000,  0.500000, -0.081312)
);

const mat3 YUV_TO_RGB = mat3(
	vec3(1.000000,  1.000000,  1.000000),
	vec3(0.000000, -0.344136,  1.772000),
	vec3(1.402000, -0.714136,  0.000000)
);

vec3 rgb_to_centered_yuv(vec3 rgb) {
	return RGB_TO_YUV * rgb - vec3(0.5, 0.0, 0.0);
}

vec3 centered_yuv_to_rgb(vec3 yuv) {
	// Equivalent to:
	// YUV_TO_RGB * (yuv + vec3(0.5, 0.0, 0.0))
	//
	// Since the Y column of YUV_TO_RGB is vec3(1), this folds to +0.5.
	return YUV_TO_RGB * yuv + vec3(0.5);
}

vec4 jpeg_luma_qm_row_a(int y) {
	if (y == 0) return vec4(16.0, 11.0, 10.0, 16.0);
	if (y == 1) return vec4(12.0, 12.0, 14.0, 19.0);
	if (y == 2) return vec4(14.0, 13.0, 16.0, 24.0);
	if (y == 3) return vec4(14.0, 17.0, 22.0, 29.0);
	if (y == 4) return vec4(18.0, 22.0, 37.0, 56.0);
	if (y == 5) return vec4(24.0, 35.0, 55.0, 64.0);
	if (y == 6) return vec4(49.0, 64.0, 78.0, 87.0);
	return vec4(72.0, 92.0, 95.0, 98.0);
}

vec4 jpeg_luma_qm_row_b(int y) {
	if (y == 0) return vec4(24.0, 40.0, 51.0, 61.0);
	if (y == 1) return vec4(26.0, 58.0, 60.0, 55.0);
	if (y == 2) return vec4(40.0, 57.0, 69.0, 56.0);
	if (y == 3) return vec4(51.0, 87.0, 80.0, 62.0);
	if (y == 4) return vec4(68.0, 109.0, 103.0, 77.0);
	if (y == 5) return vec4(81.0, 104.0, 113.0, 92.0);
	if (y == 6) return vec4(103.0, 121.0, 120.0, 101.0);
	return vec4(112.0, 100.0, 103.0, 99.0);
}

float component(vec4 v, int i) {
	if (i == 0) return v.x;
	if (i == 1) return v.y;
	if (i == 2) return v.z;
	return v.w;
}

float jpeg_luma_qm_base_xy(int x, int y) {
	return x < 4
		? component(jpeg_luma_qm_row_a(y), x)
		: component(jpeg_luma_qm_row_b(y), x - 4);
}

float jpeg_qm_xy(int x, int y, float S) {
	float q = (S * jpeg_luma_qm_base_xy(x, y) + 50.0) / 100.0;
	return max(q, 1.0) / 255.0;
}


            vec4 open_color(vec3 coords_geo, vec3 size_geo) {
                float pr = min(1.0, niri_clamped_progress * 5.0);
    // // Scale up the window.
    // float scale = max(0.0, (pr / 4.0 + 0.75));
    // coords_geo = vec3((coords_geo.xy - vec2(0.5)) / scale + vec2(0.5), 1.0);

                vec3 coords_tex = niri_geo_to_tex * coords_geo;
                vec4 color = texture2D(niri_tex, coords_tex.st);
                if (coords_geo.x < 0.0 || 1.0 < coords_geo.x || coords_geo.y < 0.0 || 1.0 < coords_geo.y)
                    return color;

                int Q = int(max(1.0, niri_clamped_progress * niri_clamped_progress * 70.0));
                float S = float(Q < 50 ? 5000 / Q : 200 - 2 * Q);

    ivec2 p = ivec2(coords_geo.xy * size_geo.xy);
    ivec2 block_ij = p / BS;
    ivec2 block_xy = block_ij * BS;
    ivec2 off_xy = p - block_xy;
    vec2 inv_size_geo = 1.0 / size_geo.xy;

// Texture-space coordinate for pixel center at block_xy + ivec2(0, 0).
vec3 tex_base3 = niri_geo_to_tex * vec3((vec2(block_xy) + vec2(0.5)) * inv_size_geo, 1.0);

// Texture-space delta for moving by +1 pixel in geometry x/y.
vec3 tex_dx3 = niri_geo_to_tex * vec3(inv_size_geo.x, 0.0, 0.0);
vec3 tex_dy3 = niri_geo_to_tex * vec3(0.0, inv_size_geo.y, 0.0);
    
    vec3 table[BS * BS];

for (int y = 0; y < BS; ++y) {
	vec3 tex3 = tex_base3 + float(y) * tex_dy3;

	for (int x = 0; x < BS; ++x) {
		vec3 rgb = texture2D(niri_tex, tex3.st).rgb;
		table[y * BS + x] = rgb_to_centered_yuv(rgb);

		tex3 += tex_dx3;
	}
}

	for (int y = 0; y < BS; ++y)
		FastDct8_transformRow(table, y);

	for (int x = 0; x < BS; ++x)
		FastDct8_transformColumn(table, x);

	for (int y = 0; y < BS; ++y) {
		for (int x = 0; x < BS; ++x) {
			int idx = y * BS + x;

            float q = jpeg_qm_xy(x, y, S);
            table[idx] = vec3(ivec3(table[idx] / q + 0.5)) * q;
			// if (x < 3 && y < 3)
			//     table[idx] = vec3(ivec3(table[idx] / qm[y][x] + 0.5)) * qm[y][x];
			// else
			// 	table[idx] = vec3(0.0);
		}
	}

	for (int x = 0; x < BS; ++x)
		FastDct8_inverseTransformColumn(table, x);

	for (int y = 0; y < BS; ++y)
		FastDct8_inverseTransformRow(table, y);


    vec3 rgb = centered_yuv_to_rgb(table[off_xy.y * BS + off_xy.x]);
    color = vec4(rgb, color.a);

                // color = vec4(coords_geo.xy, 0.0, 1.0);

                return color * pr;
            }
