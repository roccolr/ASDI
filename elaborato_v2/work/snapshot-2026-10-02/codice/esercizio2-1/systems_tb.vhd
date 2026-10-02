library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity systemS_tb is
end systemS_tb;

architecture Behavioral of systemS_tb is
    signal x : std_logic_vector(3 downto 0);
    signal y: std_logic_vector(3 downto 0);
    signal ref_in: std_logic_vector(7 downto 0);
    signal ref_out: std_logic_vector(3 downto 0);
    type ROM is array (0 to 15) of std_logic_vector(0 to 7);
    signal ref_mem : ROM :=     (x"4A", x"1C", 
                            x"8F", x"E3",
                            x"5B", x"02", 
                            x"D7", x"9E", 
                            x"B4", x"61", 
                            x"FA", x"39", 
                            x"C5", x"78", 
                            x"20", x"ED");
    
begin
    SYSTEM_S: entity work.systemS port map(input => x, output => y);
    SYSTEM_M: entity work.systemM port map(data_in => ref_in, data_out => ref_out);
    
    stim_proc: process
    begin 
        wait for 10 ns;
        for j in 0 to 15 loop
            x <= std_logic_vector(to_unsigned(j,4));
            ref_in <= ref_mem(j);
            wait for 10 ns;
            assert y = ref_out
                report "Errore all'indirizzo " & integer'image(j)
                severity failure;
        end loop;
    wait;    
    end process;
end Behavioral;
