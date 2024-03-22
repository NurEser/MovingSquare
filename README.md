# MovingSquare

This project features a VGA driver developed using VHDL implemented on the FPGA, tasked with presenting an animated 50x50 pixel square on the display. The square is programmed to move continuously across the screen, reversing direction upon reaching any edge. In conjunction with its motion, the square undergoes color transitions to enhance visual tracking. Moreover, the driver is designed to modify the background color in response to the square's collisions with the screen edges, with each edge assigned a distinct color scheme. For instance, a collision with the right edge results in a purple backdrop. 


## Modules

### VSYNC-HSYNC

Inside these modules we have a variable named “count” that holds the current pixel position. For clarification, we will refer to them as hcount and vcount. When hcount is between 144 and 784, it means we are on the horizontal display area. Similarly, when vcount is between 31 and 511, we are on the vertical display area. When both of these values are in the display area range, colorgenerator is activated via a signal named “videoenable”.

### Color Generator

Colorgenerator takes as input the current position as x_pixel and y_pixel (hcount and vcount ,respectively) from the vsync and hsync modules. It takes the square position from “newsquareposition” and compares these values. This module is activated when we are on the display area via videoenable signal as was explained above. If the current pixel position lies between the square’s left-right and top-bottom values, then we are on the sqauare and that pixel is led according to the color value taken from the newsquareposition, otherwise it is background and the background color taken again from newsquareposition is assigned to the RGB values to be displayed.

### NewSquarePosition

“Newsquareposition”, updates the position of the square object each 8ms. For this, we used a different frequency divider called” slowfreqdivider”. This divider counts up to 833329, when this value is reached, newsquareposition is enabled and the position of the square is updated according to its ongoing direction value. Meanwhile, collision is checked to decide whether direction is to be updated. Background color and object color are also decided.






