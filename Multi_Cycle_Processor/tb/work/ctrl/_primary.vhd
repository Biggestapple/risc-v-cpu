library verilog;
use verilog.vl_types.all;
entity ctrl is
    port(
        clk             : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        instr           : in     vl_logic_vector(31 downto 0);
        zero            : in     vl_logic;
        pcWrite         : out    vl_logic;
        adrSrc          : out    vl_logic;
        mem_we          : out    vl_logic;
        irWrite         : out    vl_logic;
        resultSrc       : out    vl_logic_vector(1 downto 0);
        aluCtr          : out    vl_logic_vector(2 downto 0);
        comCtr          : out    vl_logic_vector(1 downto 0);
        aluSrcA         : out    vl_logic_vector(1 downto 0);
        aluSrcB         : out    vl_logic_vector(1 downto 0);
        immSrc          : out    vl_logic_vector(2 downto 0);
        reg_w           : out    vl_logic;
        mem_rdy         : in     vl_logic;
        valid           : out    vl_logic;
        halt            : out    vl_logic;
        debug_port      : out    vl_logic_vector(3 downto 0)
    );
end ctrl;
