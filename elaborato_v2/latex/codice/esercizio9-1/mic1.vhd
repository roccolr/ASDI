library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.common_defs.all;

entity processor is
    port (
        clk            : in  std_logic;
        reset          : in  std_logic;
        -- interfaccia dati
        mem_data_addr  : out reg_data_type;
        mem_data_out   : out reg_data_type;
        mem_data_in    : in  reg_data_type;
        mem_data_we    : out std_logic;
        -- interfaccia istruzioni
        mem_instr_addr : out reg_data_type;
        mem_instr_in   : in  mbr_data_type
    );
end processor;

architecture structural of processor is

    -- comandi: control unit -> datapath
    signal alu_ctrl : alu_ctrl_type;
    signal c_ctrl   : c_ctrl_type;
    signal mem_ctrl : mem_ctrl_type;
    signal b_ctrl   : b_ctrl_type;

    -- informazioni: datapath -> control unit
    signal mbr    : mbr_data_type;
    signal n_flag : std_logic;
    signal z_flag : std_logic;

begin

    u_dp : entity work.mic1_datapath(rtl)
        port map (
            clk => clk, reset => reset,
            alu_ctrl => alu_ctrl, c_ctrl => c_ctrl,
            mem_ctrl => mem_ctrl, b_ctrl => b_ctrl,
            mbr_out => mbr, n_flag => n_flag, z_flag => z_flag,
            mem_data_addr => mem_data_addr, mem_data_out => mem_data_out,
            mem_data_in => mem_data_in, mem_data_we => mem_data_we,
            mem_instr_addr => mem_instr_addr, mem_instr_in => mem_instr_in
        );

    u_cu : entity work.mic1_cu(rtl)
        port map (
            clk => clk, reset => reset,
            mbr_in => mbr, n_flag => n_flag, z_flag => z_flag,
            alu_ctrl => alu_ctrl, c_ctrl => c_ctrl,
            mem_ctrl => mem_ctrl, b_ctrl => b_ctrl
        );

end structural;