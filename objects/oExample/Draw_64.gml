main.draw();

draw_set_colour(c_black);
draw_text(0, 0, fps);

draw_rectangle_color(0, 0, GUIW, GUIH, c_black, c_black, c_black, c_black, false);
stencil.draw(0, 0);