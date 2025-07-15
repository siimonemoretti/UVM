library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity CSB is 
	generic (DCSBS : 	Time := 0 ns;
		DCSBC: 		Time := 0 ns;
		N  :     Integer := 8);
	Port (	A:	In	std_logic_vector(N-1 downto 0);
		B:	In	std_logic_vector(N-1 downto 0);
		Ci:	In	std_logic;
		S:	Out	std_logic_vector(N-1 downto 0));
end CSB; 

architecture STRUCTURAL of CSB is
  constant N_bits: Integer := 4;

  signal STMP1, STMP2 : std_logic_vector(N-1 downto 0);
  component RCA 
  generic (DRCAS : 	Time := 0 ns;
	         DRCAC : 	Time := 0 ns;
		 NBIT  :     Integer := 8);
  Port (	A:	In	std_logic_vector(NBIT-1 downto 0);
		B:	In	std_logic_vector(NBIT-1 downto 0);
		Ci:	In	std_logic;
		S:	Out	std_logic_vector(NBIT-1 downto 0);
		Co:	Out	std_logic);
  end component; 

begin

  S <= STMP1 when Ci='0' else STMP2;
  
  
    FAI1 : RCA
	  generic map (DRCAS => DCSBS, DRCAC => DCSBC, NBIT => N_bits) 
	  Port Map (A, B, '0', STMP1, open); 
 


    FAI2 : RCA
	  generic map (DRCAS => DCSBS, DRCAC => DCSBC, NBIT => N_bits) 
	  Port Map (A, B, '1', STMP2, open); 
  

end STRUCTURAL;



