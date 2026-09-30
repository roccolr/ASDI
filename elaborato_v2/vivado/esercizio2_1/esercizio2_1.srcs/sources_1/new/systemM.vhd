library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity systemM is
    port(
        data_in: in std_logic_vector(7 downto 0);
        data_out: out std_logic_vector(3 downto 0)
    );
end systemM;

architecture dataflow of systemM is
    
begin
    data_out(0) <= data_in(0) and data_in(1);
    data_out(1) <= data_in(2) and data_in(3);
    data_out(2) <= data_in(4) and data_in(5);
    data_out(3) <= data_in(6) and data_in(7);
end dataflow;
