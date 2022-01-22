library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity packet_shifter is
    Port ( clk, packet_ready : in std_logic;
         packet_in : in std_logic_vector(7 downto 0);
         command : out std_logic_vector(15 downto 0));
end packet_shifter;

architecture Behavioral of packet_shifter is

    signal CP1, CP0 : std_logic_vector(7 downto 0);

begin

    command(15 downto 8) <= CP1;
    command(7 downto 0) <= CP0;

    process(clk)
    begin
    if rising_edge(clk) then
        if packet_ready = '1' then
            CP1 <= CP0;
            CP0 <= packet_in;

        end if;
        end if;
    end process;


end Behavioral;
