library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_16_1_tb is
end mux_16_1_tb;

architecture behavioral of mux_16_1_tb is
    signal i: std_logic_vector(0 to 15);
    signal s: std_logic_vector(3 downto 0);
    signal y: std_logic := '0';    
begin
    MUX: entity work.mux_16_1 port map(a => i, s => s, y => y);
    
    stimuli: process 
    begin
        wait for 100 ns;
        i <= "0010110101001010";
        
        for j in 0 to 15 loop
            s <= std_logic_vector(to_unsigned(j,4));
            wait for 10 ns;
            assert y = i(j) 
                report "Errore generico nella selezione dell'ingresso" & integer'image(j)
                severity failure;
        end loop;
        wait;
    end process;         
end behavioral;
