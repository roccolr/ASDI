library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA is
    port (
        x : in std_logic_vector(5 downto 0);
        y : in std_logic_vector(5 downto 0);
        c0: in std_logic;
        s : out std_logic_vector(5 downto 0);
        c_out: out std_logic
        );
end CLA;

architecture dataflow of CLA is
    signal G, P : std_logic_vector(5 downto 0);
    signal C: std_logic_vector(6 downto 0);
begin

    gen_pro: for i in 0 to 5 generate
        G(i) <= x(i) and y(i);
        P(i) <= x(i) xor y(i);
    end generate;

    C(0) <= c0;
    C(1) <= G(0) or (P(0) and C(0));
    C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and C(0));
    C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0))
                 or (P(2) and P(1) and P(0) and C(0));
    C(4) <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1))
                 or (P(3) and P(2) and P(1) and G(0))
                 or (P(3) and P(2) and P(1) and P(0) and C(0));
    C(5) <= G(4) or (P(4) and G(3)) or (P(4) and P(3) and G(2))
                 or (P(4) and P(3) and P(2) and G(1))
                 or (P(4) and P(3) and P(2) and P(1) and G(0))
                 or (P(4) and P(3) and P(2) and P(1) and P(0) and C(0));
    C(6) <= G(5) or (P(5) and G(4)) or (P(5) and P(4) and G(3))
                 or (P(5) and P(4) and P(3) and G(2))
                 or (P(5) and P(4) and P(3) and P(2) and G(1))
                 or (P(5) and P(4) and P(3) and P(2) and P(1) and G(0))
                 or (P(5) and P(4) and P(3) and P(2) and P(1) and P(0) and C(0));

    sum: for i in 0 to 5 generate
        s(i) <= P(i) xor C(i);
    end generate;

    c_out <= C(6);
end dataflow;