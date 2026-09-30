library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity system_A is
    generic ( 
        N : integer := 8;
        M : integer := 8
        );
    port (
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        req: out std_logic;
        data: out std_logic_vector(0 to M-1);
        ack: in std_logic
    );
end system_A;

architecture structural of system_A is
    signal rom_read, count_en, count_rst, counter_q : std_logic;
    signal addr : std_logic_vector(2 downto 0); -- indirizza la memoria 
begin
    CU: entity work.cu_A(behavioral)
        port map(
            clk => clk, reset => reset, start => start, ack => ack, req => req,
            counter_q => counter_q, count_en => count_en, count_rst => count_rst,
            rom_read => rom_read
            );
    
    CONT: entity work.counter_mod(behavioral)
        generic map(
            M => M, W => 3
            )
        port map(
            clk => clk, rst => count_rst, en => count_en, load => '0',
            d => (others => '0'), tc => counter_q, 
            q => addr
            );
    ROM: entity work.rom_8_8(behavioral)
        generic map (
            N => M,
            A => 3
            )
        port map (
            clk => clk, rd => rom_read, addr => addr, data => data
        );                         
end structural;
