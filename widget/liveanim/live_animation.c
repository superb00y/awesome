#include <cairo/cairo-xcb.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h> // For strlen()
#include <unistd.h>
#include <xcb/xcb.h>

#define WIDTH 200
#define HEIGHT 200

xcb_connection_t *connection;
xcb_screen_t *screen;
xcb_window_t window;
cairo_surface_t *surface;
cairo_t *cr;

xcb_visualtype_t *get_visualtype(xcb_screen_t *screen) {
  xcb_depth_iterator_t depth_iter = xcb_screen_allowed_depths_iterator(screen);

  for (; depth_iter.rem; xcb_depth_next(&depth_iter)) {
    xcb_visualtype_iterator_t visual_iter =
        xcb_depth_visuals_iterator(depth_iter.data);
    for (; visual_iter.rem; xcb_visualtype_next(&visual_iter)) {
      if (screen->root_visual == visual_iter.data->visual_id) {
        return visual_iter.data;
      }
    }
  }
  return NULL;
}

void draw_frame(double t) {
  cairo_set_source_rgb(cr, 1, 1, 1); // White background
  cairo_paint(cr);

  double x = WIDTH / 2 + 50 * cos(t);
  double y = HEIGHT / 2 + 50 * sin(t);
  double radius = 20;

  cairo_set_source_rgb(cr, 0, 0.5, 1); // Blue circle
  cairo_arc(cr, x, y, radius, 0, 2 * M_PI);
  cairo_fill(cr);

  cairo_surface_flush(surface);
  xcb_flush(connection);
}

void run_animation() {
  double t = 0.0;
  while (1) {
    draw_frame(t);
    t += 0.1;
    usleep(100000); // 10ms delay
  }
}

int main() {
  // Connect to X server
  connection = xcb_connect(NULL, NULL);
  if (xcb_connection_has_error(connection)) {
    fprintf(stderr, "Error: Cannot connect to X server\n");
    return -1;
  }

  // Get the first screen
  screen = xcb_setup_roots_iterator(xcb_get_setup(connection)).data;

  // Create a window
  window = xcb_generate_id(connection);
  uint32_t mask = XCB_CW_BACK_PIXEL | XCB_CW_EVENT_MASK;
  uint32_t values[2] = {screen->white_pixel, XCB_EVENT_MASK_EXPOSURE};
  xcb_create_window(connection, XCB_COPY_FROM_PARENT, window, screen->root, 0,
                    0, WIDTH, HEIGHT, 0, XCB_WINDOW_CLASS_INPUT_OUTPUT,
                    screen->root_visual, mask, values);

  // Set the window name
  const char *window_name = "Live Animation";
  xcb_change_property(connection, XCB_PROP_MODE_REPLACE, window,
                      XCB_ATOM_WM_NAME, XCB_ATOM_STRING, 8, strlen(window_name),
                      window_name);

  // Map the window (make it visible)
  xcb_map_window(connection, window);
  xcb_flush(connection);

  // Get the visual type for the screen
  xcb_visualtype_t *visual = get_visualtype(screen);
  if (!visual) {
    fprintf(stderr, "Error: Unable to find visual type\n");
    return -1;
  }

  // Create a Cairo surface
  surface = cairo_xcb_surface_create(connection, window, visual, WIDTH, HEIGHT);
  cr = cairo_create(surface);

  // Run animation
  run_animation();

  // Cleanup
  cairo_destroy(cr);
  cairo_surface_destroy(surface);
  xcb_disconnect(connection);
  return 0;
}
