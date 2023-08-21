library verilog;
use verilog.vl_types.all;
entity mc_cpu is
    port(
        clk             : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        mem_addr        : out    vl_logic_vector(31 downto 0);
        mem_wdata       : out    vl_logic_vector(31 downto 0);
        mem_we          : out    vl_logic;
        mem_rdy         : in     vl_logic;
        mem_rdata       : in     vl_logic_vector(31 downto 0);
        valid           : out    vl_logic;
        halt            : out    vl_logic;
        debug_port      : out    vl_logic_vector(3 downto 0)
    );
end mc_cpu;
