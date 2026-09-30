library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity interconn16_4_tb is
end interconn16_4_tb;

architecture Behavioral of interconn16_4_tb is
    signal input: std_logic_vector(0 to 15) := (others => '0');
    signal output: std_logic_vector(0 to 3) := (others => '0');
    signal ctrl_in: std_logic_vector(3 downto 0) := (others => '0');
    signal ctrl_out: std_logic_vector(1 downto 0) := (others => '0');
begin
    INT: entity work.interconn16_4 port map(x => input, s_i => ctrl_in, s_o => ctrl_out, y => output);
    stimuli: process 
    begin
        -- testiamo la comunicazione tra il secondo input e i 4 canali di output
        input <= "0101010011000110";
        ctrl_in <= "0000";
        ctrl_out <= "00";
        wait for 10 ns;
        ctrl_in <= "0001";
        for j in 0 to 3 loop
            ctrl_out <= std_logic_vector(to_unsigned(j,2));
            wait for 10 ns;
            assert output(j) = input(1) 
                report "Errore di comunicazione tra il canale 1 e il canale " & integer'image(j)
                severity failure;
        end loop;
    wait; 
    end process;
end Behavioral;
