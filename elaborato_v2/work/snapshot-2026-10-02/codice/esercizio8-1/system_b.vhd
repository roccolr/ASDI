library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity system_B is
    generic ( 
        N : integer := 8;
        M : integer := 8
        );
    port (
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        req: in std_logic;
        data: in std_logic_vector(0 to M-1);
        ack: out std_logic
    );
end system_B;

architecture structural of system_B is
    signal count_en, mem_read, mem_write, reg_read : std_logic;
    signal addr : std_logic_vector(2 downto 0);
    signal sum, adder_input_rx, adder_input: std_logic_vector(M-1 downto 0);
begin
    
    CU: entity work.cu_B
        port map(
            clk => clk, reset => reset, start => start, req => req, ack => ack,
            count_en => count_en, mem_read => mem_read, mem_write => mem_write,
            reg_read => reg_read
            );
    
    MEM: entity work.mem
        generic map(
            N => N, A => 3, W => M
            )
        port map(
            clk => clk, we => mem_write, waddr => addr, 
            din => sum, raddr => addr, dout => adder_input
            );
    
    COUNT: entity work.counter_mod 
        generic map(
            M => N,
            W => 3
            )
        port map(
            clk => clk, rst => reset, en => count_en, load => '0',
            d => (others => '0'), q => addr, tc => open          
            );
        
    ADDER: entity work.adder 
        generic map ( M => M)
        port map (
            x => adder_input_rx, y => adder_input, output =>  sum
            );
         
    buff: entity work.register_M
        generic map ( M => M)
        port map (  
            clk => clk, rst => reset, load => reg_read, input => data, output => adder_input_rx
                );
    
    

end structural;
