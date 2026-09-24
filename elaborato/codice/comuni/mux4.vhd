library ieee;
use ieee.std_logic_1164.all;

-- Multiplexer 4:1: y = d(s)
entity mux4 is
    port (
        d : in  std_logic_vector(3 downto 0);  -- ingressi dati
        s : in  std_logic_vector(1 downto 0);  -- selezione
        y : out std_logic
    );
end entity;

architecture dataflow of mux4 is
begin
    with s select
        y <= d(0) when "00",
             d(1) when "01",
             d(2) when "10",
             d(3) when others;
end architecture;
