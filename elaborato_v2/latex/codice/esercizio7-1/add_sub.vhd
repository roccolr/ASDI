library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity add_sub is
    generic ( 
    N : positive := 8
    );
    port (
        a : in std_logic_vector(N-1 downto 0);
        b : in std_logic_vector(N-1 downto 0);
        c_in: in std_logic;
        s: out std_logic_vector(N-1 downto 0);
        c_out: out std_logic;
        ovf: out std_logic
    );
end add_sub;

architecture structural of add_sub is
    signal complementoB : std_logic_vector(N-1 downto 0);
begin
    compl: 
        for i in 0 to N-1 generate
            complementoB(i) <= b(i) xor c_in;
        end generate;
    
    RCA: entity work.rca
        port map( a => a, b => complementoB, c_in => c_in, s => s, c_out => c_out, ovf => ovf); 


end structural;
