library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_1 is
    port(
        x0: in std_logic_vector(1 downto 0);
        x1: in std_logic_vector(1 downto 0);
        z: out std_logic_vector(1 downto 0);
        s: in std_logic
        );
end mux2_1;

architecture dataflow of mux2_1 is
    
begin
    with s select 
        z <=    x0 when '0',
                x1 when others;
end dataflow;
