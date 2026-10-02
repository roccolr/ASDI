library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.common_defs.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mic1_cu is
    port (
            clk      : in  std_logic;
            reset    : in  std_logic;
            -- informazioni dal datapath
            mbr_in   : in  mbr_data_type;
            n_flag   : in  std_logic;
            z_flag   : in  std_logic;
            -- segnali di controllo verso il datapath
            alu_ctrl : out alu_ctrl_type;
            c_ctrl   : out c_ctrl_type;
            mem_ctrl : out mem_ctrl_type;
            b_ctrl   : out b_ctrl_type
        );
end mic1_cu;


architecture rtl of mic1_cu is
    -- dopo il reset: nessuna operazione, poi salto all'avvio (0x100)
    constant RESET_MIR : mir_type :=
        "100000000" & "000" & "00000000" & "000000000" & "000" & "1111";
    
    signal mir     : mir_type;
    signal mpc     : mpc_type;
    signal cs_word : mir_type;
    
    -- i campi della microistruzione corrente
    alias mir_addr : std_logic_vector(8 downto 0) is mir(35 downto 27);
    alias mir_jmpc : std_logic                    is mir(26);
    alias mir_jamn : std_logic                    is mir(25);
    alias mir_jamz : std_logic                    is mir(24);
    alias mir_alu  : std_logic_vector(7 downto 0) is mir(23 downto 16);
    alias mir_c    : std_logic_vector(8 downto 0) is mir(15 downto 7);
    alias mir_mem  : std_logic_vector(2 downto 0) is mir(6 downto 4);
    alias mir_b    : std_logic_vector(3 downto 0) is mir(3 downto 0);
    
    signal mpc_low  : std_logic_vector(7 downto 0);
    signal mpc_high : std_logic;
    
begin
    ------------------------------------------------------------ MIR
    mir_proc : process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                mir <= RESET_MIR;
            else
                mir <= cs_word;
            end if;
        end if;
    end process;

    ------------------------------------------------------------ MPC (bit ORing)
    mpc_low  <= mir_addr(7 downto 0) or mbr_in when mir_jmpc = '1' else
                mir_addr(7 downto 0);

    mpc_high <= mir_addr(8) or (mir_jamn and n_flag) or (mir_jamz and z_flag);

    mpc <= mpc_high & mpc_low;

    u_cs : entity work.control_store(rom)
        port map (addr => mpc, word => cs_word);
    
    alu_ctrl <= mir_alu;
    c_ctrl   <= mir_c;
    mem_ctrl <= mir_mem;
    b_ctrl   <= mir_b;

end rtl;
