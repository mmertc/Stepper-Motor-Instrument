library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity sw_generator is
    Port ( clk, sz  : in std_logic;
         N : std_logic_vector(23 downto 0);
         clkOut : out std_logic);
end sw_generator;



architecture Behavioral of sw_generator is

    signal Q : std_logic;
    signal counter : integer;

begin

    process(clk)
    begin

        if rising_edge(clk) then

            if counter = (unsigned(N) - 1) then
                Q <= not Q;
                counter <= 0;
            elsif counter > (unsigned(N) - 1) then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;

        end if;
    end process;



    with sz select
 clkout <= Q when '0',
        '0' when '1',
        'X' when others;




end Behavioral;
