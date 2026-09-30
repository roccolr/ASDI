library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity cronometro_tb is
end cronometro_tb;

architecture bench of cronometro_tb is
    constant T : time := 10 ns;
    constant SEC: time:= 4*T; -- un "secondo"
    
    signal clk : std_logic := '0';
    signal rst: std_logic := '1';
    signal run: std_logic := '0';
    signal set: std_logic := '0';
    signal h_in: std_logic_vector(4 downto 0) := (others => '0');
    signal m_in: std_logic_vector(5 downto 0) := (others => '0');
    signal s_in: std_logic_vector(5 downto 0) := (others => '0');
    signal h: std_logic_vector(4 downto 0);
    signal m: std_logic_vector(5 downto 0);
    signal s: std_logic_vector(5 downto 0);
begin
    dut: entity work.cronometro(structural)
        generic map( F_CLK => 4) -- fini simulativi
        port map(   clk => clk, rst => rst, 
                    run => run, set => set, 
                    h_in => h_in, m_in => m_in,
                    s_in => s_in, h => h, m => m,
                    s => s);
    clk_proc: process
    begin 
        clk <= '0'; wait for T/2;
        clk <= '1'; wait for T/2;
    end process;
    
    stim : process 
    begin
        rst <= '1'; wait for 2*T;
        rst <= '0';
        
        run <= '1'; wait for 5*SEC; -- 00:00:00 -> 00:00:05
        
        run <= '0'; wait for 3*SEC;
        
        run <= '1';
        h_in <= std_logic_vector(to_unsigned(0, 5));
        m_in <= std_logic_vector(to_unsigned(0, 6)); 
        s_in <= std_logic_vector(to_unsigned(58, 6));
        set <= '1'; wait for T; set <= '0';
        wait for 3*SEC; -- 00:00:58 -> 00:01:00
        
        m_in <= std_logic_vector(to_unsigned(59, 6));
        set <= '1'; wait for T; set <= '0';
        wait for 3*SEC; -- 00:59:58 -> 01:00:00
        
        h_in <= std_logic_vector(to_unsigned(23, 5));
        set <= '1'; wait for T; set <= '0';
        wait for 3*SEC; -- 23:59:58 -> 00:00:00
        
        rst <= '1'; wait for T; rst <= '0';
        wait for 2*SEC;
        
        wait;
    end process;
end bench;
