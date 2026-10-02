library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity arbitro is
    port(
        req : in std_logic_vector(3 downto 0);
        src_out : out std_logic_vector(1 downto 0) -- segnale che andrà alla omegaN  
    );
end arbitro;

architecture dataflow of arbitro is
    
begin
    src_out <=  "00" when req(0) = '1' else
                "01" when req(1) = '1' else 
                "10" when req(2) = '1' else 
                "11";

end dataflow;
