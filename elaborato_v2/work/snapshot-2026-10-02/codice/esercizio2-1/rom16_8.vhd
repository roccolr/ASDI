library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom16_8 is
    port (
        address: in std_logic_vector(3 downto 0);
        data: out std_logic_vector(7 downto 0)
    );
end rom16_8;

architecture Behavioral of rom16_8 is
    type ROM is array (0 to 15) of std_logic_vector(0 to 7);
    signal mem : ROM :=     (x"4A", x"1C", 
                            x"8F", x"E3",
                            x"5B", x"02", 
                            x"D7", x"9E", 
                            x"B4", x"61", 
                            x"FA", x"39", 
                            x"C5", x"78", 
                            x"20", x"ED");
    attribute rom_style : string; 
    attribute rom_style of mem : signal is "block";
    
begin
    process(address)
    begin
        data <= mem(to_integer(unsigned(address)));
    end process;

end Behavioral;
