library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;

entity booth is
    port (
        clk : in std_logic;
        rst : in std_logic;
        start: in std_logic;
        x : in std_logic_vector(7 downto 0);
        y : in std_logic_vector(7 downto 0);
        p : out std_logic_vector(15 downto 0);
        done : out std_logic
    );
end booth;

architecture structural of booth is
    signal load_mq, load_a, sub, shift, cnt_en, cnt_rst : std_logic;
    signal q0, qm1, last: std_logic;
begin
    u_po : entity work.booth_po(mixed)
        port map (  clk => clk, rst => rst, x => x, y => y, p => p,
                    load_mq => load_mq, load_a => load_a, sub => sub,
                    shift => shift, cnt_en => cnt_en, cnt_rst => cnt_rst,
                    q0 => q0, qm1 => qm1, last => last
                );
    u_cu: entity work.booth_cu(behavioral)
        port map (   clk => clk, rst => rst, start => start,
                    q0 => q0, qm1 => qm1, last => last,
                    load_mq => load_mq, load_a => load_a, sub => sub,
                    shift => shift, cnt_en => cnt_en, cnt_rst => cnt_rst,
                    done => done
                );

end structural;
