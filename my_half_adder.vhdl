-- Laboratory GdTi solutions/versuch7
-- Winter Semester 24/25
-- Group Details
-- Lab Date:
-- 1. Participant First and  Last Name: 
-- 2. Participant First and Last Name:
 
 
-- coding conventions
-- g_<name> Generics
-- p_<name> Ports
-- c_<name> Constants
-- s_<name> Signals
-- v_<name> Variables

library ieee;
use ieee.std_logic_1164.all;

entity my_half_adder is
  port (
    -- begin solution:
    P_A         : in  std_logic;
    P_B         : in  std_logic;
    P_SUM       : out std_logic;
    P_CARRY_OUT : out std_logic
    -- end solution!!
  );
end my_half_adder;

	--Notieren Sie ihre Umformungsschritte unter diesem Kommentar:
  
	-- begin solution:
	-- SUM = A xor B
	-- XOR with NAND only:
	-- N1 = A nand B
	-- N2 = A nand N1
	-- N3 = B nand N1
	-- SUM = N2 nand N3
	-- CARRY = A and B = N1 nand N1
	-- end solution!!	

-- dataflow
architecture dataflow of my_half_adder is
signal s_nand_ab : std_logic;
signal s_nand_a  : std_logic;
signal s_nand_b  : std_logic;
  begin
-- begin solution:
  s_nand_ab  <= P_A nand P_B;
  s_nand_a   <= P_A nand s_nand_ab;
  s_nand_b   <= P_B nand s_nand_ab;
  P_SUM      <= s_nand_a nand s_nand_b;
  P_CARRY_OUT <= s_nand_ab nand s_nand_ab;
-- end solution!!
end dataflow;
