main.draw();

main.matrix.rotation = matrix_build(0, 0, 0, rotation, 0, 0, 1, 1, 1);


draw_text(0, main.target.height, fps);
