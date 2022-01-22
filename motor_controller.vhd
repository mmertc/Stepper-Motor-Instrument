library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity motor_controller is
    Port ( regdataIn : in std_logic_vector(7 downto 0);
         clk, regload : in std_logic;
         motorsw : out std_logic);
end motor_controller;

architecture Behavioral of motor_controller is
    component sw_generator is
        Port ( clk, sz : in std_logic;
             N : in std_logic_vector(23 downto 0);
             clkOut : out std_logic);
    end component;

    component note_frequencyLUT is
        Port ( noteNum : in std_logic_vector(6 downto 0);
             noteN : out std_logic_vector(23 downto 0));
    end component;

    component register_8bit is
        Port ( clk, load : in std_logic;
             Inn : in std_logic_vector(7 downto 0);
             Outt : out std_logic_vector(7 downto 0));
    end component;


    signal regdataOut : std_logic_vector(7 downto 0);
    signal currentnoteN : std_logic_vector(23 downto 0); 

begin

register8bit: register_8bit port map(clk => clk, load => regload, Inn => regdataIn, Outt => regdataout);
noteLUT: note_frequencyLUT port map(noteNum => regdataOut(6 downto 0), noteN => currentnoteN);
swgenerator: sw_generator port map(clk => clk, sz => regdataOut(7), N => currentnoteN, clkOut => motorsw);




end Behavioral;
