--
-- Control unit 
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is 
   port(
	i_rst: in std_logic;
	i_clk: in std_logic;
   i_cf: in std_logic;
   i_zf: in std_logic;
	i_instruction: in std_logic_vector(3 downto 0);
	o_step_counter: out std_logic_vector(2 downto 0);
	o_control: out std_logic_vector(15 downto 0));
end entity;

architecture behave of control is 
   
   signal s_count: unsigned(2 downto 0);
   signal s_instruction: std_logic_vector(6 downto 0);
	
begin 
   
   -- Instruction step counter
   process(i_rst, i_clk)
   begin 
      if (i_rst = '0') then
         s_count <= (others => '0');
      elsif (falling_edge(i_clk)) then
         if (s_count = "100") then
    	   	s_count <= (others => '0');
         else
            s_count <= s_count + 1;
	 		end if;
      end if;
   end process;
   o_step_counter <= std_logic_vector(s_count);
	
   -- Combinational logic
   s_instruction(2 downto 0) <= std_logic_vector(s_count);
   s_instruction(6 downto 3) <= i_instruction;
	-- o_control = ( 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0)
	--              hlt mi ri ro ii io ai ao bi eo su oi ce co jp fi
   o_control <= 
	"0100000000000100" when  s_instruction(2 downto 0) =     "000" else                     -- fetch t0  		 
	"0001100000001000" when  s_instruction(2 downto 0) =     "001" else                     -- fetch t1
	"0100010000000000" when  s_instruction(6 downto 0) = "0001010" else                     -- lda t2
	"0001001000000000" when  s_instruction(6 downto 0) = "0001011" else                     -- lda t3
	"0100010000000000" when  s_instruction(6 downto 0) = "0010010" else                     -- add t2
	"0001000010000000" when  s_instruction(6 downto 0) = "0010011" else                     -- add t3
	"0000001001000001" when  s_instruction(6 downto 0) = "0010100" else                     -- add t4
	"0100010000000000" when  s_instruction(6 downto 0) = "0011010" else                     -- sub t2
	"0001000010000000" when  s_instruction(6 downto 0) = "0011011" else                     -- sub t3
	"0000001001100001" when  s_instruction(6 downto 0) = "0011100" else                     -- sub t4
	"0100010000000000" when  s_instruction(6 downto 0) = "0100010" else                     -- sta t2
	"0010000100000000" when  s_instruction(6 downto 0) = "0100011" else                     -- sta t3
	"0000011000000000" when  s_instruction(6 downto 0) = "0101010" else                     -- ldi t2
	"0000010000000010" when  s_instruction(6 downto 0) = "0110010" else                     -- jmp t2
	"0000010000000010" when (s_instruction(6 downto 0) = "0111010") and (i_cf = '1') else   -- jc t2
	"0000010000000010" when (s_instruction(6 downto 0) = "1000010") and (i_zf = '1') else   -- jz t2
	"0000000100010000" when  s_instruction(6 downto 0) = "1110010" else                     -- out t2
	"1000000000000000" when  s_instruction(6 downto 0) = "1111010" else                     -- halt t2
	"0000000000000000";
	
end behave;
