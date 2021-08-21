library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is 
end entity;

architecture test of alu_tb is
   
   signal inputA: std_logic_vector(7 downto 0) := "11001100";
   signal inputB: std_logic_vector(7 downto 0) := "00110011";
   signal sub: std_logic;
   signal oe: std_logic;
   signal res: std_logic_vector(7 downto 0);
   signal res_bus: std_logic_vector(7 downto 0);
   signal cf: std_logic;
   signal zf: std_logic;
	
   constant t: time := 20 ns;
	
begin

   dut: entity work.alu port map (inputA, inputB, sub, oe, res, res_bus, cf, zf);
	
   -- Control signals
   process
   begin
      sub <= '0';
      oe <= '0';
      wait for t;
      inputB <= "10110011";
      wait for t;
      inputA <= "10110011";
      wait for t;
      sub <= '1';
      wait for t;
      inputA <= "00000011";
      inputB <= "00001111";
      wait for t;
      sub <= '0';
      inputB <= "00000000";
      wait for t;
      inputA <= "00001010";
      wait for t;
      oe <= '1';
      wait;
   end process;
	
end test;
