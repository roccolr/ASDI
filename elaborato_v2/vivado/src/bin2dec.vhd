library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bin2dec is
    port (
        bin    : in  std_logic_vector(5 downto 0);   -- valore 0..63
        decine : out std_logic_vector(3 downto 0);   -- cifra BCD
        unita  : out std_logic_vector(3 downto 0)    -- cifra BCD
    );
end bin2dec;

architecture behavioral of bin2dec is
    signal v : unsigned(5 downto 0);
    signal d : unsigned(3 downto 0);
    signal u : unsigned(5 downto 0);
begin

    v <= unsigned(bin);

    process(v)
    begin
        if v >= 60 then
            d <= to_unsigned(6, 4);
            u <= v - 60;
        elsif v >= 50 then
            d <= to_unsigned(5, 4);
            u <= v - 50;
        elsif v >= 40 then
            d <= to_unsigned(4, 4);
            u <= v - 40;
        elsif v >= 30 then
            d <= to_unsigned(3, 4);
            u <= v - 30;
        elsif v >= 20 then
            d <= to_unsigned(2, 4);
            u <= v - 20;
        elsif v >= 10 then
            d <= to_unsigned(1, 4);
            u <= v - 10;
        else
            d <= to_unsigned(0, 4);
            u <= v;
        end if;
    end process;

    decine <= std_logic_vector(d);
    unita  <= std_logic_vector(u(3 downto 0));  

end behavioral;