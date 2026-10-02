library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity shift_register_tb is
end shift_register_tb;

architecture Behavioral of shift_register_tb is
    constant N : positive := 8;
    constant T : time := 10 ns;
    
    signal clk : std_logic := '0';
    signal rst : std_logic := '1'; 
    signal load: std_logic := '0';
    signal en: std_logic := '0';
    signal dir: std_logic := '0';
    signal pos: std_logic := '0';
    signal d : std_logic_vector(N-1 downto 0) := (others => '0');
    signal q_beh : std_logic_vector(N-1 downto 0);
    signal q_str : std_logic_vector(N-1 downto 0);    
begin
    dut_beh: entity work.shift_register(Behavioral)
        generic map(N => N)
        port map( 
            clk => clk, rst => rst,
            load => load, en => en,
            dir => dir, pos => pos, 
            d => d, q => q_beh
        );
    dut_str: entity work.shift_register(structural)
        generic map(N => N)
        port map( 
            clk => clk, rst => rst,
            load => load, en => en,
            dir => dir, pos => pos, 
            d => d, q => q_str
        );
        
    clk_proc: process
    begin 
        clk <= '0'; wait for T/2;
        clk <= '1'; wait for T/2;
    end process;
    
    stim: process 
    begin
        rst <= '1'; wait for 2*T;
        rst <= '0';
        
        -- parallel load
        d <= "10110011"; load <= '1'; wait for T; 
        -- q = 10110011
        load <= '0';
        
        en <= '1';
        dir <= '0'; pos <= '0'; wait for T; -- dx di 1 01011001
        dir <= '0'; pos <= '1'; wait for T; -- dx di 2 00010110
        dir <= '1'; pos <= '0'; wait for T; -- sx di 1 00101100
        dir <= '1'; pos <= '1'; wait for T; -- sx di 2 10110000
        
        en <= '0'; wait for 2*T; -- hold per 2 periodi 
        
        -- load e en insieme: vince load 
        d <= "11110000"; load <= '1'; en <= '1'; wait for T; -- q = "11110000"
        load <= '0'; en <= '0';
        
        -- reset e load: vince reset 
        rst <= '1'; load <= '1'; wait for T;
        rst <= '0'; load <= '0'; wait for 2*T;
        
        wait;
    end process;
    
    check : process
    begin
        wait until clk'event and clk = '0';
        assert q_beh = q_str
            report "Le due architetture divergono"
            severity error;
    end process;
    
end Behavioral;
