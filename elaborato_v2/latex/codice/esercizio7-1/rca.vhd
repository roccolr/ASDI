library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity rca is
    generic (
        N: positive := 8
    );
    Port ( 
        a, b : in std_logic_vector(N-1 downto 0);
        c_in : in std_logic;
        s : out std_logic_vector(N-1 downto 0);
        c_out : out std_logic;
        ovf: out std_logic
    );
end rca;

architecture structural of rca is
       
    signal c : std_logic_vector(N downto 0); 
begin
    c(0)<=c_in;
    FA_gen: for i in 0 to N-1 generate
        fa_i: entity work.full_adder 
            port map( a => a(i), b => b(i), c_in => c(i), s => s(i), c_out => c(i+1));
    end generate;
    
    c_out <= c(N);
    ovf <= c(N) xor c(N-1);
end structural;
