
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity cronometro is
    generic (
        F_CLK : positive := 100_000_000 -- cicli per secondo
    );
    
    port (
        clk: in std_logic;
        rst: in std_logic;
        run: in std_logic; -- 1-> conta, 0-> fermo
        set: in std_logic; -- 1 -> carica h_in, m_in, s_in
        h_in: in std_logic_vector(4 downto 0);
        m_in: in std_logic_vector(5 downto 0);
        s_in: in std_logic_vector(5 downto 0);
        h: out std_logic_vector(4 downto 0);
        m: out std_logic_vector(5 downto 0);
        s: out std_logic_vector(5 downto 0)
    );
end cronometro;

architecture structural of cronometro is
    constant W_PRESC : positive := 27; -- 2**27 > 100 000 000
    constant ZERO: std_logic_vector(W_PRESC-1 downto 0) := (others => '0');
    
    signal tick: std_logic;
    signal tc_s: std_logic; -- riporto s -> m
    signal tc_m: std_logic; -- riport m -> h
    
begin
    presc : entity work.counter_mod(behavioral)
        generic map (M=> F_CLK, W => W_PRESC)
        port map (  clk => clk, rst => rst, en => run, load => set, d => ZERO,
                    q => open, tc => tick);
    
    sec: entity work.counter_mod(behavioral)
        generic map (M => 60, W => 6)
        port map (  clk => clk, rst => rst, en => tick, load => set, d => s_in,
                    q => s, tc => tc_s);
    min: entity work.counter_mod(behavioral)
        generic map (M => 60, W => 6)
        port map (  clk => clk, rst => rst, en => tc_s, load => set, d => m_in,
                    q => m, tc => tc_m);
    ore: entity work.counter_mod(behavioral)
        generic map (M => 24, W => 5)
        port map (  clk => clk, rst => rst, en => tc_m, load => set, d => h_in,
                    q => h, tc => open);              
end structural;
