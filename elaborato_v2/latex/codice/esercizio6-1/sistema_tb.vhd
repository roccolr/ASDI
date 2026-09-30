library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity sistema_tb is
end sistema_tb;

architecture bench of sistema_tb is
    constant N: positive := 16;
    constant A: positive := 4;
    constant T: time := 10 ns;
    
    -- valori attesi in MEM
    type exp_t is array (0 to N-1) of natural;
    constant EXP : exp_t := (   0, 8, 1, 1, 
                                4, 4, 4, 4,
                                7, 7, 2, 4,
                                6, 1, 4, 4);
    
    signal clk : std_logic := '0';
    signal rst: std_logic := '1';
    signal start: std_logic := '0';
    signal done: std_logic;
    signal raddr: std_logic_vector(A-1 downto 0) := (others => '0');
    signal dout: std_logic_vector(3 downto 0);
    
begin
    
    dut: entity work.sistema(structural)
        generic map (N => N, A => A)
        port map (  clk => clk, rst => rst, start => start, done => done,
                    raddr => raddr, dout => dout);
    
    clk_proc: process
    begin 
        clk <= '0'; wait for T/2;
        clk <= '1'; wait for T/2;
    end process;
    
    stim: process
    begin
        rst <= '1'; wait for 2*T;
        rst <= '0'; wait for 2*T;
        
        start <= '1';
        wait until done = '1';
        wait for 3*T;
        start <= '0';
        wait for 2*T;
        
        -- verifica contenuto mem
        for i in 0 to N-1 loop
            raddr <= std_logic_vector(to_unsigned(i,A));
            wait for T;
            assert dout = std_logic_vector(to_unsigned(EXP(i), 4))
                report "MEM(" & integer'image(i) & ") errata, atteso "
                       & integer'image(EXP(i))
                severity error;
        end loop;
        wait;
    end process;
end bench;
