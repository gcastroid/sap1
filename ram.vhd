library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
   port(
   i_clk: in std_logic;
	i_addr: in std_logic_vector(3 downto 0);
	i_data: in std_logic_vector(7 downto 0);
	i_we: in std_logic;
	i_oe: in std_logic;
	o_data: out std_logic_vector(7 downto 0));
end entity;

architecture behave of ram is 
   
   type ram_array is array (0 to 15) of std_logic_vector(7 downto 0);
   signal ram_data: ram_array := (
   x"e0",  -- 0x0 out
   x"2f",  -- 0x1 add 15
   x"74",  -- 0x2 jc 4
   x"60",  -- 0x3 jmp 0
   x"3f",  -- 0x4 sub 15
   x"e0",  -- 0x5 out
   x"80",  -- 0x6 jz 0
   x"64",  -- 0x7 jmp 4
   x"00", 
   x"00", 
   x"00", 
   x"00", 
   x"00", 
   x"00",
   x"00",
   x"01"); -- 1
	
begin
   
   process(i_clk)
   begin 
      if (rising_edge(i_clk)) then 
         if (i_we = '1') then
            ram_data(to_integer(unsigned(i_addr))) <= i_data;
	      end if;	
      end if;
   end process;
	      
   o_data <= ram_data(to_integer(unsigned(i_addr))) when i_oe = '1' else (others => 'Z');
	
end behave;
