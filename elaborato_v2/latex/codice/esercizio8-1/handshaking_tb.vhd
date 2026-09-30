library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity handshaking_tb is
end handshaking_tb;

architecture bench of handshaking_tb is

    constant T_A : time := 10 ns;
    constant T_B : time := 11 ns;
    
    constant N : integer := 8;
    constant M : integer := 8;
    
    signal req, ack, clkA, clkB, start, rst : std_logic := '0';
    signal data : std_logic_vector (0 to M-1) := (others => '0');
    
begin
    
    sysA: entity work.system_A 
        generic map ( N => N, M => M)
        port map(
            clk => clkA,
            reset => rst,
            start => start,
            req => req, 
            ack => ack,
            data => data
            );
    
    sysB: entity work.system_B
        generic map (N => N, M => M)
        port map (
            clk => clkB,
            reset => rst,
            start => start,
            req => req,
            data => data,
            ack => ack
            );
   
    clockA: process
    begin
        clkA <= '0';
        wait for T_A/2;
        clkA <= '1';
        wait for T_A/2;
    end process;
    
    clockB: process
    begin
        clkB <= '0';
        wait for T_B/2;
        clkB <= '1';
        wait for T_B/2;
    end process;
    
    stim_proc: process
    begin
        wait for 100 ns;
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait for 10 ns;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        
        wait;
    end process;
        
        
end bench;
