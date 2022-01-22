library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity command_executer is
    Port ( command : in std_logic_vector(15 downto 0);
         motor0reg, motor1reg, motor2reg, motor3reg : out std_logic_vector(7 downto 0);
         motor0en, motor1en, motor2en, motor3en : out std_logic);
end command_executer;

architecture Behavioral of command_executer is


    signal en0, en1, en2, en3 : std_logic;

begin

    motor0reg(6 downto 0) <= command(6 downto 0);
    motor0reg(7) <= not command(12);

    motor1reg(6 downto 0) <= command(6 downto 0);
    motor1reg(7) <= not command(12);

    motor2reg(6 downto 0) <= command(6 downto 0);
    motor2reg(7) <= not command(12);

    motor3reg(6 downto 0) <= command(6 downto 0);
    motor3reg(7) <= not command(12);


    motor0en <= en0;
    motor1en <= en1;
    motor2en <= en2;
    motor3en <= en3;


    process(command)
    begin

        if ( command(15) and (not command(14)) and (not command(13)) and (not command(7))) = '1' then

            case command(11 downto 8) is

                when "0000" =>
                    en0 <= '1';
                    en1 <= '0';
                    en2 <= '0';
                    en3 <= '0';
                when "0001" =>
                    en0 <= '0';
                    en1 <= '1';
                    en2 <= '0';
                    en3 <= '0';
                when "0010" =>
                    en0 <= '0';
                    en1 <= '0';
                    en2 <= '1';
                    en3 <= '0';
                when "0011" =>
                    en0 <= '0';
                    en1 <= '0';
                    en2 <= '0';
                    en3 <= '1';
                when others =>
                    en0 <= 'X';
                    en1 <= 'X';
                    en2 <= 'X';
                    en3 <= 'X';
            end case;
            
        else
            en0 <= '0';
            en1 <= '0';
            en2 <= '0';
            en3 <= '0';

        end if;


    end process;
end Behavioral;
