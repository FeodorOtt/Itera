# Insurance Claim Handling.
Project has been coded with Delphi 2010 and Microsoft SQL Server 2008 R2. There are only native Delphi components in it with no use of the DB aware controls.

Steps to run the project:

1. Download all the files with folders.
2. Import database by runnig the script "\DB\itera_test.sql" in MS SQL Server Management Studio.
3. Open itera_claims.dpr in Delphi 2010.
4. Compile and run it.
5. Press "Settings" button to set connection to the imported database named "itera_claims" with the standard Windows tool. If for some reasons it doesn't open just edit the connection file "\DB\connection.udl".
6. When connection is established press "Refresh" button or F5 key.
7. If you see the grid filled with the data you've got it!

Steps to run Unit-testing

1. Open "Test\itera_claimsTests.dpr" in Delphi 2010.
2. Compile and run it.
3. Enjoy the tests.
