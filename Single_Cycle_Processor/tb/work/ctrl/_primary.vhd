library verilog;
use verilog.vl_types.all;
entity ctrl is
    port(
        instr           : in     vl_logic_vector(31 downto 0);
        zero            : in     vl_logic;
        pcSrc           : out    vl_logic;
        resultSrc       : out    vl_logic_vector(1 downto 0);
        mem_w           : out    vl_logic;
        aluCtr          : out    vl_logic_vector(2 downto 0);
        comCtr          : out    vl_logic_vector(1 downto 0);
        aluSrc          : out    vl_logic;
        immSrc          : out    vl_logic_vector(2 downto 0);
        reg_w           : out    vl_logic
    );
end ctrl;
