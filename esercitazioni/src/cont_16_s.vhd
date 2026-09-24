----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.08.2026 22:17:35
-- Design Name: 
-- Module Name: cont_16_s - Behavioral
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

entity cont_16_s is
    Port ( 
        C : in std_logic;
        R : in std_logic;
        cont: out std_logic_vector(0 to 3)
    );
end cont_16_s;

architecture structural of cont_16_s is
    
    component ffT is
        port(
            clk : in std_logic;
            reset: in std_logic;
            Y: out std_logic
        );
    end component;     
    signal S1: std_logic;
    signal S2: std_logic;
    signal S3: std_logic;
    signal S4: std_logic;
    
begin
    ff1: ffT 
        port map(
            C, 
            R, 
            S1
        );
    ff2: ffT 
        port map(
            S1, 
            R, 
            S2
        );
          
    ff3: ffT 
        port map(
            S2, 
            R, 
            S3
        );
   ff4: ffT 
        port map(
            S3, 
            R, 
            S4
        );  
    cont<= S4 & S3 & S2 & S1;
end structural;
