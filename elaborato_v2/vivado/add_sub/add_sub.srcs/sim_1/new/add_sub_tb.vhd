library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity add_sub_tb is
end add_sub_tb;

architecture Behavioral of add_sub_tb is
    constant N : positive := 8;
    constant T : time := 10 ns;
    
    signal a : std_logic_vector(N-1 downto 0);
    signal b : std_logic_vector(N-1 downto 0);
    signal c_in: std_logic;
    signal c_out: std_logic;
    signal s: std_logic_vector(N-1 downto 0);
    signal ovf: std_logic;
begin
    dut: entity work.add_sub
        port map(   a => a, b => b, 
                    c_in => c_in, s => s, 
                    c_out => c_out, ovf => ovf  );
    stim_proc: process
    begin 
        c_in <= '0';
        a <= std_logic_vector(to_unsigned(10, N));
        b <= std_logic_vector(to_unsigned(10, N));
        wait for 10 ns;
        
        a <= std_logic_vector(to_unsigned(120, N));
        b <= std_logic_vector(to_unsigned(8, N));
        wait for 10 ns;
        
        c_in <= '1';
        a <= std_logic_vector(to_unsigned(20, N));
        b <= std_logic_vector(to_unsigned(20, N));
        wait for 10 ns;
        
        a <= std_logic_vector(to_signed(-120,N));
        b <= std_logic_vector(to_unsigned(9, N));
        wait;
    end process;
    
end Behavioral;
