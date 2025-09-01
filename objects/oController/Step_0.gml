dt = (delta_time / targetDt) / 1000000;

rotation += dt / 2;

main.matrix.rotation = matrix_build(0, 0, 0, rotation, 0, 0, 1, 1, 1);