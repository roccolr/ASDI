----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.08.2026 19:47:40
-- Design Name: 
-- Module Name: mux_2_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_2_1 is
    port (
        a0  :   in  std_logic;
        a1  :   in  std_logic; 
        s   :   in  std_logic;
        y   :   out std_logic 
        ); 
end mux_2_1;

architecture dataflow of mux_2_1 is

begin
    y <= (a0 and (not s)) or (a1 and s);

end dataflow;


architecture alternative of mux_2_1 is

begin

    y <= a0 when s = '0' else
         a1 when s = '1' else
         '-';

end alternative;

architecture alternative2 of mux_2_1 is
-- La semantica è parallela, non a priorità: è l'equivalente del case. 
-- I casi non possono sovrapporsi - il compilatore te lo impedisce - 
-- e devono coprire l'intero dominio del selettore
begin

    with s select
        y <= a0  when '0',
             a1  when '1',
             '-' when others;

end alternative2;

architecture behavioral of mux_2_1 is

begin

    process (a0, a1, s)  -- sensitivity list 
    -- il process si attiva ogni volta che uno dei segnali
    -- commuta 
    begin
        case s is
            when '0'    => y <= a0;
            when '1'    => y <= a1;
            when others => y <= '-';
        end case;
    end process;

end behavioral;


architecture behavioral1 of mux_2_1 is

begin

    process (a0, a1, s)
    begin
        if s = '0' then
            y <= a0;
        elsif s = '1' then
            y <= a1;
        else
            y <= '-';
        end if;
    end process;

end behavioral1;
