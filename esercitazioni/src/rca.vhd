----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.09.2026 17:23:11
-- Design Name: 
-- Module Name: rca - structural
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

entity rca is
    Port ( 
        a, b : in std_logic_vector(7 downto 0);
        c_in : in std_logic;
        s : out std_logic_vector(7 downto 0);
        c_out : out std_logic
    );
end rca;

architecture structural of rca is
    component full_adder is
        Port ( 
            a, b, c_in : in std_logic;
            s, c_out : out std_logic
        );
    end component;
    
    signal c : std_logic_vector(8 downto 0); 
begin
    c(0)<=c_in;
    c_out<=c(8);
    
    fa0: full_adder port map (a=>a(0), b=>b(0), c_in=>c(0), s=>s(0), c_out=>c(1));
    fa1: full_adder port map (a=>a(1), b=>b(1), c_in=>c(1), s=>s(1), c_out=>c(2));
    fa2: full_adder port map (a=>a(2), b=>b(2), c_in=>c(2), s=>s(2), c_out=>c(3));
    fa3: full_adder port map (a=>a(3), b=>b(3), c_in=>c(3), s=>s(3), c_out=>c(4));
    fa4: full_adder port map (a=>a(4), b=>b(4), c_in=>c(4), s=>s(4), c_out=>c(5));
    fa5: full_adder port map (a=>a(5), b=>b(5), c_in=>c(5), s=>s(5), c_out=>c(6));
    fa6: full_adder port map (a=>a(6), b=>b(6), c_in=>c(6), s=>s(6), c_out=>c(7));
    fa7: full_adder port map (a=>a(7), b=>b(7), c_in=>c(7), s=>s(7), c_out=>c(8));

end structural;
