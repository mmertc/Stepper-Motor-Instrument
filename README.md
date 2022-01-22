# Stepper-Motor-Instrument
An instrument that plays MIDI files using stepper motors.

&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

# How Does It Work


The theory behind playing the notes using stepper motors is that they vibrate, and thus, produce the note at the frequency that they are stepping at. So essentially what the design does to play notes is stepping a motor at the frequency of the note that needs to be played at that time instant. 
A4988 stepper motor drives are used in the design to control the motors. Also a 5V-3.3V logic converter is used since the drivers use 5V high while BASYS3 uses 3.3V high. 1N138 optical isolator is also used in a receiver circuit to read the incoming packets from the MIDI cable and decreasing them to 3.3V in the process. 

MIDI has many different packets but the design makes use of only 2 particular ones: Note On and Note Off. They are 3 bytes long each and in the form of: 1001CCCC 0NNNNNNN 0VVVVVVV and 1000CCCC 0NNNNNNN 0VVVVVVV respectively. Here Cs denotes the channel, i.e. for which instrument this command is intended, which is in this case which motor, Ns denote the note number and Vs denote the velocity of the note, i.e. loudness. As the design has no use for the velocity, it only looks for the first 2 bytes of these commands.

 ![a](https://user-images.githubusercontent.com/98234434/150654531-4562a342-6f59-47f0-b334-4e5ad5a2dda5.png)
                                                            *Figure1: The schematic of the FPGA design.*

The FPGA design first has a UART receiver module that receives the packets sent from the computer. Then the packet shifter module sticks the two consecutive packets together to assemble a possible command. Then the command executer module checks if the possible command is valid, and if it is then it executes it by writing into the register of the related motor controller module.


 ![b](https://user-images.githubusercontent.com/98234434/150654532-6f9eb0ef-ff45-4433-8b76-cf08796c8443.png)
                                                       *Figure2: The submodules of the motor controller module.*

Each motor controller module has an 8 bit register that stores the number of the note that the motor needs to be playing at that time. Then the LUT produces the integer that needs to divide the BASYS3’s clock frequency, i.e. 100MHZ, to generate the frequency of the note that needs to be played at that instant. And the square wave generator module generates a square wave with that frequency. And finally all the motor controller outputs are connected to the step pins of the A4988 drivers.

# Some Example Pieces

[Tetris Main Theme](https://drive.google.com/file/d/12z67MSqN0MBoHgMRjJ63SJT2uN7FVeo-/view?usp=sharing)

[Turkish March](https://drive.google.com/file/d/12p4od7fqtwUkc7s8LXOtwIRg9ugmlN_u/view?usp=sharing)

[Flight of the Bumblebee](https://drive.google.com/file/d/12lnXPESC-eqdMB-Z62UgkS5ee60mwVRz/view?usp=sharing)

[Rachmaninoff: Piano concerto No. 2 in C Minor, Op. 18: I. Moderato](https://drive.google.com/file/d/12yM_-F1ln2KMe6i1MxQvevgEpnOEFfw3/view?usp=sharing)
