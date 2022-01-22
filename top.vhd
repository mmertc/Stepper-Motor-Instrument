library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity top is
    Port ( clk, uart_in : std_logic; --, bu, bd, bl, br, bc : in std_logic;
           motorsw : out std_logic_vector(3 downto 0);
           commandLEDs : out std_logic_vector(15 downto 0));
        --   commandIn : in std_logic_vector(15 downto 0));
end top;

architecture Behavioral of top is

component motor_controller is
    Port ( regdataIn : in std_logic_vector(7 downto 0);
         clk, regload : in std_logic;
         motorsw : out std_logic);
end component;

component command_executer is
    Port ( command : in std_logic_vector(15 downto 0);
         motor0reg, motor1reg, motor2reg, motor3reg : out std_logic_vector(7 downto 0);
         motor0en, motor1en, motor2en, motor3en : out std_logic);
end component;

--component packet_shifter is
--    Port ( packet_ready : in std_logic;
--         packet_in : in std_logic_vector(7 downto 0);
--         command : out std_logic_vector(15 downto 0));
--end component;

component uart_rx is
    Port ( i_Clk, i_RX_Serial : in std_logic;
         o_RX_DV : out std_logic;
         o_RX_Byte : out std_logic_vector(7 downto 0));
end component;

component packet_shifter is
    Port ( clk, packet_ready : in std_logic;
         packet_in : in std_logic_vector(7 downto 0);
         command : out std_logic_vector(15 downto 0));
end component;

component uart_rx_v2 is
    Port ( clk, uart_in : in std_logic;
        command : out std_logic_vector(15 downto 0));
end component;

component uart_rx_v3 is
  generic (
    g_CLKS_PER_BIT : integer := 3200  
    );
  port (
    i_Clk       : in  std_logic;
    i_RX_Serial : in  std_logic;
    o_RX_DV     : out std_logic;
    o_RX_Byte   : out std_logic_vector(7 downto 0)
    );
end component;

--signal LED : std_logic;

signal regload : std_logic_vector(3 downto 0);
signal motorswOut : std_logic_vector(3 downto 0);

signal command : std_logic_vector(15 downto 0);
signal motor0reg, motor1reg, motor2reg, motor3reg : std_logic_vector(7 downto 0);
signal motor0en, motor1en, motor2en, motor3en : std_logic;

signal packet_ready : std_logic;
signal packet_in : std_logic_vector(7 downto 0);

begin

commandLEDs <= command;
--command <= commandIn;

sw0: motor_controller port map(regdataIn => motor0reg, clk => clk, regload => motor0en, motorsw => motorsw(0));   
sw1: motor_controller port map(regdataIn => motor1reg, clk => clk, regload => motor1en, motorsw => motorsw(1));   
sw2: motor_controller port map(regdataIn => motor2reg, clk => clk, regload => motor2en, motorsw => motorsw(2));   
sw3: motor_controller port map(regdataIn => motor3reg, clk => clk, regload => motor3en, motorsw => motorsw(3));   

--sw0: motor_controller port map(regdataIn => command(7 downto 0), clk => clk, regload => '1', motorsw => motorsw(0));   
--sw1: motor_controller port map(regdataIn => command(15 downto 8), clk => clk, regload => '1', motorsw => motorsw(1));   
--sw2: motor_controller port map(regdataIn => "01011000", clk => clk, regload => '1', motorsw => motorsw(2));   
--sw3: motor_controller port map(regdataIn => "01001011", clk => clk, regload => '1', motorsw => motorsw(3));  


--comex: command_executer port map(command => "10010000"&"00111100", motor0reg => motor0reg, motor1reg => motor1reg, motor2reg => motor2reg, motor3reg => motor3reg, motor0en => motor0en, motor1en => motor1en, motor2en => motor2en, motor3en => motor3en);

comex: command_executer port map(command => command, motor0reg => motor0reg, motor1reg => motor1reg, motor2reg => motor2reg, motor3reg => motor3reg, motor0en => motor0en, motor1en => motor1en, motor2en => motor2en, motor3en => motor3en);
packetsh: packet_shifter port map(clk => clk, packet_ready => packet_ready, packet_in => packet_in, command => command);
--pacshtest: packetshifter_tester port map(bc => bc, bd => bd, bl => bl, br => br, bu => bu, curPacket => packet_in, packetReady => packet_ready);

--uartv2: uart_rx_v2 port map(clk => clk, uart_in => uart_in, command => command);

uartv3: uart_rx_v3 port map(i_clk => clk, i_rx_serial => uart_in, o_rx_dv => packet_ready, o_rx_byte => packet_in);
--uart: uart_rx port map(i_clk => clk, i_rx_serial => uart_in, o_rx_dv => packet_ready, o_rx_byte => packet_in);


end Behavioral;
