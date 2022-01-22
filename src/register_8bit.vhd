library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity register_8bit is
    Port ( clk, load : in std_logic;
         Inn : in std_logic_vector(7 downto 0);
         Outt : out std_logic_vector(7 downto 0));
end register_8bit;


architecture Behavioral of register_8bit is

    signal Q : std_logic_vector(7 downto 0);

begin

    process(clk)
    begin

        if rising_edge(clk) then

            if load = '1' then

                Q <= Inn;

            end if;
        end if;

    end process;

    Outt <= Q;

end Behavioral;
