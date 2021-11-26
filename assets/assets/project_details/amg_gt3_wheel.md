# Abstract

At the time of this build, my interest in sim racing was at its peak and I wanted to enhance the experience to make it feel even more realistic. If you step out of the road car world and into the racing world, you may notice that race cars have all shapes and sizes of steering wheels. With the introduction of sim racing, getting behind the wheel of a plethora of cars has never been easier. While sim racing may provide an immersive and realistic experience, it can sometimes be hindered by the physical equipment you use. Driving certain cars can sometimes just feel plain wrong and out of place without the right setup, especially when using the wrong steering wheel. Because of this, I wanted to expand my racing wheel collection to more than just having one circular wheel. 

While there were many wheels out on the market that I could purchase, they were all very expensive, ranging from $130USD to some costing way over $500USD. I was not willing to invest that much money into enhancing the experience, especially since I knew I could design and build the wheel myself. So, that's exactly what I decided to do. My wheel of choice,  the Mercedez Benz AMG GT3 steering wheel. I love the GT3 class racing and my favorite car, even to this day, has always been the Mercedez Benz AMG GT3. The steering wheel, to me, is one of the most simplistic yet beautifully designed racing wheels in its class.

Mercedes-AMG GT3 GT | AMG GT3 Steering Wheel   
--- | ---
![AMG GT3 Car](resource:assets/images/projects/amg_gt3_wheel/extra_1.png)  |  ![AMG GT3 Racing Wheel](resource:assets/images/projects/amg_gt3_wheel/extra_2.png)

Images by The Drive: https://www.thedrive.com/accelerator/18779/you-can-live-out-your-race-car-dreams-with-this-mercedes-benz-amg-gt3

---

# Objective

To design and build a 3D printable version of the Mercedes Benz AMG GT3 steering wheel. Not only should it resemble the actual wheel, but it also needed to be functional and compatible with my Thrustmaster sim racing rig. 

---

# General Procedure

### Research and Planning

The first step involved was to do as much research as possible to determine if the project was even viable. To accomplish the objective, there needed to be some way to attach the steering wheel to the wheelbase and allow it to read the buttons that would be integrated into the wheel. Since there were a couple of companies/hobbyists that were making steering wheels compatible with the Thrustmaster ecosystem, I knew that this problem had to have already been solved. While Thrustmaster may be using their proprietary circuit boards in their wheels, the connector and communication protocol used to attach a steering wheel to the wheelbase were both standard methods (a 6 pin mini din connector and SPI serial protocol). During this research phase, I stumbled upon an article [Hacking a Thrustmaster TX RW gaming wheel with Arduino Uno](https://rr-m.org/blog/hacking-a-thrustmaster-tx-rw-gaming-wheel-with-arduino-uno-part-1/) written by Taras Ivaniukovich on his website. The article was split into multiple parts where he explained, in detail, how he opened a Thrustmaster TX Racing wheel and used an Arduino Uno to mimic the functionality of the wheel's internal circuit board. He also explained how to wire up the connector to the Arduino and even provided the code to be used on the Arduino. This meant that the largest hurdle of the project was already solved and that there was nothing else that could stop me from moving forward.

Now that I knew for sure the project was viable, the next step was to determine all the materials and equipment that I would need to complete the project. Since I wanted the project to be relatively low on budget, I couldn't be spending too much money buying expensive parts and equipment. I wanted to use as many resources I had at my disposal and only make purchases for things I knew I could potentially use in future projects. 3D printing was the method I wanted to use to create the wheel since it would allow me to print most of the parts without having to purchase them or having them manufactured elsewhere. I also wanted the project to be easily re-creatable in case I wanted to make multiple. The main things I needed to purchase were buttons, switches, joysticks, connectors, vinyl wrap, screws, and a heat gun.

### Design

After the research and planning phase, the steering wheel was designed in Adobe Photoshop and Adobe Illustrator. To do this, reference images and dimensions of the real steering wheels found on Google were used. The design was modified to accommodate the buttons,  joystick, and size limitations of the 3D printer. The SVG file (outline of the wheel) was then exported from Adobe Illustrator and imported into the CAD design software Autodesk Fusion 360. This was the most complex model I had ever designed using Fusion 360, and it took multiple cycles of designing, printing, and testing, to find the best-looking design that maintained proper structural integrity while also feeling comfortable to use.

Adobe Photoshop Design | Fusion 360 Design Render (View 1)  
--- | ---
![Photoshop Design](resource:assets/images/projects/amg_gt3_wheel/render_1.png)  |  ![Fusion 360 Render](resource:assets/images/projects/amg_gt3_wheel/render_2.png)

Fusion 360 Design Render (View 2) | Printed Model (Testing Layout/Fitment)
--- | ---
![Fusion 360 Render 2](resource:assets/images/projects/amg_gt3_wheel/render_3.png)  |  ![Printed Model](resource:assets/images/projects/amg_gt3_wheel/fitment_1.png)

### Assembly

With all the final parts printed using my personal Ender 3 3D printer, the wheel was assembled and tested on the wheelbase without the electronics. This was done for testing the structural integrity of the wheel since the wheelbase provides force feedback with about 3.9Nm of torque. 

After a few broken parts, the print settings were dialed in and the structural integrity was improved by primarily using slower print speeds and higher infill density. 

Wheel Assembled (Buttons not wired) | Wheel connected to the wheelbase
--- | ---
![Assembled Wheel](resource:assets/images/projects/amg_gt3_wheel/assembly_1.png)  |  ![Wheel on wheelbase](resource:assets/images/projects/amg_gt3_wheel/assembly_2.png)

### Styling

The next step after assembling the wheel was to style it. While the wheel may function and feel fine, it needs to look the part. The final finish of 3D printed parts can sometimes look raw and unfinished. To make the wheel look more appealing and authentic, it was wrapped in vinyl. The front plate of the wheel was wrapped in a carbon fiber style vinyl with accents added around the buttons. The button accents were cut using a vinyl cutter I had access to when I was volunteering at my local FabLab. The handles were wrapped in a leather-style vinyl but were later replaced for something more comfortable. 

After a couple of days of use, it was obvious that the handle design was not good. Although they were thick and the corners were rounded, the handles would still fatigue your hands after a couple of laps of intense racing. I decided to redesign the handles with a new bevel shape since I was still unable to make them fully round and tested using a spray-on rubber as well as a bicycle handle tape. The bicycle handle tape felt perfect, as it would provide the best amount of cushion and thickness to the handles.

Wrapping in progress | Wrapped completed
--- | ---
![Assembled Wheel](resource:assets/images/projects/amg_gt3_wheel/wrap_1.png)  |  ![Wheel on wheelbase](resource:assets/images/projects/amg_gt3_wheel/wrap_2.png)

Handles with bicycle tape vs spray-on rubber | Both handles wrapped in bicycle handle tape
--- | ---
![Assembled Wheel](resource:assets/images/projects/amg_gt3_wheel/handles_1.png)  |  ![Wheel on wheelbase](resource:assets/images/projects/amg_gt3_wheel/handles_2.png)

### Wiring/Circuitry

Once the wheel was fully assembled and survived the structural integrity tests, the electronics were added. This was done by using an Arduino Nano wired to the input switches (paddle shifters) and mini-din connector on the rear of the wheel, along with the buttons and joystick on the front side of the wheel. The code compiled on the Arduino was obtained from the article mentioned earlier. However, it was modified to work with the PSP joystick instead of using a directional pad for navigating the menus. I specifically chose this joystick as it is low profile, which would help allow the wheel to look a little more authentic. I have also never seen this joystick used by any other wheel on the market, so I thought it would make it stand out slightly. 

After a couple of months of using the wheel, some of the wires got loosened with the movements and the buttons would therefore not work. Because of this, I went back to revise the circuit board design and decided to attempt designing and manufacturing my first PCB. This was a very simple PCB to design as there was no need for SMD components on the board and it simply needed connectors for connecting the buttons, joystick, switches, and mini-din connector. This design helped to minimize the wiring in the wheel substantially, making it more reliable and more organized.

Back case of the wheel wired | Arduino wired to buttons and joystick
--- | ---
![Assembled Wheel](resource:assets/images/projects/amg_gt3_wheel/wiring_1.png)  |  ![Wheel on wheelbase](resource:assets/images/projects/amg_gt3_wheel/wiring_2.png)

Old vs new circuit board | New circuit board installed
--- | ---
![Assembled Wheel](resource:assets/images/projects/amg_gt3_wheel/circuit_1.png)  |  ![Wheel on wheelbase](resource:assets/images/projects/amg_gt3_wheel/circuit_2.png)

---
 
# Results


---

# Conclusion
---
